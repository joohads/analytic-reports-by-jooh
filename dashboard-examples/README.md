# Exemplos de dashboards

Especificações funcionais de painéis de BI documentadas para apoiar entendimento de negócio, priorização de métricas e comunicação com áreas usuárias.

Esta pasta complementa os exemplos técnicos (`SQL`, `HQL`, `Java` e `JasperReports`) com uma visão mais próxima de produto analítico: objetivo do painel, KPIs, visualizações sugeridas e fontes de dados de exemplo.

## Temas disponíveis

| Arquivo | Tema | Foco do painel |
| --- | --- | --- |
| `vendas-executivo.md` | Dashboard executivo de vendas. | Receita, receita líquida, lucro estimado, margem, ticket médio, pedidos e clientes ativos. |
| `operacional-sla.md` | Dashboard operacional de SLA. | Volume de atendimentos, cumprimento de SLA, tempo médio de resolução, funil e ranking de filas. |
| `retencao-clientes.md` | Dashboard de retenção e recorrência. | Coortes, clientes retidos, receita retida, taxa de retenção e recorrência por segmento. |

## Como usar estes documentos

- Como briefing inicial para construir dashboards em Power BI, Tableau, Looker Studio, Metabase, Superset ou outra ferramenta.
- Como base para alinhar KPIs antes da implementação técnica.
- Como referência para mapear quais consultas SQL/HQL e relatórios JasperReports alimentam cada visão.
- Como exemplo de documentação de portfólio, demonstrando raciocínio de produto, dados e visualização.

## Relação com os arquivos técnicos

- `sql/`: exemplos de consultas para preparar métricas em banco relacional/DW.
- `hql/`: versões orientadas a entidades Java para aplicações com Hibernate/JPA.
- `java/`: utilitários e DTOs para cálculo, sumarização e integração com relatórios.
- `jasper/`: templates de relatórios que materializam parte das mesmas métricas.

## Padrões de documentação

Cada dashboard deve responder:

1. Qual problema de negócio o painel monitora?
2. Quais KPIs são essenciais para tomada de decisão?
3. Quais visualizações facilitam leitura rápida?
4. Quais arquivos técnicos podem alimentar a visão?
5. Quais cuidados de privacidade precisam ser preservados?

## Privacidade

Os dashboards são descrições genéricas. Não há prints de sistemas reais, dados de clientes, marcas, nomes internos ou regras confidenciais.
