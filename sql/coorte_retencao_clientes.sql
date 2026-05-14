-- KPI: retenção por coorte de primeira compra.
-- Exemplo genérico para entender recorrência sem expor clientes reais.

WITH primeira_compra AS (
    SELECT
        id_cliente,
        DATE_TRUNC('month', MIN(data_pedido)) AS mes_coorte
    FROM fato_vendas
    WHERE status_pedido = 'CONCLUIDO'
    GROUP BY id_cliente
), compras_cliente AS (
    SELECT
        fv.id_cliente,
        pc.mes_coorte,
        DATE_TRUNC('month', fv.data_pedido) AS mes_compra
    FROM fato_vendas fv
    INNER JOIN primeira_compra pc
        ON pc.id_cliente = fv.id_cliente
    WHERE fv.status_pedido = 'CONCLUIDO'
), coorte AS (
    SELECT
        mes_coorte,
        mes_compra,
        COUNT(DISTINCT id_cliente) AS clientes_retidos
    FROM compras_cliente
    GROUP BY
        mes_coorte,
        mes_compra
)
SELECT
    mes_coorte,
    mes_compra,
    EXTRACT(YEAR FROM AGE(mes_compra, mes_coorte)) * 12
        + EXTRACT(MONTH FROM AGE(mes_compra, mes_coorte)) AS indice_mes,
    clientes_retidos
FROM coorte
ORDER BY
    mes_coorte,
    indice_mes;
