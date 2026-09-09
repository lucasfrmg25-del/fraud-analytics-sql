-- Outlier versus histórico
WITH account_history AS (
    SELECT
        t.account_id,
        t.transaction_id,
        t.transaction_date,
        t.transaction_type,
        t.amount,
        AVG(t.amount) OVER (
            PARTITION BY t.account_id
            ORDER BY t.transaction_date, t.transaction_id
            ROWS BETWEEN 5 PRECEDING AND 1 PRECEDING
        ) AS previous_5_avg
    FROM public.transactions t
)
SELECT *
FROM account_history
WHERE previous_5_avg IS NOT NULL
  AND amount >= previous_5_avg * 3;

-- Velocity
WITH tx_sequence AS (
    SELECT
        account_id,
        transaction_id,
        transaction_date,
        amount,
        LAG(transaction_date) OVER (
            PARTITION BY account_id
            ORDER BY transaction_date, transaction_id
        ) AS previous_time
    FROM public.transactions
)
SELECT *,
       ROUND((EXTRACT(EPOCH FROM (transaction_date - previous_time))/60.0)::numeric,2) AS gap_minutes
FROM tx_sequence
WHERE previous_time IS NOT NULL
  AND EXTRACT(EPOCH FROM (transaction_date - previous_time))/60.0 <= 5
  AND amount >= 2000;
