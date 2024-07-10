SELECT
    t.id AS token_id,
    t.value AS token_value,
    t.owner_public_key_id AS owner_pk,
    ts.value AS token_name,
    COUNT(ai.id) AS account_count
FROM
    tokens t
LEFT JOIN
    token_symbols ts ON t.id - 1 = ts.id
JOIN
	account_identifiers ai ON t.id = ai.token_id
GROUP BY
	t.id,
    ts.value
ORDER BY
    t.id;