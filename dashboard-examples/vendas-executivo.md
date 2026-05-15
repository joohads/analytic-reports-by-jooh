# Dashboard executivo de vendas

## Objetivo
Acompanhar desempenho comercial mensal com foco em receita, receita líquida, lucro estimado, margem, volume de pedidos, ticket médio e base ativa.

## KPIs principais

| Indicador | Descrição | Exemplo de origem |
| --- | --- | --- |
| Receita bruta | Soma dos pedidos concluídos antes de desconto | `sql/kpi_vendas_mensais.sql` |
| Receita líquida | Receita bruta menos descontos | `KpiResult#getNetRevenue()` |
| Margem percentual | Lucro estimado dividido pela receita líquida | `KpiResult#getMarginPercentage()` |
| Ticket médio | Receita dividida pelo total de pedidos | `KpiResult#getAverageTicket()` |
| Classificação | Faixa alto/médio/baixo para leitura executiva | `KpiCalculator#classifyByValue()` |

## Visualizações sugeridas

1. Cards para receita, receita líquida, lucro e ticket médio.
2. Linha temporal com evolução de receita e variação percentual.
3. Barras por categoria, canal ou região fictícia.
4. Tabela de detalhe por período e dimensão analítica.

## Fontes de exemplo

- SQL: `sql/kpi_vendas_mensais.sql`
- HQL: `hql/vendas_por_categoria.hql`
- Java: `java/src/main/java/com/example/bi/KpiResult.java`
- Jasper: `jasper/relatorio_kpi_vendas.jrxml`
