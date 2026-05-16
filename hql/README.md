# HQL

Esta pasta contém consultas HQL de exemplo para cenários de BI em aplicações Java com entidades persistidas. As entidades, atributos e relacionamentos são fictícios e servem como referência de modelagem analítica.

## Convenções usadas

- Entidades exemplificadas: `Venda`, `ItemVenda`, `Produto`, `Cliente`, `Atendimento`, `FilaAtendimento` e `Analista`.
- As consultas usam parâmetros nomeados, como `:dataInicial`, `:dataFinal`, `:statusValidos`, `:categorias`, `:segmentos` e limites de classificação.
- Os aliases seguem uma linguagem próxima à de dashboards e DTOs, facilitando mapeamento para `Map<String, Object>`, projections, DTOs ou JasperReports.
- Há filtros dinâmicos controlados por parâmetros booleanos para manter os exemplos reutilizáveis.
- Os arquivos não dependem de um ORM configurado neste repositório; a sintaxe deve ser ajustada conforme as entidades reais da aplicação.

## Arquivos

| Arquivo | Finalidade | Principais métricas |
| --- | --- | --- |
| `vendas_por_categoria.hql` | KPIs comerciais por ano, mês e categoria. | Receita bruta/líquida, custo, desconto, pedidos, clientes ativos, quantidade, ticket médio, margem e classificações de receita/ticket. |
| `sla_atendimento_por_fila.hql` | Indicadores operacionais por fila de atendimento. | Volume de atendimentos, clientes impactados, itens dentro/fora do SLA, percentual de SLA, tempo médio e criticidade. |
| `retencao_clientes.hql` | Recorrência e retenção por segmento. | Clientes, pedidos concluídos, receita líquida, ticket médio, taxa de conclusão, dias desde a primeira compra e classificação de recorrência. |

## Relação com outras pastas

- As consultas SQL em `sql/` representam versões orientadas a DW/tabelas fictícias.
- O módulo `java/` fornece utilitários para calcular e empacotar métricas em memória.
- Os templates em `jasper/` podem receber coleções de DTOs ou mapas com aliases equivalentes.
