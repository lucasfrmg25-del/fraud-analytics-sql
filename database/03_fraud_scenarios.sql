-- Cenários controlados para validar regras de velocity e priorização.
INSERT INTO public.transactions
(transaction_id, account_id, transaction_date, transaction_type, amount, destination_account, transaction_status)
VALUES
(90001,105,'2026-08-15 14:01:00','PIX',4800.00,701,'APPROVED'),
(90002,105,'2026-08-15 14:03:00','PIX',4750.00,702,'APPROVED'),
(90003,105,'2026-08-15 14:05:00','PIX',4900.00,703,'APPROVED'),
(90004,105,'2026-08-15 14:07:00','PIX',4850.00,704,'APPROVED'),
(90005,105,'2026-08-15 14:09:00','PIX',4700.00,705,'APPROVED'),
(90006,220,'2026-08-16 02:11:00','PIX',3200.00,801,'APPROVED'),
(90007,220,'2026-08-16 02:18:00','PIX',4100.00,802,'APPROVED'),
(90008,220,'2026-08-16 03:02:00','TED',6900.00,803,'APPROVED')
ON CONFLICT DO NOTHING;
