package com.example.bi;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.YearMonth;
import java.util.Objects;

/**
 * Resultado mensal de indicadores usados em relatórios BI.
 *
 * <p>Classe propositalmente genérica e sem qualquer referência a empresas,
 * clientes reais ou bases de dados confidenciais.</p>
 */
public final class KpiResult {
    private final YearMonth period;
    private final BigDecimal revenue;
    private final long orderCount;
    private final long activeCustomers;

    public KpiResult(YearMonth period, BigDecimal revenue, long orderCount, long activeCustomers) {
        this.period = Objects.requireNonNull(period, "period");
        this.revenue = Objects.requireNonNull(revenue, "revenue");
        this.orderCount = orderCount;
        this.activeCustomers = activeCustomers;
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

    public BigDecimal getAverageTicket() {
        if (orderCount == 0) {
            return BigDecimal.ZERO;
        }
        return revenue.divide(BigDecimal.valueOf(orderCount), 2, RoundingMode.HALF_UP);
    }
}
