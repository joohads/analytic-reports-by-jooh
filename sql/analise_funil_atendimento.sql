-- Camada 1 (SQL): funil operacional e indicadores de SLA genéricos.
-- Usa apenas fatos e dimensões fictícias para dashboards de atendimento.

WITH eventos AS (
    SELECT
        fa.id_atendimento,
        COALESCE(df.nome_fila, 'GERAL') AS dimensao,
        dc.segmento_cliente,
        MIN(CASE WHEN fa.etapa = 'ABERTO' THEN fa.data_evento END) AS data_abertura,
        MIN(CASE WHEN fa.etapa = 'EM_ANALISE' THEN fa.data_evento END) AS data_analise,
        MIN(CASE WHEN fa.etapa = 'RESOLVIDO' THEN fa.data_evento END) AS data_resolucao,
        MAX(fa.data_limite_sla) AS data_limite_sla
    FROM fato_atendimento fa
    INNER JOIN dim_fila df
        ON df.id_fila = fa.id_fila
    LEFT JOIN dim_cliente dc
        ON dc.id_cliente = fa.id_cliente
    WHERE fa.data_evento BETWEEN :data_inicial AND :data_final
      AND (:filtrar_fila = 0 OR df.nome_fila IN (:filas))
    GROUP BY
        fa.id_atendimento,
        COALESCE(df.nome_fila, 'GERAL'),
        dc.segmento_cliente
), kpi_funil AS (
    SELECT
        dimensao,
        segmento_cliente,
        COUNT(*) AS atendimentos_abertos,
        COUNT(data_analise) AS atendimentos_analisados,
        COUNT(data_resolucao) AS atendimentos_resolvidos,
        SUM(CASE WHEN data_resolucao <= data_limite_sla THEN 1 ELSE 0 END) AS atendimentos_dentro_sla,
        AVG(CAST(data_resolucao AS DATE) - CAST(data_abertura AS DATE)) AS tempo_medio_resolucao_dias
    FROM eventos
    GROUP BY
        dimensao,
        segmento_cliente
)
SELECT
    dimensao,
    segmento_cliente,
    atendimentos_abertos,
    atendimentos_analisados,
    atendimentos_resolvidos,
    atendimentos_dentro_sla,
    ROUND(atendimentos_analisados * 100.0 / NULLIF(atendimentos_abertos, 0), 2) AS taxa_entrada_analise,
    ROUND(atendimentos_resolvidos * 100.0 / NULLIF(atendimentos_abertos, 0), 2) AS taxa_resolucao,
    ROUND(atendimentos_dentro_sla * 100.0 / NULLIF(atendimentos_resolvidos, 0), 2) AS percentual_sla,
    ROUND(tempo_medio_resolucao_dias, 2) AS tempo_medio_resolucao_dias,
    CASE
        WHEN atendimentos_dentro_sla * 100.0 / NULLIF(atendimentos_resolvidos, 0) >= :sla_alto THEN 'ALTO'
        WHEN atendimentos_dentro_sla * 100.0 / NULLIF(atendimentos_resolvidos, 0) >= :sla_medio THEN 'MEDIO'
        ELSE 'BAIXO'
    END AS classificacao_sla
FROM kpi_funil
ORDER BY
    percentual_sla DESC,
    atendimentos_abertos DESC;
