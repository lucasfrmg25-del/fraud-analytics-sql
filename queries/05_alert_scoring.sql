WITH behavior AS (
    SELECT
        c.customer_id,
        c.customer_name,
        a.account_id,
        t.transaction_id,
        t.transaction_date,
        t.transaction_type,
        t.amount,
        r.risk_score,
        LAG(t.transaction_date) OVER (
            PARTITION BY a.account_id
            ORDER BY t.transaction_date, t.transaction_id
        ) AS previous_time,
        AVG(t.amount) OVER (
            PARTITION BY a.account_id
            ORDER BY t.transaction_date, t.transaction_id
            ROWS BETWEEN 5 PRECEDING AND 1 PRECEDING
        ) AS previous_avg
    FROM public.customers c
    JOIN public.accounts a ON c.customer_id = a.customer_id
    JOIN public.transactions t ON a.account_id = t.account_id
    JOIN public.risk_analysis r ON t.transaction_id = r.transaction_id
),
scored AS (
    SELECT *,
        (CASE WHEN risk_score >= 90 THEN 3 ELSE 0 END) +
        (CASE WHEN previous_avg IS NOT NULL AND amount >= previous_avg * 3 THEN 2 ELSE 0 END) +
        (CASE WHEN previous_time IS NOT NULL
              AND EXTRACT(EPOCH FROM (transaction_date - previous_time))/60.0 <= 5 THEN 2 ELSE 0 END) +
        (CASE WHEN EXTRACT(HOUR FROM transaction_date) BETWEEN 0 AND 4 THEN 1 ELSE 0 END) AS alert_score
    FROM behavior
)
SELECT *,
    CASE
        WHEN alert_score >= 6 THEN 'P1 - IMEDIATA'
        WHEN alert_score >= 5 THEN 'P2 - ALTA'
        WHEN alert_score >= 3 THEN 'P3 - MEDIA'
        ELSE 'P4 - BAIXA'
    END AS priority_level
FROM scored
ORDER BY alert_score DESC, risk_score DESC, amount DESC;
