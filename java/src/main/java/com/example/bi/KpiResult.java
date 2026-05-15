package com.example.bi;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.YearMonth;
import java.util.Objects;

/**
 * Resultado mensal de indicadores BI.
 *
 * Versão enriquecida para uso em:
 *  - dashboards
 *  - relatórios JasperReports
 *  - análises comparativas
 *  - KPIs executivos
 *
 * Mantém estrutura simples, mas com métricas derivadas prontas.
 */
public final class KpiResult {

    private final YearMonth period;
    private final BigDecimal revenue;
    private final long orderCount;
    private final long activeCustomers;

    private final BigDecimal cost;
    private final BigDecimal discount;

    public KpiResult(YearMonth period,
                     BigDecimal revenue,
                     long orderCount,
                     long activeCustomers,
                     BigDecimal cost,
                     BigDecimal discount) {

        this.period = Objects.requireNonNull(period, "period");
        this.revenue = Objects.requireNonNull(revenue, "revenue");

        this.orderCount = orderCount;
        this.activeCustomers = activeCustomers;

        this.cost = cost != null ? cost : BigDecimal.ZERO;
        this.discount = discount != null ? discount : BigDecimal.ZERO;
    }

    public YearMonth getPeriod() {
        return period;
    }

    public BigDecimal getRevenue() {
        return revenue;
    }

    public long getOrderCount() {
        return orderCount;
    }

    public long getActiveCustomers() {
        return activeCustomers;
    }

    public BigDecimal getCost() {
        return cost;
    }

    public BigDecimal getDiscount() {
        return discount;
    }

    // =========================
    // KPI DERIVADOS (BI LAYER)
    // =========================

    public BigDecimal getAverageTicket() {

        if (orderCount == 0) {
            return BigDecimal.ZERO;
        }

        return revenue.divide(
                BigDecimal.valueOf(orderCount),
                2,
                RoundingMode.HALF_UP
        );
    }

    public BigDecimal getNetRevenue() {

        return revenue
                .subtract(discount)
                .setScale(2, RoundingMode.HALF_UP);
    }

    public BigDecimal getProfit() {

        return getNetRevenue()
                .subtract(cost)
                .setScale(2, RoundingMode.HALF_UP);
    }

    public BigDecimal getMarginPercentage() {

        BigDecimal net = getNetRevenue();

        if (net.compareTo(BigDecimal.ZERO) == 0) {
            return BigDecimal.ZERO;
        }

        return getProfit()
                .divide(net, 4, RoundingMode.HALF_UP)
                .multiply(BigDecimal.valueOf(100))
                .setScale(2, RoundingMode.HALF_UP);
    }

    public BigDecimal getRevenuePerCustomer() {

        if (activeCustomers == 0) {
            return BigDecimal.ZERO;
        }

        return revenue.divide(
                BigDecimal.valueOf(activeCustomers),
                2,
                RoundingMode.HALF_UP
        );
    }

    // =========================
    // CLASSIFICAÇÃO BI
    // =========================

    public String getPerformanceClass() {

        BigDecimal r = getRevenue();

        if (r.compareTo(BigDecimal.valueOf(100000)) >= 0) {
            return "ALTO DESEMPENHO";
        }

        if (r.compareTo(BigDecimal.valueOf(50000)) >= 0) {
            return "MEDIO DESEMPENHO";
        }

        return "BAIXO DESEMPENHO";
    }

    public String getTicketClass() {

        BigDecimal ticket = getAverageTicket();

        if (ticket.compareTo(BigDecimal.valueOf(1000)) >= 0) {
            return "TICKET ALTO";
        }

        if (ticket.compareTo(BigDecimal.valueOf(300)) >= 0) {
            return "TICKET MEDIO";
        }

        return "TICKET BAIXO";
    }

    // =========================
    // INDICADOR RESUMIDO
    // =========================

    public String getKpiSummaryLabel() {

        return period + " | "
                + "Receita: " + revenue + " | "
                + "Pedidos: " + orderCount + " | "
                + "Clientes: " + activeCustomers;
    }
}