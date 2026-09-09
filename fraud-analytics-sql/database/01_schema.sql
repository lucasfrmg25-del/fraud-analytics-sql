-- Fraud Analytics com PostgreSQL / Supabase
-- Dados 100% sintéticos.

CREATE TABLE IF NOT EXISTS public.customers (
    customer_id integer PRIMARY KEY,
    customer_name varchar(100) NOT NULL,
    customer_age integer,
    customer_state varchar(2),
    account_creation_date date,
    customer_status varchar(20)
);

CREATE TABLE IF NOT EXISTS public.accounts (
    account_id integer PRIMARY KEY,
    customer_id integer NOT NULL REFERENCES public.customers(customer_id),
    account_type varchar(20),
    account_creation_date date,
    account_status varchar(20)
);

CREATE TABLE IF NOT EXISTS public.transactions (
    transaction_id integer PRIMARY KEY,
    account_id integer NOT NULL REFERENCES public.accounts(account_id),
    transaction_date timestamp,
    transaction_type varchar(20),
    amount numeric(12,2),
    destination_account integer,
    transaction_status varchar(20)
);

CREATE TABLE IF NOT EXISTS public.devices (
    device_id integer PRIMARY KEY,
    customer_id integer NOT NULL REFERENCES public.customers(customer_id),
    device_type varchar(20),
    operating_system varchar(20),
    first_seen_date date,
    last_seen_date date
);

CREATE TABLE IF NOT EXISTS public.risk_analysis (
    analysis_id integer PRIMARY KEY,
    transaction_id integer NOT NULL REFERENCES public.transactions(transaction_id),
    risk_score numeric(5,2),
    risk_level varchar(20),
    analysis_date timestamp,
    decision varchar(20),
    rule_triggered varchar(150)
);

CREATE TABLE IF NOT EXISTS public.fraud_cases (
    case_id integer PRIMARY KEY,
    transaction_id integer NOT NULL REFERENCES public.transactions(transaction_id),
    fraud_type varchar(50),
    case_status varchar(20),
    confirmed_fraud boolean,
    investigation_date date,
    financial_loss numeric(12,2) NOT NULL DEFAULT 0.00,
    investigation_status varchar(20),
    opened_at timestamp,
    closed_at timestamp
);
