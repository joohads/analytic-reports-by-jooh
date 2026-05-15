package com.example.bi;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.YearMonth;
import java.util.Objects;

/**
 * DTO imutável para resultados de indicadores analíticos.
 *
 * O modelo representa uma projeção genérica que pode ser alimentada por HQL,
 * SQL analítico ou agregações em memória antes de ser enviada ao JasperReports.
 * Os nomes seguem uma linguagem de BI: período, dimensão, receita, custo,
 * desconto, volume e métricas derivadas.
 */
public final class KpiResult {

    private final YearMonth period;
    private final String dimension;
    private final BigDecimal revenue;
    private final BigDecimal cost;
    private final BigDecimal discount;
    private final long orderCount;
    private final long activeCustomers;
    private final long quantity;

    public KpiResult(YearMonth period,
                     BigDecimal revenue,
                     long orderCount,
                     long activeCustomers,
                     BigDecimal cost,
                     BigDecimal discount) {
        this(period, "GERAL", revenue, cost, discount, orderCount, activeCustomers, 0L);
    }

    public KpiResult(YearMonth period,
                     String dimension,
                     BigDecimal revenue,
                     BigDecimal cost,
                     BigDecimal discount,
                     long orderCount,
                     long activeCustomers,
                     long quantity) {
        this.period = Objects.requireNonNull(period, "period");
        this.dimension = normalizeDimension(dimension);
        this.revenue = money(revenue);
        this.cost = money(cost);
        this.discount = money(discount);
        this.orderCount = orderCount;
        this.activeCustomers = activeCustomers;
        this.quantity = quantity;
    }

    public YearMonth getPeriod() {
        return period;
    }

    public String getPeriodLabel() {
        return period.toString();
    }

    public int getYear() {
        return period.getYear();
    }

    public int getMonth() {
        return period.getMonthValue();
    }

    public String getDimension() {
        return dimension;
    }

    public BigDecimal getRevenue() {
        return revenue;
    }

    public BigDecimal getCost() {
        return cost;
    }

    public BigDecimal getDiscount() {
        return discount;
    }

    public long getOrderCount() {
        return orderCount;
    }

    public long getActiveCustomers() {
        return activeCustomers;
    }

    public long getQuantity() {
        return quantity;
    }

    public BigDecimal getNetRevenue() {
        return revenue.subtract(discount).setScale(2, RoundingMode.HALF_UP);
    }

    public BigDecimal getProfit() {
        return getNetRevenue().subtract(cost).setScale(2, RoundingMode.HALF_UP);
    }

    public BigDecimal getAverageTicket() {
        return KpiCalculator.divide(revenue, BigDecimal.valueOf(orderCount));
    }

    public BigDecimal getRevenuePerCustomer() {
        return KpiCalculator.divide(revenue, BigDecimal.valueOf(activeCustomers));
    }

    public BigDecimal getMarginPercentage() {
        return KpiCalculator.percentage(getProfit(), getNetRevenue());
    }

    public BigDecimal getDiscountPercentage() {
        return KpiCalculator.percentage(discount, revenue);
    }

    public String getPerformanceClass() {
        return KpiCalculator.classifyByValue(revenue);
    }

    public String getMarginClass() {
        return KpiCalculator.classifyByPercentage(getMarginPercentage());
    }

    public String getTicketClass() {
        return KpiCalculator.classifyByValue(getAverageTicket());
    }

    public String getKpiSummaryLabel() {
        return getPeriodLabel()
                + " | Dimensão: " + dimension
                + " | Receita: " + revenue
                + " | Pedidos: " + orderCount
                + " | Clientes: " + activeCustomers;
    }

    private static BigDecimal money(BigDecimal value) {
        if (value == null) {
            return BigDecimal.ZERO.setScale(2, RoundingMode.HALF_UP);
        }
        return value.setScale(2, RoundingMode.HALF_UP);
    }

    private static String normalizeDimension(String value) {
        if (value == null || value.trim().isEmpty()) {
            return "GERAL";
        }
        return value.trim().toUpperCase();
    }
}
