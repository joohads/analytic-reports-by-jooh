-- Clientes recorrentes por período em HQL.

select
    c.segmento as segmento,
    count(distinct c.id) as clientesRecorrentes
from Cliente c
join c.vendas v
where v.status = :statusConcluido
  and v.dataPedido between :dataInicial and :dataFinal
group by c.segmento
having count(distinct v.id) >= :minimoPedidos
order by clientesRecorrentes desc
