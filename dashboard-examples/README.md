# Dashboard examples

Esta pasta documenta ideias de dashboards baseadas nos exemplos técnicos do repositório. Os arquivos descrevem objetivo, KPIs, visualizações sugeridas e fontes de dados/código relacionadas.

Eles não são dashboards executáveis em uma ferramenta específica. O conteúdo serve como especificação funcional e ponto de partida para implementação em BI tools, aplicações web, relatórios JasperReports ou notebooks.

## Arquivos

| Arquivo | Tema | Fontes relacionadas |
| --- | --- | --- |
| `vendas-executivo.md` | Visão executiva de vendas, receita, margem, pedidos, ticket médio e clientes ativos. | `sql/kpi_vendas_mensais.sql`, `hql/vendas_por_categoria.hql`, `java/src/main/java/com/example/bi/KpiResult.java`, `jasper/relatorio_kpi_vendas.jrxml` |
| `operacional-sla.md` | Acompanhamento de filas, produtividade, resolução e SLA. | `sql/analise_funil_atendimento.sql`, `hql/sla_atendimento_por_fila.hql`, `jasper/relatorio_sla_atendimento.jrxml` |
| `retencao-clientes.md` | Coortes, recorrência, segmentos e receita retida. | `sql/coorte_retencao_clientes.sql`, `hql/retencao_clientes.hql` |

## Como usar

1. Escolha o tema do painel.
2. Consulte as métricas e visualizações sugeridas no arquivo correspondente.
3. Use as consultas SQL/HQL como referência para obter os dados.
4. Use o módulo Java e os templates JasperReports se a implementação for em Java/Jasper.
