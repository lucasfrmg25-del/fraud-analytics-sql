# Fraud Monitoring com SQL

Case de portfólio com **dados sintéticos** para demonstrar SQL aplicado à prevenção a fraudes financeiras.

## Proposta de negócio

Construir uma camada analítica simples e auditável que responda quatro perguntas:

1. Qual é o volume total e o ticket médio da operação?
2. Quantas transações foram confirmadas como fraude?
3. Qual é o impacto financeiro das fraudes por meio de pagamento?
4. Quais clientes concentram maior número de ocorrências ou exposição financeira?

> A proposta não é prever fraude. O projeto organiza sinais confirmados e exposição financeira para apoiar investigação e priorização.

## Base utilizada

- 50 clientes sintéticos
- 325 transações sintéticas
- Canais: PIX, TED, BOLETO e CARD
- Período: 2026-01-01 a 2026-10-28
- Banco: SQLite

## KPIs gerais

| Indicador | Resultado |
|---|---:|
| Total de transações | 325 |
| Volume financeiro | R$ 3.316.612,27 |
| Ticket médio | R$ 10.204,96 |
| Fraudes confirmadas | 18 |
| Taxa de fraude | 5,54% |
| Volume fraudado | R$ 349.198,34 |
| % do volume fraudado | 10,53% |

## Insights

### PIX concentra mais ocorrências
PIX representa 163 transações e 11 das 18 fraudes confirmadas. A taxa de fraude do canal foi de **6,75%**.

### BOLETO concentra maior impacto relativo
Apesar de apenas 2 fraudes, **18,57% do volume de BOLETO** ficou associado a fraude na base sintética.

### Frequência e impacto financeiro são métricas diferentes
O case separa **fraud_rate** de **fraud_amount_rate** para evitar decisões baseadas apenas na contagem de ocorrências.

## SQL utilizado

- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()` / `MAX()`
- `CASE WHEN`
- `GROUP BY`
- `JOIN`
- `ORDER BY`

## Visão consolidada por cliente

A etapa final combina `customers` e `transactions` para retornar:

- customer_id
- customer_name
- risk_level
- total_transactions
- total_amount
- average_ticket
- fraud_count
- fraud_amount
- fraud_rate

## Proposta de decisão

- Monitorar **taxa de fraude** e **percentual de volume fraudado** em conjunto.
- Priorizar clientes por **fraud_count** e **exposição financeira**, sem depender apenas do risk_level.
- Manter queries simples e auditáveis antes de levar os indicadores para BI.
- Evoluir o case com recorte temporal, velocity e comportamento histórico.

## Estrutura do repositório

- `queries/`: consultas SQL
- `database/`: estrutura de dados
- `docs/`: documentação complementar
- `dashboard/`: materiais para futura camada de BI

## Portfólio

A versão editorial do case está publicada no **Meu Portfólio**:
https://lucasfrmg25-del.github.io/fraud-analytics-sql.html

---

**Lucas Freire Martins**  
Fraud Prevention · Risk Analysis · SQL · Analytics
