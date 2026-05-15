# SQL

Exemplos genéricos e anonimizados de consultas analíticas para BI.

## Convenções

- Tabelas e colunas usam nomes fictícios, como `dim_cliente`, `dim_produto`, `dim_tempo`, `dim_fila`, `fato_vendas` e `fato_atendimento`.
- Nenhum script contém dados pessoais reais, nomes de empresas, identificadores internos ou informações confidenciais.
- Os exemplos priorizam CTEs, janelas analíticas, `NULLIF` para divisões seguras e aliases consistentes com dashboards.
- Métricas derivadas usam nomenclatura padronizada: `receita_liquida`, `lucro_estimado`, `ticket_medio`, `margem_percentual`, `taxa_retencao` e `classificacao_*`.

## Arquivos

- `kpi_vendas_mensais.sql`: KPIs mensais de vendas com margem, ticket médio e variação percentual.
- `analise_funil_atendimento.sql`: funil operacional e SLA por dimensão de atendimento.
- `coorte_retencao_clientes.sql`: matriz de coorte com retenção e receita retida.
