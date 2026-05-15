# HQL

Consultas HQL genéricas para cenários BI em aplicações Java com entidades persistidas.

## Padrão dos exemplos

- Entidades fictícias e reutilizáveis: `Venda`, `ItemVenda`, `Produto`, `Cliente`, `Atendimento`, `FilaAtendimento` e `Analista`.
- Projeções orientadas a KPI: período, dimensão, totalizadores, percentuais, médias e classificações.
- Filtros dinâmicos com parâmetros booleanos para manter os exemplos reutilizáveis em dashboards.
- Aliases em linguagem analítica para facilitar mapeamento para DTOs, `Map<String, Object>` e JasperReports.

## Arquivos

- `vendas_por_categoria.hql`: receita, margem, ticket médio e classificação comercial por categoria.
- `sla_atendimento_por_fila.hql`: SLA, tempos médios e criticidade por fila.
- `retencao_clientes.hql`: recorrência, taxa de conclusão e ticket médio por segmento.
