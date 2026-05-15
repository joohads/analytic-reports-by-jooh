# JasperReports

Templates `.jrxml` genéricos para relatórios analíticos em formato de dashboard.

## Padrão dos templates

- Layout em formato paisagem para uso executivo e operacional.
- Parâmetros de período (`DATA_INICIAL`, `DATA_FINAL`) e título reutilizável.
- Cards de KPIs no `summary`.
- Tabela detalhada com aliases compatíveis com DTOs Java ou projeções `Map<String, Object>`.
- Subdatasets documentados para extensão e componentes gráficos de apoio.
- Nenhuma marca, logotipo, consulta real ou dado sensível.

## Arquivos

- `relatorio_kpi_vendas.jrxml`: dashboard executivo com receita, receita líquida, lucro, ticket médio, tabela e gráficos.
- `relatorio_sla_atendimento.jrxml`: dashboard operacional com volume, SLA, tempo médio, tabela e gráficos.
