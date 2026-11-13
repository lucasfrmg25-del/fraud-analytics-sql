-- Fraud Monitoring com SQL
-- Case de portfólio | Base sintética

-- 1) Total de clientes
SELECT
    COUNT(customer_id) AS total_customers
FROM customers;

-- 2) KPIs executivos
SELECT
    COUNT(transaction_id) AS total_transactions,
    MIN(transaction_date) AS first_transaction_date,
    MAX(transaction_date) AS last_transaction_date,
    SUM(amount) AS total_amount,
    AVG(amount) AS average_ticket,
    SUM(is_fraud) AS total_fraud_count,
    SUM(is_fraud) * 100.0 / COUNT(transaction_id) AS fraud_rate,
    SUM(CASE WHEN is_fraud = 1 THEN amount ELSE 0 END) AS fraud_amount,
    SUM(CASE WHEN is_fraud = 1 THEN amount ELSE 0 END) * 100.0
        / SUM(amount) AS fraud_amount_rate
FROM transactions;

-- 3) Análise por tipo de transação
SELECT
    transaction_type,
    COUNT(transaction_id) AS total_transactions,
    SUM(amount) AS total_amount,
    AVG(amount) AS average_ticket,
    SUM(is_fraud) AS fraud_count,
    SUM(is_fraud) * 100.0 / COUNT(transaction_id) AS fraud_rate,
    SUM(CASE WHEN is_fraud = 1 THEN amount ELSE 0 END) AS fraud_amount,
    SUM(CASE WHEN is_fraud = 1 THEN amount ELSE 0 END) * 100.0
        / SUM(amount) AS fraud_amount_rate
FROM transactions
GROUP BY transaction_type
ORDER BY fraud_count DESC, total_amount DESC;

-- 4) Visão consolidada por cliente
SELECT
    c.customer_id,
    c.customer_name,
    c.risk_level,
    COUNT(t.transaction_id) AS total_transactions,
    SUM(t.amount) AS total_amount,
    AVG(t.amount) AS average_ticket,
    SUM(t.is_fraud) AS fraud_count,
    SUM(CASE WHEN t.is_fraud = 1 THEN t.amount ELSE 0 END) AS fraud_amount,
    SUM(t.is_fraud) * 100.0 / COUNT(t.transaction_id) AS fraud_rate
FROM customers AS c
JOIN transactions AS t
    ON c.customer_id = t.customer_id
GROUP BY
    c.customer_id,
    c.customer_name,
    c.risk_level
ORDER BY
    fraud_count DESC,
    total_amount DESC;
