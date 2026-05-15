# Java BI Framework

Mini framework Java 8 para apoiar a camada de indicadores entre HQL/SQL analítico e JasperReports.

## Camadas

1. **DTO analítico**: `KpiResult` representa período, dimensão, receita, custo, desconto, volume e métricas derivadas.
2. **Utility layer**: `KpiCalculator` centraliza ticket médio, margem, variação percentual, classificações e agregações por período.
3. **Factory layer**: `ReportDataSourceFactory` converte DTOs ou projeções `Map<String, Object>` em `JRBeanCollectionDataSource`.

## Convenções

- Compatível com Java 8 (`maven.compiler.source` e `target` em `1.8`).
- Valores financeiros usam `BigDecimal`.
- Coleções usam `List`, `Map`, `HashMap` e estruturas simples.
- Nenhuma classe depende de banco real, credencial, sistema interno ou entidade proprietária.

## Execução

```bash
mvn -f java/pom.xml test
```
