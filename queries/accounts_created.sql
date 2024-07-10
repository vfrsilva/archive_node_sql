SELECT
    TO_CHAR(TO_TIMESTAMP(b.timestamp::bigint / 1000), 'YYYY-MM-DD') AS human_readable_timestamp,
    (b.global_slot_since_hard_fork / 7140 + 1) AS epoch,
		t.id AS token_id,
    COUNT(DISTINCT ac.account_identifier_id) AS unique_account_identifiers
FROM
    accounts_created ac
    JOIN blocks b ON ac.block_id = b.id
    JOIN account_identifiers ai ON ac.account_identifier_id = ai.id
    JOIN tokens t ON ai.token_id = t.id
WHERE
    b.chain_status = 'canonical'
    AND b.height >= 359605
GROUP BY
    human_readable_timestamp,
    epoch,
    t.id
ORDER BY
    human_readable_timestamp;