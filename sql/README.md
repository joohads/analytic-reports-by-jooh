# SQL analítico

Consultas SQL genéricas e anonimizadas para cenários de **Business Intelligence**, organizadas como exemplos de camada analítica para um Data Warehouse fictício.

Os scripts demonstram como transformar tabelas fato/dimensão em indicadores prontos para dashboards, relatórios JasperReports ou consumo por aplicações Java.

## Padrões técnicos adotados

- Uso de CTEs (`WITH`) para separar etapas de preparação, agregação e apresentação.
- Tabelas e colunas fictícias, como `fato_vendas`, `fato_atendimento`, `dim_cliente`, `dim_produto`, `dim_tempo` e `dim_fila`.
- Filtros parametrizados com placeholders como `:data_inicial`, `:data_final`, `:categorias` e `:filas`.
- Divisões seguras com `NULLIF` para evitar erro por denominador zero.
- Tratamento de nulos com `COALESCE` em métricas financeiras e volumetria.
- Aliases em português de negócio para facilitar leitura por analistas, dashboards e relatórios.
- Classificações parametrizadas (`ALTO`, `MEDIO`, `BAIXO`) para destacar performance sem acoplar regras proprietárias.

## Arquivos disponíveis

| Arquivo | Cenário | Principais saídas |
| --- | --- | --- |
| `kpi_vendas_mensais.sql` | Performance comercial mensal por dimensão/categoria. | Receita bruta, receita líquida, custo, desconto, lucro estimado, pedidos, clientes ativos, quantidade, ticket médio, receita por cliente, margem percentual, variação mensal e classificação de receita. |
| `analise_funil_atendimento.sql` | Funil operacional e SLA por fila/segmento. | Atendimentos abertos, analisados, resolvidos, dentro do SLA, taxas de etapa, percentual de SLA, tempo médio de resolução e classificação de SLA. |
| `coorte_retencao_clientes.sql` | Retenção de clientes por coorte de primeira compra. | Mês de coorte, mês de compra, índice de mês relativo, tamanho da coorte, clientes retidos, receita retida, taxa de retenção e classificação de retenção. |

## Como adaptar

1. Substitua tabelas e colunas fictícias pelo modelo físico do seu banco.
2. Ajuste funções específicas do dialeto SQL, especialmente datas (`DATE_TRUNC`, `AGE`, `EXTRACT`) e diferenças entre datas.
3. Mantenha os aliases finais estáveis quando a consulta alimentar dashboards ou templates JasperReports.
4. Externalize limites de classificação como parâmetros para permitir reuso por cenário.
5. Valide performance com índices nas chaves de data, status, cliente, produto, fila e dimensões de filtro.

## Relação com os demais módulos

- `hql/` contém versões orientadas a entidades Java/Hibernate para cenários semelhantes.
- `java/` contém DTOs e utilitários que podem receber resultados equivalentes às projeções SQL.
- `jasper/` contém templates que consomem campos e métricas compatíveis com esses aliases.
- `dashboard-examples/` documenta a leitura de negócio desses indicadores.

## Privacidade

Nenhum script contém dados reais, inserts, credenciais, nomes de empresas, strings de conexão ou informações pessoais. O conteúdo é exclusivamente estrutural e demonstrativo.
