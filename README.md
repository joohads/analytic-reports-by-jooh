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
☕ Desenvolvimento backend com Java  
🧠 Processamento e manipulação de dados  
📈 Indicadores, métricas e KPIs  
🎨 Layouts desenvolvidos no JasperReports Studio  
📑 Relatórios analíticos e operacionais  
⚡ Otimização de consultas e performance  
🔍 Exemplos de lógica aplicada em BI e geração de relatórios

O objetivo do projeto é compartilhar conhecimento, estudos, ideias e formas de estruturar soluções analíticas de maneira organizada e escalável.

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

- KPI mensal de receita, pedidos, clientes ativos e ticket médio.
- Comparativo com mês anterior.
- Layout JasperReports para relatório executivo.

Arquivos principais:

- `sql/kpi_vendas_mensais.sql`
- `hql/vendas_por_categoria.hql`
- `dashboard-examples/vendas-executivo.md`
- `jasper/relatorio_kpi_vendas.jrxml`

## 2. Atendimento e SLA

- Funil operacional por etapa.
- Taxa de resolução e cumprimento de SLA.
- Relatório JasperReports para filas de atendimento.

Arquivos principais:

- `sql/analise_funil_atendimento.sql`
- `hql/sla_atendimento_por_fila.hql`
- `dashboard-examples/operacional-sla.md`
- `jasper/relatorio_sla_atendimento.jrxml`

## 3. Retenção e recorrência

- Coortes de primeira compra.
- Clientes recorrentes por segmento.
- Ideias de visualizações para retenção mensal.

Arquivos principais:

- `sql/coorte_retencao_clientes.sql`
- `hql/retencao_clientes.hql`
- `dashboard-examples/retencao-clientes.md`

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
