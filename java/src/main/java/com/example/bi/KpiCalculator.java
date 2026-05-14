List<Map> resultado = dao.executarHql(...);

Map kpi = KpiCalculator.buildKpiSummary(
    resultado,
    "receita",
    "status",
    "CONCLUIDO"
);