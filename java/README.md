# Java

Módulo Maven com utilitários Java 8 para apoiar a camada entre consultas analíticas e relatórios JasperReports.

O módulo não implementa acesso a banco, ORM, serviços HTTP ou execução de relatórios. Ele concentra classes pequenas e reutilizáveis para representar KPIs, calcular métricas derivadas e transformar coleções em `JRBeanCollectionDataSource`.

## Estrutura

```text
java/
├── pom.xml
└── src/main/java/com/example/bi/
    ├── KpiCalculator.java
    ├── KpiResult.java
    └── ReportDataSourceFactory.java
```

## Classes

| Classe | Responsabilidade |
| --- | --- |
| `KpiResult` | DTO imutável para período (`YearMonth`), dimensão, receita, custo, desconto, pedidos, clientes ativos e quantidade. Também expõe getters calculados, como receita líquida, lucro, ticket médio, receita por cliente, margem, desconto percentual e classificações. |
| `KpiCalculator` | Classe utilitária com métodos estáticos para divisão segura, percentual, ticket médio, margem, variação percentual, classificação por valor/percentual, ordenação, agregação por período e geração de resumos. |
| `ReportDataSourceFactory` | Factory para criar `JRBeanCollectionDataSource` a partir de `Collection<KpiResult>`, listas de `Map<String, Object>` ou coleções genéricas. |

## Dependências e compatibilidade

- `maven.compiler.source` e `maven.compiler.target` estão configurados como `1.8`.
- A dependência declarada é `net.sf.jasperreports:jasperreports:6.21.3`.
- Valores monetários são tratados com `BigDecimal` e arredondamento `HALF_UP` em escala 2.
- O código usa coleções simples da JDK e não referencia entidades, tabelas, credenciais ou sistemas reais.

## Como compilar

A partir da raiz do repositório:

```bash
mvn -f java/pom.xml test
```

O comando compila o módulo Maven. Atualmente não há testes unitários próprios no repositório.

## Integração esperada

1. Uma consulta SQL/HQL produz linhas agregadas ou DTOs.
2. A aplicação converte esses dados para `KpiResult` ou para `Map<String, Object>` com aliases compatíveis.
3. `KpiCalculator` pode complementar métricas e resumos.
4. `ReportDataSourceFactory` encapsula a coleção em um datasource consumível por JasperReports.
