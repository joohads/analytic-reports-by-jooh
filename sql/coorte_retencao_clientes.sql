-- Camada 1 (SQL): retenção por coorte de primeira compra.
-- Projeção genérica para matriz de coorte e dashboard de recorrência.

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
        DATE_TRUNC('month', fv.data_pedido) AS mes_compra,
        SUM(COALESCE(fv.valor_bruto, 0) - COALESCE(fv.valor_desconto, 0)) AS receita_liquida
    FROM fato_vendas fv
    INNER JOIN primeira_compra pc
        ON pc.id_cliente = fv.id_cliente
    WHERE fv.status_pedido = 'CONCLUIDO'
      AND fv.data_pedido BETWEEN :data_inicial AND :data_final
    GROUP BY
        fv.id_cliente,
        pc.mes_coorte,
        DATE_TRUNC('month', fv.data_pedido)
), coorte AS (
    SELECT
        mes_coorte,
        mes_compra,
        COUNT(DISTINCT id_cliente) AS clientes_retidos,
        SUM(receita_liquida) AS receita_retida
    FROM compras_cliente
    GROUP BY
        mes_coorte,
        mes_compra
), tamanho_coorte AS (
    SELECT
        mes_coorte,
        COUNT(DISTINCT id_cliente) AS clientes_coorte
    FROM compras_cliente
    WHERE mes_compra = mes_coorte
    GROUP BY mes_coorte
)
SELECT
    c.mes_coorte,
    c.mes_compra,
    EXTRACT(YEAR FROM AGE(c.mes_compra, c.mes_coorte)) * 12
        + EXTRACT(MONTH FROM AGE(c.mes_compra, c.mes_coorte)) AS indice_mes,
    tc.clientes_coorte,
    c.clientes_retidos,
    c.receita_retida,
    ROUND(c.clientes_retidos * 100.0 / NULLIF(tc.clientes_coorte, 0), 2) AS taxa_retencao,
    CASE
        WHEN c.clientes_retidos * 100.0 / NULLIF(tc.clientes_coorte, 0) >= :retencao_alta THEN 'ALTO'
        WHEN c.clientes_retidos * 100.0 / NULLIF(tc.clientes_coorte, 0) >= :retencao_media THEN 'MEDIO'
        ELSE 'BAIXO'
    END AS classificacao_retencao
FROM coorte c
INNER JOIN tamanho_coorte tc
    ON tc.mes_coorte = c.mes_coorte
ORDER BY
    c.mes_coorte,
    indice_mes;
