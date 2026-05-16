# analytic-reports-by-jooh

Repositório de exemplos técnicos para **Business Intelligence, Analytics e relatórios operacionais**, combinando consultas SQL, consultas HQL, utilitários Java 8, templates JasperReports e descrições de dashboards.

O conteúdo é demonstrativo, genérico e anonimizado. A proposta é documentar padrões reutilizáveis para criação de indicadores, projeções analíticas e relatórios sem depender de um banco, sistema interno ou massa de dados real.

## O que existe neste repositório

- Consultas **SQL** para KPIs mensais de vendas, funil operacional de atendimento e coorte de retenção.
- Consultas **HQL** equivalentes para cenários em aplicações Java com entidades fictícias.
- Um módulo **Java 8/Maven** com DTO, cálculos de KPI e factories para `JRBeanCollectionDataSource`.
- Templates **JasperReports (`.jrxml`)** para relatórios de vendas e SLA.
- Documentos de **dashboards de exemplo** descrevendo objetivos, KPIs, visualizações sugeridas e fontes.
- Diretrizes de privacidade e anonimização para manter os exemplos sem dados sensíveis.

## Estrutura atual

```text
.
├── README.md
├── dashboard-examples/
│   ├── README.md
│   ├── operacional-sla.md
│   ├── retencao-clientes.md
│   └── vendas-executivo.md
├── docs/
│   └── privacidade-e-anonimizacao.md
├── hql/
│   ├── README.md
│   ├── retencao_clientes.hql
│   ├── sla_atendimento_por_fila.hql
│   └── vendas_por_categoria.hql
├── jasper/
│   ├── README.md
│   ├── relatorio_kpi_vendas.jrxml
│   └── relatorio_sla_atendimento.jrxml
├── java/
│   ├── README.md
│   ├── pom.xml
│   └── src/main/java/com/example/bi/
│       ├── KpiCalculator.java
│       ├── KpiResult.java
│       └── ReportDataSourceFactory.java
└── sql/
    ├── README.md
    ├── analise_funil_atendimento.sql
    ├── coorte_retencao_clientes.sql
    └── kpi_vendas_mensais.sql
```

## Como as partes se conectam

1. **SQL (`sql/`)**: representa uma camada analítica sobre tabelas fictícias de DW, como `fato_vendas`, `fato_atendimento`, `dim_tempo`, `dim_produto`, `dim_cliente` e `dim_fila`.
2. **HQL (`hql/`)**: mostra como consultas semelhantes poderiam ser escritas sobre entidades fictícias de domínio, como `Venda`, `ItemVenda`, `Produto`, `Cliente`, `Atendimento`, `FilaAtendimento` e `Analista`.
3. **Java (`java/`)**: concentra objetos e utilitários para tratar resultados de KPI em memória:
   - `KpiResult`: DTO imutável para período, dimensão, receita, custo, desconto, volume e métricas derivadas.
   - `KpiCalculator`: métodos estáticos para divisão segura, percentual, ticket médio, margem, variação, classificação e agregação.
   - `ReportDataSourceFactory`: criação de `JRBeanCollectionDataSource` a partir de listas de DTOs, mapas ou coleções.
4. **JasperReports (`jasper/`)**: contém templates `.jrxml` genéricos para consumo de datasets compatíveis com os aliases/documentos do repositório.
5. **Dashboards (`dashboard-examples/`)**: documenta painéis esperados e aponta para as consultas, classes e templates que podem alimentá-los.

## Requisitos para o módulo Java

- JDK compatível com Java 8 ou superior.
- Maven.
- A dependência principal declarada é `net.sf.jasperreports:jasperreports:6.21.3`.

Para compilar o módulo Java:

```bash
mvn -f java/pom.xml test
```

> O repositório atualmente contém código-fonte e templates, mas não inclui base de dados, fixtures, dumps, credenciais, testes automatizados próprios ou scripts de execução de relatórios.

## Privacidade e anonimização

Todos os exemplos usam nomenclatura fictícia e agregada. Não há dados pessoais, credenciais, strings de conexão, dumps de banco ou nomes reais de empresas/clientes.

Consulte [`docs/privacidade-e-anonimizacao.md`](docs/privacidade-e-anonimizacao.md) para as diretrizes aplicadas e cuidados recomendados em contribuições futuras.
