package com.example.bi;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Camada utilitária de cálculos BI.
 *
 * Mantém operações simples e reutilizáveis para relatórios JasperReports,
 * projeções HQL/SQL e dashboards: margem, ticket médio, variação percentual,
 * classificação e agregação por período.
 */
public final class KpiCalculator {

    private static final int SCALE = 2;
    private static final BigDecimal ONE_HUNDRED = BigDecimal.valueOf(100);

    private KpiCalculator() {
    }

    public static BigDecimal divide(BigDecimal numerator, BigDecimal denominator) {
        BigDecimal safeNumerator = safe(numerator);
        BigDecimal safeDenominator = safe(denominator);

        if (safeDenominator.compareTo(BigDecimal.ZERO) == 0) {
            return BigDecimal.ZERO.setScale(SCALE, RoundingMode.HALF_UP);
        }

        return safeNumerator.divide(safeDenominator, SCALE, RoundingMode.HALF_UP);
    }

    public static BigDecimal percentage(BigDecimal part, BigDecimal total) {
        if (safe(total).compareTo(BigDecimal.ZERO) == 0) {
            return BigDecimal.ZERO.setScale(SCALE, RoundingMode.HALF_UP);
        }
        return divide(part, total).multiply(ONE_HUNDRED).setScale(SCALE, RoundingMode.HALF_UP);
    }

    public static BigDecimal averageTicket(BigDecimal revenue, long orderCount) {
        return divide(revenue, BigDecimal.valueOf(orderCount));
    }

    public static BigDecimal marginPercentage(BigDecimal revenue, BigDecimal cost, BigDecimal discount) {
        BigDecimal netRevenue = safe(revenue).subtract(safe(discount));
        BigDecimal profit = netRevenue.subtract(safe(cost));
        return percentage(profit, netRevenue);
    }

    public static BigDecimal percentageVariation(BigDecimal currentValue, BigDecimal previousValue) {
        BigDecimal previous = safe(previousValue);
        if (previous.compareTo(BigDecimal.ZERO) == 0) {
            return BigDecimal.ZERO.setScale(SCALE, RoundingMode.HALF_UP);
        }
        return percentage(safe(currentValue).subtract(previous), previous);
    }

    public static String classifyByValue(BigDecimal value) {
        BigDecimal safeValue = safe(value);
        if (safeValue.compareTo(BigDecimal.valueOf(100000)) >= 0) {
            return "ALTO";
        }
        if (safeValue.compareTo(BigDecimal.valueOf(50000)) >= 0) {
            return "MEDIO";
        }
        return "BAIXO";
    }

    public static String classifyByPercentage(BigDecimal percentage) {
        BigDecimal safePercentage = safe(percentage);
        if (safePercentage.compareTo(BigDecimal.valueOf(25)) >= 0) {
            return "ALTO";
        }
        if (safePercentage.compareTo(BigDecimal.valueOf(10)) >= 0) {
            return "MEDIO";
        }
        return "BAIXO";
    }

    public static List<KpiResult> sortByPeriod(List<KpiResult> results) {
        List<KpiResult> sorted = new ArrayList<KpiResult>(safeList(results));
        Collections.sort(sorted, new Comparator<KpiResult>() {
            @Override
            public int compare(KpiResult left, KpiResult right) {
                return left.getPeriod().compareTo(right.getPeriod());
            }
        });
        return sorted;
    }

    public static Map<YearMonth, KpiResult> aggregateByPeriod(List<KpiResult> results) {
        Map<YearMonth, MutableKpi> grouped = new LinkedHashMap<YearMonth, MutableKpi>();

        for (KpiResult result : sortByPeriod(results)) {
            MutableKpi current = grouped.get(result.getPeriod());
            if (current == null) {
                current = new MutableKpi(result.getPeriod());
                grouped.put(result.getPeriod(), current);
            }
            current.add(result);
        }

        Map<YearMonth, KpiResult> aggregated = new LinkedHashMap<YearMonth, KpiResult>();
        for (Map.Entry<YearMonth, MutableKpi> entry : grouped.entrySet()) {
            aggregated.put(entry.getKey(), entry.getValue().toResult());
        }
        return aggregated;
    }

