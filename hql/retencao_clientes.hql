-- Camada 1 (HQL): recorrência de clientes por segmento e período.
-- Entidades fictícias: Cliente, Venda, ItemVenda e Produto.

select
    year(v.dataPedido) as ano,
    month(v.dataPedido) as mes,
    c.segmento as dimensao,
    count(distinct c.id) as clientesAtivos,
    count(distinct v.id) as totalPedidos,
    count(distinct p.id) as produtosDistintos,
    min(v.dataPedido) as primeiraCompraPeriodo,
    max(v.dataPedido) as ultimaCompraPeriodo,
    sum(coalesce(iv.valorTotal, 0)) as receitaTotal,
    avg(coalesce(iv.valorTotal, 0)) as ticketMedio,
    sum(case when v.status = :statusConcluido then 1 else 0 end) as pedidosConcluidos,
    sum(case when v.status = :statusCancelado then 1 else 0 end) as pedidosCancelados,
    round(sum(case when v.status = :statusConcluido then 1 else 0 end) * 100.0 / nullif(count(distinct v.id), 0), 2) as taxaConclusao,
    case
        when count(distinct v.id) >= :limiteRecorrenciaAlta then 'ALTO'
        when count(distinct v.id) >= :limiteRecorrenciaMedia then 'MEDIO'
        else 'BAIXO'
    end as classificacaoRecorrencia,
    case
        when avg(coalesce(iv.valorTotal, 0)) >= :limiteTicketAlto then 'ALTO'
        when avg(coalesce(iv.valorTotal, 0)) >= :limiteTicketMedio then 'MEDIO'
        else 'BAIXO'
    end as classificacaoTicket
from Cliente c
join c.vendas v
left join v.itensVenda iv
left join iv.produto p
where v.dataPedido between :dataInicial and :dataFinal
  and v.status in (:statusValidos)
  and (:considerarSomenteAtivos = false or c.ativo = true)
  and (:filtrarSegmentos = false or c.segmento in (:segmentos))
  and (:filtrarEstados = false or c.estado in (:estados))
group by
    year(v.dataPedido),
    month(v.dataPedido),
    c.segmento
having
    count(distinct v.id) >= :minimoPedidos
    and avg(coalesce(iv.valorTotal, 0)) >= :ticketMedioMinimo
order by
    ano,
    mes,
    receitaTotal desc,
    totalPedidos desc
