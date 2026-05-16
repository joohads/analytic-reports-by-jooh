# HQL analítico

Consultas HQL genéricas para aplicações Java com Hibernate/JPA que precisam gerar **projeções de KPI** a partir de entidades persistidas.

A proposta desta pasta é demonstrar a tradução de necessidades de BI para uma camada orientada a domínio, preservando filtros dinâmicos, aliases de negócio e métricas prontas para DTOs, mapas ou relatórios.

## Entidades fictícias usadas

Os exemplos usam nomes genéricos e não representam nenhum sistema real:

- `Venda`, `ItemVenda`, `Produto` e `Cliente` para cenários comerciais e retenção.
- `Atendimento`, `FilaAtendimento`, `Analista` e `Cliente` para cenários operacionais de SLA.

## Padrões dos exemplos

- Projeções com aliases analíticos, como `receitaLiquida`, `ticketMedio`, `percentualSla`, `taxaConclusao` e `classificacaoRecorrencia`.
- Filtros dinâmicos com parâmetros booleanos, por exemplo `:filtrarCategorias`, `:filtrarSegmentos` e `:considerarSomenteAtivos`.
- Agregações por período usando `year(...)` e `month(...)`.
- Métricas financeiras com `coalesce` para reduzir impacto de valores nulos.
- Classificações de performance (`ALTO`, `MEDIO`, `BAIXO`) controladas por parâmetros.
- `having` para garantir volume mínimo antes de exibir uma dimensão no resultado.

## Arquivos disponíveis

| Arquivo | Cenário | Principais saídas |
| --- | --- | --- |
| `vendas_por_categoria.hql` | KPIs comerciais por categoria e período. | Ano, mês, dimensão, pedidos, clientes ativos, quantidade, receita bruta, descontos, custos, receita líquida, lucro estimado, ticket médio, margem percentual e classificações. |
| `sla_atendimento_por_fila.hql` | Indicadores operacionais por fila de atendimento. | Total de atendimentos, clientes impactados, analistas, dentro/fora do SLA, percentual de SLA, tempos médios, reaberturas, satisfação e classificações. |
| `retencao_clientes.hql` | Recorrência por segmento e período. | Clientes ativos, pedidos, produtos distintos, primeira/última compra, receita, ticket médio, conclusão/cancelamento, taxa de conclusão e classificações. |

## Integração sugerida

1. Execute a HQL no repositório/DAO da aplicação com parâmetros externos.
2. Retorne os resultados como DTO de projeção, `Tuple`, `Object[]` ou `Map<String, Object>`.
3. Converta os resultados para estruturas compatíveis com `KpiResult` ou para uma lista de mapas.
4. Use `ReportDataSourceFactory` para alimentar JasperReports quando necessário.
5. Reutilize os mesmos aliases em dashboards, relatórios e documentação funcional.

## Observações de portabilidade

Algumas funções, como `timestampdiff`, `year`, `month`, `round` e `nullif`, podem variar conforme versão do Hibernate e dialeto configurado. Ao aplicar em um projeto real, valide a função equivalente para o banco de dados utilizado.

## Privacidade

As consultas não incluem dados reais, nomes internos, tabelas proprietárias ou regras confidenciais. São exemplos de estrutura, nomenclatura e raciocínio analítico.
