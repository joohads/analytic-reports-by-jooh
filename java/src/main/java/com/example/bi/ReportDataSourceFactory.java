package com.example.bi;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import java.util.Collection;
import java.util.List;
import java.util.Objects;
import java.util.Map;

/**
 * Fábrica genérica de DataSources para JasperReports.
 *
 * Objetivo:
 *  - desacoplar camada de BI do Jasper
 *  - padronizar entrada de dados
 *  - suportar diferentes formatos de relatório
 *  - manter simplicidade (List / Map / POJOs)
 *
 * Pode ser usada para:
 *  - KpiResult (modelos tipados)
 *  - List<Map> (HQL projections)
 *  - relatórios híbridos
 */
public final class ReportDataSourceFactory {

    private ReportDataSourceFactory() {
    }

    // =========================
    // TIPO PRINCIPAL (BI MODEL)
    // =========================

    public static JRBeanCollectionDataSource fromKpiResults(Collection<KpiResult> results) {

        Objects.requireNonNull(results, "results");

        return new JRBeanCollectionDataSource(results);
    }

    // =========================
    // GENÉRICO (MAP BASEADO EM HQL)
    // =========================

    public static JRBeanCollectionDataSource fromMapList(List<Map> data) {

        Objects.requireNonNull(data, "data");

        return new JRBeanCollectionDataSource(data);
    }

    // =========================
    // WRAPPER PARA LISTA CRUA
    // =========================

    public static JRBeanCollectionDataSource fromCollection(Collection<?> data) {

        Objects.requireNonNull(data, "data");

        return new JRBeanCollectionDataSource(data);
    }

    // =========================
    // NORMALIZAÇÃO (BI LAYER)
    // =========================

    public static JRBeanCollectionDataSource safeFromKpiResults(Collection<KpiResult> results) {

        if (results == null) {
            return new JRBeanCollectionDataSource(List.of());
        }

        return new JRBeanCollectionDataSource(results);
    }

    // =========================
    // CONVERSÃO HÍBRIDA (MAP → BEAN READY)
    // =========================

    public static JRBeanCollectionDataSource wrapIfNeeded(Object data) {

        if (data == null) {
            return new JRBeanCollectionDataSource(List.of());
        }

        if (data instanceof Collection<?>) {
            return new JRBeanCollectionDataSource((Collection<?>) data);
        }

        throw new IllegalArgumentException(
                "Unsupported datasource type: " + data.getClass()
        );
    }
}