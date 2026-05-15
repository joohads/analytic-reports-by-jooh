# Dashboard operacional de SLA

## Objetivo
Monitorar eficiência operacional de filas de atendimento sem expor informações pessoais ou detalhes internos de processos reais.

## KPIs principais

| Indicador | Descrição |
| --- | --- |
| Atendimentos abertos | Total de registros iniciados no período |
| Atendimentos dentro do SLA | Registros resolvidos até o limite acordado |
| Percentual de SLA | Atendimentos dentro do SLA divididos pelo total resolvido |
| Tempo médio de resolução | Média entre abertura e resolução |
| Classificação SLA | Alto, médio ou baixo conforme limite parametrizado |

## Visualizações sugeridas

- Cards para volume, dentro do SLA, fora do SLA e SLA geral.
- Funil de etapas: aberto, em análise e resolvido.
- Ranking de filas por cumprimento de SLA.
- Série temporal do tempo médio de resolução.

## Fontes de exemplo

- SQL: `sql/analise_funil_atendimento.sql`
- HQL: `hql/sla_atendimento_por_fila.hql`
- Jasper: `jasper/relatorio_sla_atendimento.jrxml`
