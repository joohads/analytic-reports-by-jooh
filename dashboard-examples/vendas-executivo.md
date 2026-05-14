# Dashboard executivo de vendas

## Objetivo
Acompanhar desempenho comercial mensal com foco em receita, volume de pedidos, ticket médio e base ativa.

## KPIs principais

| Indicador | Descrição | Exemplo de origem |
| --- | --- | --- |
| Receita total | Soma de pedidos concluídos | `sql/kpi_vendas_mensais.sql` |
| Ticket médio | Receita dividida pelo total de pedidos | `KpiResult#getAverageTicket()` |
| Clientes ativos | Clientes distintos com compra no período | `fato_vendas.id_cliente` |
| Variação mensal | Comparação percentual contra mês anterior | CTE `comparativo` |

## Visualizações sugeridas

1. Cards para receita, pedidos, clientes ativos e ticket médio.
2. Linha temporal com evolução de receita.
3. Barras por categoria, canal ou região fictícia.
4. Tabela com ranking de produtos ou segmentos genéricos.

## Observações de privacidade

Não exibir CPF, e-mail, telefone, contrato, endereço ou qualquer identificador pessoal. Em análises por cliente, usar chaves técnicas anonimizadas ou agregações por segmento.
