-- Transações críticas sem investigação
SELECT
  t.transaction_id,
  t.account_id,
  t.transaction_date,
  t.transaction_type,
  t.amount,
  r.risk_score,
  r.risk_level
FROM public.transactions t
JOIN public.risk_analysis r ON r.transaction_id = t.transaction_id
LEFT JOIN public.fraud_cases f ON f.transaction_id = t.transaction_id
WHERE r.risk_score >= 90
  AND f.case_id IS NULL
ORDER BY r.risk_score DESC, t.amount DESC;
