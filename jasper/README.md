# JasperReports

Templates `.jrxml` genéricos para relatórios analíticos em formato de dashboard, compatíveis com a proposta de dados do repositório.

Os arquivos demonstram organização visual e técnica de relatórios que podem ser alimentados por DTOs Java (`KpiResult`) ou por listas de mapas vindas de projeções SQL/HQL.

## Padrões dos templates

- Layout em orientação paisagem para leitura executiva e operacional.
- Parâmetros de período (`DATA_INICIAL`, `DATA_FINAL`) e título reutilizável.
- Uso de cards/resumos no relatório para destacar KPIs principais.
- Campos com nomes alinhados aos scripts SQL/HQL e aos getters Java quando aplicável.
- Estrutura preparada para tabelas de detalhe e elementos gráficos.
- Ausência de marca, logotipo, consulta real, datasource real ou informação sensível.

## Arquivos disponíveis

| Arquivo | Finalidade | Métricas/elementos esperados |
| --- | --- | --- |
| `relatorio_kpi_vendas.jrxml` | Relatório executivo de vendas. | Receita, receita líquida, lucro, ticket médio, margem, pedidos, clientes, tabela por período/dimensão e visualizações de apoio. |
| `relatorio_sla_atendimento.jrxml` | Relatório operacional de SLA. | Total de atendimentos, atendimentos dentro do SLA, percentual de SLA, tempo médio, classificação operacional e tabela por fila/dimensão. |

## Integração com Java

Fluxo sugerido:

1. Obter dados via SQL, HQL, serviço ou agregação em memória.
2. Mapear resultados para DTOs ou `Map<String, Object>`.
3. Criar o datasource com `ReportDataSourceFactory`.
4. Preencher parâmetros como título, data inicial e data final.
5. Renderizar o relatório no formato desejado, como PDF, XLSX ou HTML.

Exemplo conceitual:

```java
JRBeanCollectionDataSource dataSource = ReportDataSourceFactory.safeFromKpiResults(kpis);
```

## Campos e aliases

Para reduzir acoplamento, mantenha nomes de campos consistentes entre camadas:

- Vendas: `period`, `dimension`, `revenue`, `cost`, `discount`, `orderCount`, `activeCustomers`, `quantity`, `netRevenue`, `profit`, `averageTicket`, `marginPercentage`.
- SLA: `dimensao`, `totalAtendimentos`, `atendimentosDentroSla`, `percentualSla`, `tempoMedioResolucaoHoras`, `classificacaoSla`.

Ao adaptar o template para uma aplicação real, ajuste os campos no JasperReports Studio de acordo com o datasource final.

## Boas práticas para evolução

- Versionar `.jrxml` fonte e gerar `.jasper` compilado apenas no pipeline ou build da aplicação.
- Evitar consultas embutidas com credenciais no template.
- Parametrizar textos, datas e filtros de negócio.
- Manter subdatasets e campos documentados para facilitar manutenção.
- Validar fontes, margens e quebras de página em exportações PDF e XLSX.

## Privacidade

Os templates são modelos visuais/técnicos sem dados embutidos, sem marcas reais e sem conexão com ambientes corporativos.
