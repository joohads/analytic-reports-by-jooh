-- KPI: acompanhamento de etapas de atendimento em um funil operacional genérico.
-- Útil para dashboards de produtividade, SLA e conversão por etapa.

WITH etapas AS (
    SELECT
        fa.id_atendimento,
        dc.segmento_cliente,
        MIN(CASE WHEN fa.etapa = 'ABERTO' THEN fa.data_evento END) AS data_abertura,
        MIN(CASE WHEN fa.etapa = 'EM_ANALISE' THEN fa.data_evento END) AS data_analise,
        MIN(CASE WHEN fa.etapa = 'RESOLVIDO' THEN fa.data_evento END) AS data_resolucao
    FROM fato_atendimento fa
    INNER JOIN dim_cliente dc
        ON dc.id_cliente = fa.id_cliente
    WHERE fa.data_evento >= DATE '2026-01-01'
    GROUP BY
        fa.id_atendimento,
        dc.segmento_cliente
)
SELECT
    segmento_cliente,
    COUNT(*) AS atendimentos_abertos,
    COUNT(data_analise) AS atendimentos_analisados,
    COUNT(data_resolucao) AS atendimentos_resolvidos,
    ROUND(COUNT(data_analise) * 100.0 / NULLIF(COUNT(*), 0), 2) AS taxa_entrada_analise,
    ROUND(COUNT(data_resolucao) * 100.0 / NULLIF(COUNT(*), 0), 2) AS taxa_resolucao,
    AVG(CAST(data_resolucao AS DATE) - CAST(data_abertura AS DATE)) AS tempo_medio_resolucao_dias
FROM etapas
GROUP BY
    segmento_cliente
ORDER BY
    taxa_resolucao DESC;
