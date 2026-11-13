# Documentação do Case — Fraud Monitoring com SQL

## Contexto
Projeto educacional com dados sintéticos criado para demonstrar SQL aplicado à prevenção a fraudes.

## Problema de negócio
Uma operação de fraude precisa enxergar simultaneamente frequência, impacto financeiro e concentração por cliente. O case transforma uma base transacional em uma camada de indicadores simples, auditável e reutilizável.

## Entregas
- KPIs executivos da base
- Taxa de fraude
- Volume financeiro fraudado
- Comparação por meio de pagamento
- Visão consolidada por cliente
- Ranking por ocorrências e exposição financeira

## Insights principais
1. PIX concentra 11 das 18 fraudes e apresenta taxa de fraude de 6,75%.
2. BOLETO possui apenas 2 fraudes, mas 18,57% do volume da modalidade está associado a fraude.
3. Frequência e impacto financeiro não são equivalentes; ambos devem ser monitorados.
4. A visão por cliente permite priorizar investigações por quantidade de ocorrências e exposição financeira.

## Limitações
- Base inteiramente sintética.
- Não há inferência causal nem modelo preditivo.
- risk_level é um atributo disponível na base e não um score produzido pelo projeto.
- Os resultados demonstram lógica analítica, não desempenho real de uma instituição financeira.

## Próximos passos
- Recorte temporal mensal
- Velocity e janelas de comportamento
- Regras de monitoramento
- Dashboard em Power BI
