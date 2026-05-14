-- Indicadores avançados de SLA e performance operacional em HQL.
-- Exemplo genérico para portfólio / analytics / dashboards.
-- Objetivo:
--   • Medir eficiência operacional
--   • Avaliar cumprimento de SLA
--   • Identificar gargalos
--   • Calcular tempos médios
--   • Classificar criticidade operacional
--   • Gerar indicadores gerenciais

select
    f.nome as fila,
    f.tipo as tipoFila,
    f.prioridade as prioridadeFila,

    count(distinct a.id) as totalAtendimentos,

    sum(
        case
            when a.dataResolucao <= a.dataLimiteSla
            then 1
            else 0
        end
    ) as atendimentosDentroSla,

    sum(
        case
            when a.dataResolucao > a.dataLimiteSla
            then 1
            else 0
        end
    ) as atendimentosForaSla,

    round(
        (
            sum(
                case
                    when a.dataResolucao <= a.dataLimiteSla
                    then 1
                    else 0
                end
            ) * 100.0
        ) / count(distinct a.id),
        2
    ) as percentualDentroSla,

    avg(
        timestampdiff(
            hour,
            a.dataAbertura,
            a.dataResolucao
        )
    ) as tempoMedioResolucaoHoras,

    max(
        timestampdiff(
            hour,
            a.dataAbertura,
            a.dataResolucao
        )
    ) as maiorTempoResolucao,

    min(
        timestampdiff(
            hour,
            a.dataAbertura,
            a.dataResolucao
        )
    ) as menorTempoResolucao,

    avg(
        timestampdiff(
            minute,
            a.dataPrimeiroAtendimento,
            a.dataResolucao
        )
    ) as tempoMedioTratativaMinutos,

    count(distinct u.id) as totalAnalistasEnvolvidos,

    count(distinct c.id) as totalClientesImpactados,

    sum(
        case
            when a.prioridade = :prioridadeCritica
            then 1
            else 0
        end
    ) as chamadosCriticos,

    sum(
        case
            when a.reaberto = true
            then 1
            else 0
        end
    ) as totalReaberturas,

    avg(
        coalesce(a.avaliacaoSatisfacao, 0)
    ) as mediaSatisfacao,

    case
        when (
            (
                sum(
                    case
                        when a.dataResolucao <= a.dataLimiteSla
                        then 1
                        else 0
                    end
                ) * 100.0
            ) / count(distinct a.id)
        ) >= :percentualExcelente
            then 'EXCELENTE'

        when (
            (
                sum(
                    case
                        when a.dataResolucao <= a.dataLimiteSla
                        then 1
                        else 0
                    end
                ) * 100.0
            ) / count(distinct a.id)
        ) between :percentualBomInicial and :percentualBomFinal
            then 'BOM'

        else 'CRITICO'
    end as classificacaoSla,

    case
        when avg(
            timestampdiff(
                hour,
                a.dataAbertura,
                a.dataResolucao
            )
        ) >= :tempoAltoResolucao
            then 'ALTO TEMPO RESOLUCAO'

        when avg(
            timestampdiff(
                hour,
                a.dataAbertura,
                a.dataResolucao
            )
        ) between :tempoMedioInicial and :tempoMedioFinal
            then 'TEMPO MODERADO'

        else 'RESOLUCAO RAPIDA'
    end as perfilResolucao

from Atendimento a

join a.fila f

left join a.analista u
left join a.cliente c

where a.dataAbertura between :dataInicial and :dataFinal

  and a.status in (:statusFinalizados)

  and (
      :filtrarFila = false
      or f.id in (:filas)
  )

  and (
      :filtrarTipoFila = false
      or f.tipo in (:tiposFila)
  )

  and (
      :filtrarPrioridade = false
      or a.prioridade in (:prioridades)
  )

  and (
      :considerarSomenteAtivos = false
      or a.ativo = true
  )

  and (
      :considerarSomenteComSla = false
      or a.dataLimiteSla is not null
  )

group by
    f.nome,
    f.tipo,
    f.prioridade

having
    count(distinct a.id) >= :minimoAtendimentos

    and avg(
        timestampdiff(
            hour,
            a.dataAbertura,
            a.dataResolucao
        )
    ) <= :tempoMaximoAceitavel

order by
    percentualDentroSla desc,
    atendimentosDentroSla desc,
    tempoMedioResolucaoHoras asc,
    totalAtendimentos desc