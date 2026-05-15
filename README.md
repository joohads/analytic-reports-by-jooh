# 📊 analytic-reports-by-jooh

<p align="center">
  ✨ Business Intelligence • SQL • HQL • Java • JasperReports ✨
</p>

<p align="center">
  Repositório criado para compartilhar exemplos de análises, relatórios, dashboards e soluções BI desenvolvidas com foco em dados, performance e visualização 💖
</p>

---

# 🌸 Sobre o projeto

O **analytic-reports-by-jooh** reúne exemplos práticos de:

💻 Consultas SQL e HQL
📊 Estruturas analíticas para Business Intelligence
☕ Desenvolvimento backend com Java 8
🧠 Processamento e manipulação de dados
📈 Indicadores, métricas e KPIs
🎨 Layouts desenvolvidos no JasperReports Studio
📑 Relatórios analíticos e operacionais
⚡ Otimização de consultas e performance
🔍 Exemplos de lógica aplicada em BI e geração de relatórios

O objetivo do projeto é funcionar como um mini framework profissional de BI / Analytics em Java 8 + HQL + SQL + JasperReports, com exemplos reutilizáveis para portfólio, documentação e estudos técnicos.

> Observação: os exemplos deste repositório foram generalizados e anonimizados. Eles não utilizam dados reais, nomes de empresas, identificadores internos ou informações pessoais. Também não há exemplos em Python, conforme a proposta do projeto.

---

# 📂 Estrutura do Repositório

```bash
📁 sql/
   ├── README.md
   ├── kpi_vendas_mensais.sql
   ├── analise_funil_atendimento.sql
   └── coorte_retencao_clientes.sql

📁 hql/
   ├── README.md
   ├── vendas_por_categoria.hql
   ├── sla_atendimento_por_fila.hql
   └── retencao_clientes.hql

📁 java/
   ├── README.md
   ├── pom.xml
   └── src/main/java/com/example/bi/
       ├── KpiResult.java
       ├── KpiCalculator.java
       └── ReportDataSourceFactory.java

📁 jasper/
   ├── README.md
   ├── relatorio_kpi_vendas.jrxml
   └── relatorio_sla_atendimento.jrxml

📁 dashboard-examples/
   ├── README.md
   ├── vendas-executivo.md
   ├── operacional-sla.md
   └── retencao-clientes.md

📁 docs/
   └── privacidade-e-anonimizacao.md
```

---

# 🧩 Temas de BI incluídos

## 1. Vendas e receita

- KPI mensal de receita, receita líquida, margem, pedidos, clientes ativos e ticket médio.
- Comparativo com mês anterior e classificação analítica alto/médio/baixo.
- Layout JasperReports para dashboard executivo.

Arquivos principais:

- `sql/kpi_vendas_mensais.sql`
- `hql/vendas_por_categoria.hql`
- `dashboard-examples/vendas-executivo.md`
- `jasper/relatorio_kpi_vendas.jrxml`

## 2. Atendimento e SLA

- Funil operacional por etapa.
- Taxa de resolução, cumprimento de SLA, tempo médio e criticidade.
- Relatório JasperReports para dashboard operacional por fila.

Arquivos principais:

- `sql/analise_funil_atendimento.sql`
- `hql/sla_atendimento_por_fila.hql`
- `dashboard-examples/operacional-sla.md`
- `jasper/relatorio_sla_atendimento.jrxml`

## 3. Retenção e recorrência

- Coortes de primeira compra.
- Clientes recorrentes por segmento, taxa de conclusão e ticket médio.
- Ideias de visualizações para retenção mensal e receita retida.

Arquivos principais:

- `sql/coorte_retencao_clientes.sql`
- `hql/retencao_clientes.hql`
- `dashboard-examples/retencao-clientes.md`


---

# 🧱 Arquitetura BI proposta

1. **Queries (HQL/SQL)**: agregações, percentuais, filtros dinâmicos e aliases analíticos.
2. **DTOs de BI**: `KpiResult` consolida período, dimensão, valores financeiros e métricas derivadas.
3. **Utility layer**: `KpiCalculator` calcula margem, ticket médio, variação percentual, classificações e agregações.
4. **JasperReports**: templates JRXML com título, cards de KPI, tabela e gráficos.
5. **Factory layer**: `ReportDataSourceFactory` padroniza `JRBeanCollectionDataSource` para DTOs e mapas.

---

# 🔐 Privacidade e confidencialidade

Os exemplos foram criados com foco em reutilização técnica e proteção de informações sensíveis:

- Nomes de entidades, tabelas e campos são fictícios.
- Não existem dumps, massas de dados, credenciais ou strings de conexão.
- Não há CPF, e-mail, telefone, endereço, contrato ou qualquer identificador pessoal.
- Regras e métricas foram descritas de forma genérica para evitar exposição de contexto corporativo.

Consulte `docs/privacidade-e-anonimizacao.md` antes de adicionar novos exemplos.

---

# 🚀 Como usar

1. Escolha um tema em `dashboard-examples/`.
2. Consulte o SQL ou HQL correspondente.
3. Reaproveite as classes Java em `java/src/main/java/com/example/bi/` para cálculos e integração com JasperReports.
4. Abra os arquivos `.jrxml` no JasperReports Studio para adaptar o layout visual.
5. Ajuste nomes de tabelas, entidades e campos para o seu ambiente, mantendo a anonimização quando for publicar exemplos.

Para validar os exemplos Java:

```bash
mvn -f java/pom.xml test
```
