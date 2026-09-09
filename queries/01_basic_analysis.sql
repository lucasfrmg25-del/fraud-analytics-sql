-- Volume e distribuição básica
SELECT COUNT(*) AS total_transactions,
       ROUND(SUM(amount),2) AS total_amount,
       ROUND(AVG(amount),2) AS avg_ticket
FROM public.transactions;

SELECT transaction_type,
       COUNT(*) AS transactions,
       ROUND(SUM(amount),2) AS total_amount,
       ROUND(AVG(amount),2) AS avg_amount
FROM public.transactions
GROUP BY transaction_type
ORDER BY total_amount DESC;
