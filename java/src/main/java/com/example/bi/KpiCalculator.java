package com.example.bi;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;

/**
 * Regras genéricas de cálculo para indicadores de relatórios analíticos.
 */
public final class KpiCalculator {
    private KpiCalculator() {
    }

    public static BigDecimal percentageVariation(BigDecimal currentValue, BigDecimal previousValue) {
        Objects.requireNonNull(currentValue, "currentValue");
        Objects.requireNonNull(previousValue, "previousValue");

        if (previousValue.compareTo(BigDecimal.ZERO) == 0) {
            return BigDecimal.ZERO;
        }

        return currentValue
                .subtract(previousValue)
                .divide(previousValue, 4, RoundingMode.HALF_UP)
                .multiply(BigDecimal.valueOf(100))
                .setScale(2, RoundingMode.HALF_UP);
    }

    public static BigDecimal accumulatedRevenue(List<KpiResult> results) {
        return results.stream()
                .map(KpiResult::getRevenue)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public static List<KpiResult> sortByPeriod(List<KpiResult> results) {
        return results.stream()
                .sorted(Comparator.comparing(KpiResult::getPeriod))
                .toList();
    }
}
