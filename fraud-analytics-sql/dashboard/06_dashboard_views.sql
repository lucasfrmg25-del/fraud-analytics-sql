CREATE OR REPLACE VIEW public.vw_dashboard_kpis AS
SELECT
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount),2) AS total_financial_volume,
    ROUND(AVG(amount),2) AS avg_ticket,
    SUM(CASE WHEN priority_level IN ('P1 - IMEDIATA','P2 - ALTA') THEN 1 ELSE 0 END) AS p1_p2_alerts,
    ROUND(100.0 * SUM(CASE WHEN priority_level IN ('P1 - IMEDIATA','P2 - ALTA') THEN 1 ELSE 0 END) / COUNT(*), 2) AS prioritization_rate_pct,
    ROUND(SUM(CASE WHEN priority_level IN ('P1 - IMEDIATA','P2 - ALTA') THEN amount ELSE 0 END),2) AS p1_p2_financial_volume
FROM public.vw_fraud_alert_queue;
