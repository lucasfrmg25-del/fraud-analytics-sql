-- Exemplo de geração de massa sintética no PostgreSQL.
INSERT INTO public.customers
(customer_id, customer_name, customer_age, customer_state, account_creation_date, customer_status)
SELECT
    n,
    'Customer ' || n,
    18 + (n % 63),
    (ARRAY['ES','SP','RJ','MG','BA','PR','SC','RS','GO','DF'])[(n % 10)+1],
    DATE '2026-08-20' - ((n * 7) % 2000),
    CASE WHEN n % 40 = 0 THEN 'BLOCKED'
         WHEN n % 97 = 0 THEN 'CLOSED'
         ELSE 'ACTIVE' END
FROM generate_series(1,500) AS g(n)
ON CONFLICT DO NOTHING;

INSERT INTO public.accounts
(account_id, customer_id, account_type, account_creation_date, account_status)
SELECT
    n,
    ((n - 1) % 500) + 1,
    CASE WHEN n % 2 = 0 THEN 'CHECKING' ELSE 'PAYMENT' END,
    DATE '2026-08-20' - ((n * 11) % 1500),
    CASE WHEN n % 50 = 0 THEN 'BLOCKED' ELSE 'ACTIVE' END
FROM generate_series(1,1000) AS g(n)
ON CONFLICT DO NOTHING;
