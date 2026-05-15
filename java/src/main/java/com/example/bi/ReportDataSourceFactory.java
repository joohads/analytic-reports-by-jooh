package com.example.bi;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * Factory de DataSources JasperReports para a camada de BI.
 *
 * Centraliza a conversão de DTOs e projeções Map para JRBeanCollectionDataSource,
 * mantendo os relatórios independentes da origem dos dados (HQL, SQL ou memória).
 */
public final class ReportDataSourceFactory {

    private ReportDataSourceFactory() {
    }

    public static JRBeanCollectionDataSource fromKpiResults(Collection<KpiResult> results) {
        Objects.requireNonNull(results, "results");
        return new JRBeanCollectionDataSource(results);
    }

    public static JRBeanCollectionDataSource safeFromKpiResults(Collection<KpiResult> results) {
        return new JRBeanCollectionDataSource(results == null ? Collections.<KpiResult>emptyList() : results);
    }

    public static JRBeanCollectionDataSource fromMapList(List<Map<String, Object>> rows) {
        Objects.requireNonNull(rows, "rows");
        return new JRBeanCollectionDataSource(rows);
    }

    public static JRBeanCollectionDataSource safeFromMapList(List<Map<String, Object>> rows) {
        return new JRBeanCollectionDataSource(rows == null ? Collections.<Map<String, Object>>emptyList() : rows);
    }

    public static JRBeanCollectionDataSource fromCollection(Collection<?> data) {
        Objects.requireNonNull(data, "data");
        return new JRBeanCollectionDataSource(data);
    }

    public static JRBeanCollectionDataSource wrapIfNeeded(Object data) {
        if (data == null) {
            return new JRBeanCollectionDataSource(Collections.emptyList());
        }
        if (data instanceof Collection<?>) {
            return new JRBeanCollectionDataSource((Collection<?>) data);
        }
        throw new IllegalArgumentException("Unsupported datasource type: " + data.getClass().getName());
    }
}
