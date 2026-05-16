# SQL

Esta pasta reúne consultas SQL genéricas e anonimizadas para cenários de Business Intelligence. Os arquivos foram escritos como exemplos de projeções analíticas, não como scripts prontos para executar sem adaptação.

## Convenções usadas

- Tabelas e colunas são fictícias e seguem uma ideia de DW simples, como `fato_vendas`, `fato_atendimento`, `dim_tempo`, `dim_produto`, `dim_cliente` e `dim_fila`.
- Os scripts usam parâmetros nomeados, por exemplo `:data_inicial`, `:data_final`, `:categorias`, `:sla_alto` e `:retencao_media`.
- As consultas priorizam CTEs, agregações, aliases analíticos, `NULLIF` para divisões seguras e classificações por faixa.
- Alguns recursos podem exigir adaptação conforme o banco utilizado, especialmente funções como `DATE_TRUNC`, `AGE`, `EXTRACT`, cálculos entre datas e sintaxe de parâmetros.
- Nenhum arquivo contém carga de dados, credencial, string de conexão ou referência a uma base real.

## Arquivos

| Arquivo | Finalidade | Principais saídas |
| --- | --- | --- |
| `kpi_vendas_mensais.sql` | KPIs mensais de vendas por dimensão/categoria. | Receita bruta, receita líquida, desconto, custo, lucro estimado, pedidos, clientes ativos, quantidade, ticket médio, margem e variação percentual. |
| `analise_funil_atendimento.sql` | Funil operacional e SLA por fila/segmento. | Atendimentos abertos, analisados, resolvidos, dentro do SLA, taxas de entrada/resolução, percentual de SLA e tempo médio. |
| `coorte_retencao_clientes.sql` | Retenção por coorte de primeira compra. | Mês de coorte, mês de compra, índice relativo do mês, clientes da coorte, clientes retidos, receita retida, taxa e classificação de retenção. |

## Relação com outras pastas

- Os conceitos de vendas dialogam com `hql/vendas_por_categoria.hql`, `dashboard-examples/vendas-executivo.md` e `jasper/relatorio_kpi_vendas.jrxml`.
- Os conceitos de atendimento/SLA dialogam com `hql/sla_atendimento_por_fila.hql`, `dashboard-examples/operacional-sla.md` e `jasper/relatorio_sla_atendimento.jrxml`.
- A análise de retenção dialoga com `hql/retencao_clientes.hql` e `dashboard-examples/retencao-clientes.md`.