    public static Map<String, Object> buildKpiSummary(List<KpiResult> results) {
        BigDecimal revenue = BigDecimal.ZERO;
        BigDecimal cost = BigDecimal.ZERO;
        BigDecimal discount = BigDecimal.ZERO;
        long orders = 0L;
        long customers = 0L;
        long quantity = 0L;

        for (KpiResult result : safeList(results)) {
            revenue = revenue.add(result.getRevenue());
            cost = cost.add(result.getCost());
            discount = discount.add(result.getDiscount());
            orders += result.getOrderCount();
            customers += result.getActiveCustomers();
            quantity += result.getQuantity();
        }

        Map<String, Object> summary = new HashMap<String, Object>();
        summary.put("receitaTotal", revenue.setScale(SCALE, RoundingMode.HALF_UP));
        summary.put("custoTotal", cost.setScale(SCALE, RoundingMode.HALF_UP));
        summary.put("descontoTotal", discount.setScale(SCALE, RoundingMode.HALF_UP));
        summary.put("lucroTotal", revenue.subtract(discount).subtract(cost).setScale(SCALE, RoundingMode.HALF_UP));
        summary.put("totalPedidos", orders);
        summary.put("clientesAtivos", customers);
        summary.put("quantidade", quantity);
        summary.put("ticketMedio", averageTicket(revenue, orders));
        summary.put("margemPercentual", marginPercentage(revenue, cost, discount));
        summary.put("classificacaoReceita", classifyByValue(revenue));
        return summary;
    }

    public static Map<String, Object> buildKpiSummary(List<Map<String, Object>> rows,
                                                      String valueField,
                                                      String statusField,
                                                      Object acceptedStatus) {
        BigDecimal total = BigDecimal.ZERO;
        long acceptedRows = 0L;

        for (Map<String, Object> row : safeMapList(rows)) {
            Object status = row.get(statusField);
            if (acceptedStatus == null || acceptedStatus.equals(status)) {
                total = total.add(toBigDecimal(row.get(valueField)));
                acceptedRows++;
            }
        }

        Map<String, Object> summary = new HashMap<String, Object>();
        summary.put("valorTotal", total.setScale(SCALE, RoundingMode.HALF_UP));
        summary.put("totalRegistros", acceptedRows);
        summary.put("ticketMedio", divide(total, BigDecimal.valueOf(acceptedRows)));
        summary.put("classificacao", classifyByValue(total));
        return summary;
    }

    public static BigDecimal toBigDecimal(Object value) {
        if (value == null) {
            return BigDecimal.ZERO;
        }
        if (value instanceof BigDecimal) {
            return (BigDecimal) value;
        }
        if (value instanceof Number) {
            return BigDecimal.valueOf(((Number) value).doubleValue());
        }
        return new BigDecimal(value.toString());
    }

    private static BigDecimal safe(BigDecimal value) {
        return value == null ? BigDecimal.ZERO : value;
    }

    private static List<KpiResult> safeList(List<KpiResult> results) {
        return results == null ? Collections.<KpiResult>emptyList() : results;
    }

    private static List<Map<String, Object>> safeMapList(List<Map<String, Object>> rows) {
        return rows == null ? Collections.<Map<String, Object>>emptyList() : rows;
    }

    private static final class MutableKpi {
        private final YearMonth period;
        private BigDecimal revenue = BigDecimal.ZERO;
        private BigDecimal cost = BigDecimal.ZERO;
        private BigDecimal discount = BigDecimal.ZERO;
        private long orders;
        private long customers;
        private long quantity;

        private MutableKpi(YearMonth period) {
            this.period = period;
        }

        private void add(KpiResult result) {
            revenue = revenue.add(result.getRevenue());
            cost = cost.add(result.getCost());
            discount = discount.add(result.getDiscount());
            orders += result.getOrderCount();
            customers += result.getActiveCustomers();
            quantity += result.getQuantity();
        }

        private KpiResult toResult() {
            return new KpiResult(period, "GERAL", revenue, cost, discount, orders, customers, quantity);
        }
    }
}
