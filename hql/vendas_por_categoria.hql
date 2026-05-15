-- Camada 1 (HQL): KPIs de vendas por categoria e período.
-- Entidades fictícias: Venda, ItemVenda, Produto e Cliente.
-- Projeção alinhada ao DTO KpiResult e aos templates JasperReports.

select
    year(v.dataPedido) as ano,
    month(v.dataPedido) as mes,
    p.categoria as dimensao,
    count(distinct v.id) as totalPedidos,
    count(distinct c.id) as clientesAtivos,
    sum(coalesce(i.quantidade, 0)) as quantidade,
    sum(coalesce(i.quantidade, 0) * coalesce(i.valorUnitario, 0)) as receitaBruta,
    sum(coalesce(i.valorDesconto, 0)) as descontoTotal,
    sum(coalesce(i.quantidade, 0) * coalesce(i.custoUnitario, 0)) as custoTotal,
    sum((coalesce(i.quantidade, 0) * coalesce(i.valorUnitario, 0)) - coalesce(i.valorDesconto, 0)) as receitaLiquida,
    sum((coalesce(i.quantidade, 0) * coalesce(i.valorUnitario, 0)) - coalesce(i.valorDesconto, 0) - (coalesce(i.quantidade, 0) * coalesce(i.custoUnitario, 0))) as lucroEstimado,
    avg(v.valorTotal) as ticketMedio,
    round(
        sum((coalesce(i.quantidade, 0) * coalesce(i.valorUnitario, 0)) - coalesce(i.valorDesconto, 0) - (coalesce(i.quantidade, 0) * coalesce(i.custoUnitario, 0))) * 100.0
        / nullif(sum((coalesce(i.quantidade, 0) * coalesce(i.valorUnitario, 0)) - coalesce(i.valorDesconto, 0)), 0),
        2
    ) as margemPercentual,
    case
        when sum((coalesce(i.quantidade, 0) * coalesce(i.valorUnitario, 0)) - coalesce(i.valorDesconto, 0)) >= :limiteReceitaAlta then 'ALTO'
        when sum((coalesce(i.quantidade, 0) * coalesce(i.valorUnitario, 0)) - coalesce(i.valorDesconto, 0)) >= :limiteReceitaMedia then 'MEDIO'
        else 'BAIXO'
    end as classificacaoReceita,
    case
        when avg(v.valorTotal) >= :limiteTicketAlto then 'ALTO'
        when avg(v.valorTotal) >= :limiteTicketMedio then 'MEDIO'
        else 'BAIXO'
    end as classificacaoTicket
from Venda v
join v.itens i
join i.produto p
join v.cliente c
where v.status in (:statusValidos)
  and v.dataPedido between :dataInicial and :dataFinal
  and (:filtrarCategorias = false or p.categoria in (:categorias))
  and (:filtrarSegmentos = false or c.segmento in (:segmentos))
  and (:considerarSomenteProdutosAtivos = false or p.ativo = true)
group by
    year(v.dataPedido),
    month(v.dataPedido),
    p.categoria
having
    count(distinct v.id) >= :minimoPedidos
    and sum((coalesce(i.quantidade, 0) * coalesce(i.valorUnitario, 0)) - coalesce(i.valorDesconto, 0)) >= :receitaMinima
order by
    ano,
    mes,
    receitaLiquida desc
