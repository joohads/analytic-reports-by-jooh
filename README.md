# analytic-reports-by-jooh

Portfólio técnico de **Business Intelligence, Analytics Engineering e geração de relatórios** com exemplos anonimizados em **SQL, HQL, Java 8, JasperReports e documentação de dashboards**.

O repositório demonstra como estruturar uma solução analítica ponta a ponta: consultas de agregação, projeções para aplicações Java, DTOs de KPI, factories de datasource para JasperReports, templates `.jrxml` e especificações funcionais de painéis executivos/operacionais.

> Todos os exemplos são fictícios, genéricos e anonimizados. Não há dados reais, credenciais, dumps, nomes de empresas, identificadores internos ou informações pessoais.

## Objetivo do repositório

Este projeto foi organizado como uma vitrine prática para demonstrar competências em:

- Modelagem de indicadores de negócio para vendas, atendimento/SLA e retenção.
- Escrita de consultas analíticas com CTEs, agregações, filtros parametrizáveis, janelas analíticas e divisões seguras.
- Construção de projeções HQL para aplicações Java com entidades persistidas.
- Implementação de uma camada Java simples para padronizar métricas, classificações e datasources de relatórios.
- Criação de templates JasperReports reutilizáveis para relatórios executivos e operacionais.
- Documentação de dashboards com KPIs, objetivos, visualizações e fontes técnicas.
- Boas práticas de anonimização para transformar experiências reais em material público de portfólio.

## Visão geral da arquitetura

```text
SQL/HQL parametrizado
        │
        ▼
Projeções analíticas: período, dimensão, volume, valores e classificações
        │
        ▼
Java 8: KpiResult, KpiCalculator e ReportDataSourceFactory
        │
        ├── JasperReports: templates .jrxml para relatórios tabulares e visuais
        └── Dashboard specs: documentação de painéis e indicadores
```

### Camadas principais

| Camada | Diretório | Papel no portfólio |
| --- | --- | --- |
| SQL analítico | `sql/` | Consultas para DW genérico com fatos, dimensões, CTEs, métricas e parâmetros. |
| HQL | `hql/` | Projeções para aplicações Java/Hibernate com entidades fictícias e aliases analíticos. |
| Java 8 | `java/` | Mini framework de apoio para DTOs, cálculos de KPI, sumarização e datasources JasperReports. |
| JasperReports | `jasper/` | Templates `.jrxml` de relatórios executivos e operacionais. |
| Dashboards | `dashboard-examples/` | Especificações funcionais de painéis por tema de negócio. |
| Governança | `docs/` | Diretrizes de privacidade, anonimização e cuidados para contribuições futuras. |

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

## Principais cenários de análise

### Vendas executivas

- Receita bruta e líquida.
- Lucro estimado e margem percentual.
- Ticket médio, pedidos e clientes ativos.
- Comparativo mensal com variação percentual.
- Classificação de desempenho por faixas parametrizadas.

Arquivos relacionados: `sql/kpi_vendas_mensais.sql`, `hql/vendas_por_categoria.hql`, `jasper/relatorio_kpi_vendas.jrxml` e `dashboard-examples/vendas-executivo.md`.

### Atendimento e SLA

- Funil de atendimento: aberto, em análise e resolvido.
- Cumprimento de SLA e tempo médio de resolução.
- Ranking de filas por performance operacional.
- Classificação de criticidade por limite parametrizado.

Arquivos relacionados: `sql/analise_funil_atendimento.sql`, `hql/sla_atendimento_por_fila.hql`, `jasper/relatorio_sla_atendimento.jrxml` e `dashboard-examples/operacional-sla.md`.

### Retenção e recorrência

- Coortes de primeira compra.
- Clientes retidos por mês relativo.
- Receita retida e taxa de retenção.
- Recorrência por segmento e período.

Arquivos relacionados: `sql/coorte_retencao_clientes.sql`, `hql/retencao_clientes.hql` e `dashboard-examples/retencao-clientes.md`.

## Componentes Java

O módulo `java/` contém uma implementação simples, compatível com Java 8, para apoiar a etapa entre consultas analíticas e relatórios:

- `KpiResult`: DTO imutável para resultados de KPI por período e dimensão.
- `KpiCalculator`: utilitário para divisão segura, percentuais, margem, ticket médio, variação percentual, classificação, ordenação, agregação por período e sumarização.
- `ReportDataSourceFactory`: factory para criar `JRBeanCollectionDataSource` a partir de DTOs, mapas ou coleções.

## Como validar o módulo Java

Pré-requisitos:

- JDK compatível com Java 8 ou superior.
- Maven instalado.

Comando:

```bash
mvn -f java/pom.xml test
```

O projeto não depende de banco de dados, credenciais ou serviços externos para compilar. As consultas SQL/HQL e os templates JasperReports são exemplos técnicos para adaptação em ambientes reais.

## Padrões de privacidade

Este portfólio segue as seguintes regras:

- Entidades e tabelas usam nomes genéricos, como `Cliente`, `Venda`, `Atendimento`, `Produto`, `fato_vendas` e `dim_cliente`.
- Não há massas de dados, dumps, dados pessoais ou identificadores sensíveis.
- Parâmetros e limites de classificação são fictícios e reutilizáveis.
- Regras de negócio foram abstraídas para preservar confidencialidade.

Leia também: `docs/privacidade-e-anonimizacao.md`.
