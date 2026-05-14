-- Receita por categoria de produto usando HQL e projeção agregada.

select
    p.categoria as categoria,
    year(v.dataPedido) as ano,
    month(v.dataPedido) as mes,
    sum(i.quantidade * i.valorUnitario) as receita,
    count(distinct v.id) as pedidos
from Venda v
join v.itens i
join i.produto p
where v.status = :statusConcluido
  and v.dataPedido between :dataInicial and :dataFinal
group by
    p.categoria,
    year(v.dataPedido),
    month(v.dataPedido)
order by
    ano,
    mes,
    receita desc
