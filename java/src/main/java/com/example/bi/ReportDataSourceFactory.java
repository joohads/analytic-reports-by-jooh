package com.example.bi;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import java.util.Collection;
import java.util.Objects;

/**
 * Fábrica simples para adaptar coleções Java a data sources do JasperReports.
 */
public final class ReportDataSourceFactory {
    private ReportDataSourceFactory() {
    }

    public static JRBeanCollectionDataSource fromKpiResults(Collection<KpiResult> results) {
        Objects.requireNonNull(results, "results");
        return new JRBeanCollectionDataSource(results);
    }
}
