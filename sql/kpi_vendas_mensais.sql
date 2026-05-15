-- Camada 1 (SQL): KPIs mensais de vendas para um DW genérico.
-- Projeção compatível com KpiResult: period, dimension, revenue, cost,
-- discount, order_count, active_customers e quantity.

WITH base_vendas AS (
    SELECT
        dt.ano,
        dt.mes,
        COALESCE(dp.categoria, 'GERAL') AS dimensao,
        fv.id_pedido,
        fv.id_cliente,
        COALESCE(fv.valor_bruto, 0) AS receita_bruta,
        COALESCE(fv.valor_desconto, 0) AS desconto,
        COALESCE(fv.valor_custo, 0) AS custo,
        COALESCE(fv.quantidade_itens, 0) AS quantidade
    FROM fato_vendas fv
    INNER JOIN dim_tempo dt
        ON dt.id_tempo = fv.id_tempo
    LEFT JOIN dim_produto dp
        ON dp.id_produto = fv.id_produto
    WHERE fv.status_pedido = 'CONCLUIDO'
      AND dt.data_referencia BETWEEN :data_inicial AND :data_final
      AND (:filtrar_categoria = 0 OR dp.categoria IN (:categorias))
), kpi_mensal AS (
    SELECT
        ano,
        mes,
        dimensao,
        SUM(receita_bruta) AS receita_bruta,
        SUM(desconto) AS desconto_total,
        SUM(custo) AS custo_total,
        SUM(quantidade) AS quantidade,
        COUNT(DISTINCT id_pedido) AS total_pedidos,
        COUNT(DISTINCT id_cliente) AS clientes_ativos
    FROM base_vendas
    GROUP BY
        ano,
        mes,
        dimensao
), comparativo AS (
    SELECT
        ano,
        mes,
        dimensao,
        receita_bruta,
        desconto_total,
        custo_total,
        quantidade,
        total_pedidos,
        clientes_ativos,
        receita_bruta - desconto_total AS receita_liquida,
        receita_bruta - desconto_total - custo_total AS lucro_estimado,
        receita_bruta / NULLIF(total_pedidos, 0) AS ticket_medio,
        LAG(receita_bruta) OVER (PARTITION BY dimensao ORDER BY ano, mes) AS receita_mes_anterior
    FROM kpi_mensal
)
SELECT
    ano,
    mes,
    dimensao,
    receita_bruta,
    receita_liquida,
    custo_total,
    desconto_total,
    lucro_estimado,
    total_pedidos,
    clientes_ativos,
    quantidade,
    ROUND(ticket_medio, 2) AS ticket_medio,
    ROUND(receita_liquida / NULLIF(clientes_ativos, 0), 2) AS receita_por_cliente,
    ROUND(lucro_estimado * 100.0 / NULLIF(receita_liquida, 0), 2) AS margem_percentual,
    ROUND((receita_bruta - receita_mes_anterior) * 100.0 / NULLIF(receita_mes_anterior, 0), 2) AS variacao_receita_percentual,
    CASE
        WHEN receita_liquida >= :limite_receita_alta THEN 'ALTO'
        WHEN receita_liquida >= :limite_receita_media THEN 'MEDIO'
        ELSE 'BAIXO'
    END AS classificacao_receita
FROM comparativo
ORDER BY
    ano,
    mes,
    receita_liquida DESC;
