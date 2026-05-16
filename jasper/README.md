# JasperReports

Esta pasta contém templates `.jrxml` genéricos para relatórios analíticos em formato paisagem. Eles foram criados como referência visual/estrutural para dashboards impressos ou exportáveis, sem consultas embutidas, logotipos, marcas ou dados reais.

## Convenções dos templates

- Relatórios em orientação `Landscape`.
- Parâmetros de período: `DATA_INICIAL` e `DATA_FINAL`.
- Parâmetro `TITULO_RELATORIO` com valor padrão em cada template.
- Campos e variáveis voltados a KPIs, tabelas resumidas, cards e classificações.
- Uso esperado com `JRBeanCollectionDataSource`, que pode ser criado pelo módulo `java/`.
- Os nomes dos campos podem exigir adaptação conforme a origem dos dados usada pela aplicação.

## Arquivos

| Arquivo | Objetivo | Campos/indicadores esperados |
| --- | --- | --- |
| `relatorio_kpi_vendas.jrxml` | Dashboard executivo de vendas. | Período, dimensão, receita, custo, desconto, pedidos, clientes ativos, quantidade, receita líquida, lucro, ticket médio, margem e classificação. |
| `relatorio_sla_atendimento.jrxml` | Dashboard operacional de atendimento/SLA. | Período, fila/dimensão, tipo de fila, total de atendimentos, clientes impactados, dentro/fora do SLA, percentual de SLA, tempo médio e classificação. |

## Relação com o restante do repositório

- `sql/` e `hql/` mostram exemplos de consultas que podem originar os dados.
- `java/src/main/java/com/example/bi/ReportDataSourceFactory.java` centraliza a criação de `JRBeanCollectionDataSource`.
- `dashboard-examples/` descreve como esses relatórios se encaixam em visões executivas e operacionais.
