# Dashboard operacional de SLA

## Objetivo
Monitorar a eficiência operacional de filas de atendimento sem expor informações pessoais ou detalhes internos de processos reais.

## KPIs principais

| Indicador | Descrição |
| --- | --- |
| Atendimentos abertos | Total de registros iniciados no período |
| Taxa de resolução | Percentual de registros concluídos |
| SLA cumprido | Percentual de registros resolvidos dentro do prazo |
| Tempo médio de resolução | Média entre abertura e resolução |

## Visualizações sugeridas

- Funil de etapas: aberto, em análise e resolvido.
- Heatmap por dia da semana e hora de abertura.
- Ranking de filas por cumprimento de SLA.
- Série temporal do tempo médio de resolução.

## Fontes de exemplo

- SQL: `sql/analise_funil_atendimento.sql`
- HQL: `hql/sla_atendimento_por_fila.hql`
- Jasper: `jasper/relatorio_sla_atendimento.jrxml`
