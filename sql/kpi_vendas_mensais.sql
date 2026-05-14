-- KPI: vendas mensais, ticket médio e quantidade de clientes ativos.
-- Modelo genérico para ambientes DW/BI com dimensões e fatos anonimizados.

WITH vendas_mensais AS (
    SELECT
        dt.ano,
        dt.mes,
        SUM(fv.valor_total) AS receita_total,
        COUNT(DISTINCT fv.id_pedido) AS total_pedidos,
        COUNT(DISTINCT fv.id_cliente) AS clientes_ativos
    FROM fato_vendas fv
    INNER JOIN dim_tempo dt
        ON dt.id_tempo = fv.id_tempo
    WHERE fv.status_pedido = 'CONCLUIDO'
    GROUP BY
        dt.ano,
        dt.mes
), comparativo AS (
    SELECT
        ano,
        mes,
        receita_total,
        total_pedidos,
        clientes_ativos,
        receita_total / NULLIF(total_pedidos, 0) AS ticket_medio,
        LAG(receita_total) OVER (ORDER BY ano, mes) AS receita_mes_anterior
    FROM vendas_mensais
)
SELECT
    ano,
    mes,
    receita_total,
    total_pedidos,
    clientes_ativos,
    ticket_medio,
    CASE
        WHEN receita_mes_anterior IS NULL OR receita_mes_anterior = 0 THEN NULL
        ELSE ROUND(((receita_total - receita_mes_anterior) / receita_mes_anterior) * 100, 2)
    END AS variacao_receita_percentual
FROM comparativo
ORDER BY
    ano,
    mes;
