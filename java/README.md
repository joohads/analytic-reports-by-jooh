# Módulo Java BI

Mini framework Java 8 para apoiar a camada intermediária entre consultas analíticas (`SQL`/`HQL`) e relatórios `JasperReports`.

O módulo mostra como padronizar resultados de KPI, calcular métricas derivadas e expor coleções em formato aceito pelo JasperReports sem depender de banco real, serviços externos ou entidades proprietárias.

## Stack e dependências

- Java 8 (`maven.compiler.source` e `maven.compiler.target` em `1.8`).
- Maven.
- JasperReports `6.21.3` para `JRBeanCollectionDataSource`.
- APIs padrão do Java: `BigDecimal`, `YearMonth`, `List`, `Map`, `Collection` e utilitários de ordenação/agregação.

## Estrutura

```text
java/
├── README.md
├── pom.xml
└── src/main/java/com/example/bi/
    ├── KpiCalculator.java
    ├── KpiResult.java
    └── ReportDataSourceFactory.java
```

## Classes principais

| Classe | Responsabilidade |
| --- | --- |
| `KpiResult` | DTO imutável para representar um KPI por período e dimensão, com valores financeiros, volume e métricas derivadas. |
| `KpiCalculator` | Classe utilitária para cálculos de BI: divisão segura, percentuais, ticket médio, margem, variação percentual, classificação, ordenação, agregação por período e sumarização. |
| `ReportDataSourceFactory` | Factory para criar `JRBeanCollectionDataSource` a partir de coleções de DTOs, listas de mapas ou coleções genéricas. |

## `KpiResult`

Representa uma projeção analítica com campos de entrada e getters calculados.

Campos de entrada principais:

- `period`: mês/ano da análise (`YearMonth`).
- `dimension`: dimensão de negócio, normalizada para maiúsculas e com fallback `GERAL`.
- `revenue`, `cost`, `discount`: valores monetários normalizados para duas casas decimais.
- `orderCount`, `activeCustomers`, `quantity`: volumetrias de negócio.

Métricas derivadas disponíveis:

- Receita líquida (`getNetRevenue`).
- Lucro estimado (`getProfit`).
- Ticket médio (`getAverageTicket`).
- Receita por cliente (`getRevenuePerCustomer`).
- Margem percentual (`getMarginPercentage`).
- Percentual de desconto (`getDiscountPercentage`).
- Classificações de performance, margem e ticket.
- Label textual resumido para relatórios.

## `KpiCalculator`

Centraliza regras simples e reutilizáveis para evitar duplicação entre relatórios, serviços e dashboards.

Recursos disponíveis:

- `divide`: divisão segura com retorno zero quando o denominador é zero.
- `percentage`: cálculo percentual padronizado.
- `averageTicket`: ticket médio por receita e quantidade de pedidos.
- `marginPercentage`: margem baseada em receita, desconto e custo.
- `percentageVariation`: variação percentual entre valor atual e anterior.
- `classifyByValue` e `classifyByPercentage`: classificação `ALTO`, `MEDIO` ou `BAIXO`.
- `sortByPeriod`: ordenação cronológica de KPIs.
- `aggregateByPeriod`: consolidação de resultados por `YearMonth`.
- `buildKpiSummary`: sumarização para listas de `KpiResult` ou `Map<String, Object>`.
- `toBigDecimal`: conversão de tipos numéricos para `BigDecimal`.

## `ReportDataSourceFactory`

Facilita a integração com JasperReports:

- `fromKpiResults`: datasource a partir de DTOs de KPI, exigindo coleção não nula.
- `safeFromKpiResults`: versão tolerante a coleção nula.
- `fromMapList`: datasource a partir de projeções em mapas.
- `safeFromMapList`: versão tolerante a lista nula.
- `fromCollection`: datasource para coleção genérica.
- `wrapIfNeeded`: encapsula coleções e rejeita tipos não suportados.

## Execução

A partir da raiz do repositório:

```bash
mvn -f java/pom.xml test
```

O comando compila o módulo e baixa a dependência do JasperReports quando necessário.

## Como evoluir

Sugestões para transformar este módulo em uma base mais completa:

- Adicionar testes unitários para cenários de divisão por zero, agregação e classificação.
- Criar DTOs específicos para vendas, SLA e retenção quando houver necessidade de contratos mais ricos.
- Incluir exemplos de exportação JasperReports para PDF/XLSX.
- Separar limites de classificação em configuração externa.
- Criar adaptadores para resultados de `Tuple`, `ResultSet` ou projeções de repositórios Spring Data.

## Privacidade

O módulo é autocontido e não possui conexão com banco, endpoint, credencial ou entidade de sistema real. Os nomes foram mantidos genéricos para uso público em portfólio.
