SELECT 
    DATE_TRUNC('day', to_timestamp(b.timestamp::bigint / 1000)) AS day,
    COUNT(DISTINCT aa.account_identifier_id) AS active_accounts_count
FROM 
    accounts_accessed aa
JOIN 
    blocks b ON aa.block_id = b.id
WHERE 
    b.chain_status = 'canonical'
    AND b.height >= 318218
GROUP BY 
    DATE_TRUNC('day', to_timestamp(b.timestamp::bigint / 1000))
ORDER BY 
    day;