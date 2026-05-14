-- Indicadores de SLA por fila operacional em HQL.

select
    a.fila as fila,
    count(a.id) as totalAtendimentos,
    sum(case when a.dataResolucao <= a.dataLimiteSla then 1 else 0 end) as dentroSla,
    avg(timestampdiff(hour, a.dataAbertura, a.dataResolucao)) as tempoMedioResolucaoHoras
from Atendimento a
where a.dataAbertura >= :dataInicial
  and a.dataAbertura < :dataFinal
  and a.status in (:statusFinalizados)
group by a.fila
order by dentroSla desc
