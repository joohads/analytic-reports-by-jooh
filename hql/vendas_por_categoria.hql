-- Análise avançada de receita por categoria de produto em HQL.
-- Exemplo genérico para BI, analytics e dashboards executivos.
-- Objetivo:
--   • Avaliar faturamento por categoria
--   • Medir crescimento temporal
--   • Identificar produtos estratégicos
--   • Calcular ticket médio e margem
--   • Classificar performance comercial
--   • Gerar indicadores gerenciais

select
    p.categoria as categoria,
    p.subcategoria as subcategoria,

    year(v.dataPedido) as ano,
    month(v.dataPedido) as mes,

    count(distinct v.id) as totalPedidos,

    count(distinct c.id) as totalClientes,

    count(distinct p.id) as produtosDistintos,

    sum(
        coalesce(i.quantidade, 0)
    ) as quantidadeVendida,

    sum(
        coalesce(i.quantidade, 0) *
        coalesce(i.valorUnitario, 0)
    ) as receitaBruta,

    sum(
        (
            coalesce(i.quantidade, 0) *
            coalesce(i.valorUnitario, 0)
        ) - coalesce(i.valorDesconto, 0)
    ) as receitaLiquida,

    sum(
        (
            coalesce(i.quantidade, 0) *
            coalesce(i.valorUnitario, 0)
        ) - (
            coalesce(i.quantidade, 0) *
            coalesce(i.custoUnitario, 0)
        )
    ) as lucroEstimado,

    avg(
        (
            coalesce(i.quantidade, 0) *
            coalesce(i.valorUnitario, 0)
        )
    ) as ticketMedioItens,

    avg(v.valorTotal) as ticketMedioPedidos,

    max(v.valorTotal) as maiorPedidoPeriodo,

    min(v.valorTotal) as menorPedidoPeriodo,

    sum(
        case
            when v.tipoFrete = :tipoFreteExpresso
            then 1
            else 0
        end
    ) as pedidosFreteExpresso,

    sum(
        case
            when i.percentualDesconto >= :percentualDescontoAlto
            then 1
            else 0
        end
    ) as itensComDescontoElevado,

    sum(
        case
            when p.ativo = true
            then 1
            else 0
        end
    ) as produtosAtivos,

    sum(
        case
            when p.controlaEstoque = true
            then i.quantidade
            else 0
        end
    ) as volumeControladoEstoque,

    case
        when sum(
            (
                coalesce(i.quantidade, 0) *
                coalesce(i.valorUnitario, 0)
            )
        ) >= :valorCategoriaPremium
            then 'CATEGORIA PREMIUM'

        when sum(
            (
                coalesce(i.quantidade, 0) *
                coalesce(i.valorUnitario, 0)
            )
        ) between :valorCategoriaIntermediariaInicial
            and :valorCategoriaIntermediariaFinal
            then 'CATEGORIA INTERMEDIARIA'

        else 'CATEGORIA PADRAO'
    end as classificacaoReceita,

    case
        when avg(v.valorTotal) >= :ticketAlto
            then 'TICKET ALTO'

        when avg(v.valorTotal) between :ticketMedioInicial
            and :ticketMedioFinal
            then 'TICKET MEDIO'

        else 'TICKET BAIXO'
    end as perfilTicket,

    round(
        (
            sum(
                (
                    coalesce(i.quantidade, 0) *
                    coalesce(i.valorUnitario, 0)
                ) - (
                    coalesce(i.quantidade, 0) *
                    coalesce(i.custoUnitario, 0)
                )
            ) * 100.0
        ) / nullif(
            sum(
                coalesce(i.quantidade, 0) *
                coalesce(i.valorUnitario, 0)
            ),
            0
        ),
        2
    ) as margemPercentual

from Venda v

join v.itens i
join i.produto p
join v.cliente c

where v.status in (
    :statusConcluido,
    :statusFaturado,
    :statusParcial
)

  and v.dataPedido between :dataInicial and :dataFinal

  and (
      :filtrarCategorias = false
      or p.categoria in (:categorias)
  )

  and (
      :filtrarSubcategorias = false
      or p.subcategoria in (:subcategorias)
  )

  and (
      :filtrarClientes = false
      or c.segmento in (:segmentosClientes)
  )

  and (
      :considerarSomenteProdutosAtivos = false
      or p.ativo = true
  )

  and (
      :filtrarValorMinimoPedido = false
      or v.valorTotal >= :valorMinimoPedido
  )

group by
    p.categoria,
    p.subcategoria,
    year(v.dataPedido),
    month(v.dataPedido)

having
    sum(
        coalesce(i.quantidade, 0) *
        coalesce(i.valorUnitario, 0)
    ) >= :receitaMinima

    and count(distinct v.id) >= :minimoPedidos

order by
    ano desc,
    mes desc,
    receitaLiquida desc,
    lucroEstimado desc,
    totalPedidos desc