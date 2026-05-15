-- Camada 1 (HQL): KPIs operacionais por fila de atendimento.
-- Entidades fictícias: Atendimento, FilaAtendimento, Cliente e Analista.

select
    year(a.dataAbertura) as ano,
    month(a.dataAbertura) as mes,
    f.nome as dimensao,
    f.tipo as tipoFila,
    count(distinct a.id) as totalAtendimentos,
    count(distinct c.id) as clientesImpactados,
    count(distinct analista.id) as analistasEnvolvidos,
    sum(case when a.dataResolucao <= a.dataLimiteSla then 1 else 0 end) as atendimentosDentroSla,
    sum(case when a.dataResolucao > a.dataLimiteSla then 1 else 0 end) as atendimentosForaSla,
    round(sum(case when a.dataResolucao <= a.dataLimiteSla then 1 else 0 end) * 100.0 / nullif(count(distinct a.id), 0), 2) as percentualSla,
    avg(timestampdiff(hour, a.dataAbertura, a.dataResolucao)) as tempoMedioResolucaoHoras,
    avg(timestampdiff(minute, a.dataPrimeiroAtendimento, a.dataResolucao)) as tempoMedioTratativaMinutos,
    sum(case when a.reaberto = true then 1 else 0 end) as totalReaberturas,
    avg(coalesce(a.avaliacaoSatisfacao, 0)) as mediaSatisfacao,
    case
        when sum(case when a.dataResolucao <= a.dataLimiteSla then 1 else 0 end) * 100.0 / nullif(count(distinct a.id), 0) >= :limiteSlaAlto then 'ALTO'
        when sum(case when a.dataResolucao <= a.dataLimiteSla then 1 else 0 end) * 100.0 / nullif(count(distinct a.id), 0) >= :limiteSlaMedio then 'MEDIO'
        else 'BAIXO'
    end as classificacaoSla,
    case
        when avg(timestampdiff(hour, a.dataAbertura, a.dataResolucao)) <= :limiteTempoBaixo then 'BAIXO'
        when avg(timestampdiff(hour, a.dataAbertura, a.dataResolucao)) <= :limiteTempoMedio then 'MEDIO'
        else 'ALTO'
    end as classificacaoTempo
from Atendimento a
join a.fila f
left join a.analista analista
left join a.cliente c
where a.dataAbertura between :dataInicial and :dataFinal
  and a.status in (:statusFinalizados)
  and (:filtrarFila = false or f.id in (:filas))
  and (:filtrarTipoFila = false or f.tipo in (:tiposFila))
  and (:considerarSomenteComSla = false or a.dataLimiteSla is not null)
group by
    year(a.dataAbertura),
    month(a.dataAbertura),
    f.nome,
    f.tipo
having
    count(distinct a.id) >= :minimoAtendimentos
order by
    ano,
    mes,
    percentualSla desc,
    tempoMedioResolucaoHoras asc
