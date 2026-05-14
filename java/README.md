# Java

Exemplos Java genéricos para apoiar cálculos de BI e integração com JasperReports.

## Conteúdo

- `KpiResult`: DTO imutável para resultados mensais.
- `KpiCalculator`: funções utilitárias para variação percentual, receita acumulada e ordenação por período.
- `ReportDataSourceFactory`: adaptação de coleções Java para `JRBeanCollectionDataSource`.

## Execução

```bash
mvn -f java/pom.xml test
```

Os exemplos não possuem conexão com banco de dados real e não incluem dados pessoais.
