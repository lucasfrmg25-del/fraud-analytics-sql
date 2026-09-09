SELECT
    account_id,
    transaction_id,
    transaction_date,
    amount,
    ROW_NUMBER() OVER (
        PARTITION BY account_id
        ORDER BY transaction_date, transaction_id
    ) AS transaction_sequence
FROM public.transactions;

WITH ranked AS (
    SELECT
        account_id,
        transaction_id,
        amount,
        RANK() OVER (
            PARTITION BY account_id
            ORDER BY amount DESC
        ) AS amount_rank
    FROM public.transactions
)
SELECT *
FROM ranked
WHERE amount_rank <= 3;
