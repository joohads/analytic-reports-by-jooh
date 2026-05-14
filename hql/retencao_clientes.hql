-- Relatório analítico de clientes recorrentes por período em HQL.
-- Exemplo genérico para portfólio / estudos.
-- Objetivo:
--   • Identificar clientes recorrentes
--   • Calcular indicadores financeiros
--   • Classificar perfil de compra
--   • Avaliar frequência e ticket médio
--   • Aplicar regras de negócio mais complexas

select
    c.id as idCliente,
    c.nomeFantasia as cliente,
    c.segmento as segmento,
    c.cidade as cidade,
    c.estado as estado,

    count(distinct v.id) as totalPedidos,

    sum(
        coalesce(iv.valorTotal, 0)
    ) as faturamentoTotal,

    avg(
        coalesce(iv.valorTotal, 0)
    ) as ticketMedio,

    min(v.dataPedido) as primeiroPedidoPeriodo,
    max(v.dataPedido) as ultimoPedidoPeriodo,

    count(distinct p.id) as produtosDistintos,

    sum(
        case
            when v.status = :statusConcluido then 1
            else 0
        end
    ) as pedidosConcluidos,

    sum(
        case
            when v.status = :statusCancelado then 1
            else 0
        end
    ) as pedidosCancelados,

    sum(
        case
            when iv.quantidade >= :quantidadeAlta
            then iv.quantidade
            else 0
        end
    ) as volumeItensAltaQuantidade,

    case
        when avg(iv.valorTotal) >= :valorPremium
            then 'PREMIUM'

        when avg(iv.valorTotal) between :valorIntermediarioInicial and :valorIntermediarioFinal
            then 'INTERMEDIARIO'

        else 'PADRAO'
    end as classificacaoCliente,

    case
        when count(distinct v.id) >= :limiteRecorrenciaAlta
            then 'ALTA RECORRENCIA'

        when count(distinct v.id) between :limiteRecorrenciaMediaInicial and :limiteRecorrenciaMediaFinal
            then 'MEDIA RECORRENCIA'

        else 'BAIXA RECORRENCIA'
    end as perfilRecorrencia

from Cliente c

join c.vendas v

left join v.itensVenda iv
left join iv.produto p

where v.dataPedido between :dataInicial and :dataFinal

  and v.status in (
      :statusConcluido,
      :statusFaturado,
      :statusParcial
  )

  and (
      :considerarSomenteAtivos = false
      or c.ativo = true
  )

  and (
      :filtrarSegmento = false
      or c.segmento in (:segmentos)
  )

  and (
      :filtrarEstados = false
      or c.estado in (:estados)
  )

  and (
      :filtrarValorMinimo = false
      or iv.valorTotal >= :valorMinimoItem
  )

group by
    c.id,
    c.nomeFantasia,
    c.segmento,
    c.cidade,
    c.estado

having
    count(distinct v.id) >= :minimoPedidos

    and sum(
        case
            when v.status = :statusConcluido then 1
            else 0
        end
    ) >= :minimoPedidosConcluidos

    and avg(
        coalesce(iv.valorTotal, 0)
    ) >= :ticketMedioMinimo

order by
    faturamentoTotal desc,
    totalPedidos desc,
    ticketMedio desc