SELECT 
    b.id AS block_id,
    b.height AS height,
    (b.global_slot_since_hard_fork / 7140 + 1) AS epoch,
    b.global_slot_since_genesis,
    b.global_slot_since_hard_fork,
    (SELECT COUNT(*) FROM blocks_internal_commands bic WHERE bic.block_id = b.id) AS internal_commands_count,
    (SELECT COUNT(*) FROM blocks_user_commands buc WHERE buc.block_id = b.id) AS user_commands_count,
    (SELECT COUNT(*) FROM blocks_zkapp_commands bzc WHERE bzc.block_id = b.id) AS zkapp_commands_count,
    (SELECT COUNT(*) FROM accounts_created ac WHERE ac.block_id = b.id) AS accounts_created_count,
    COALESCE(SUM(uc.fee::numeric) / 1000000000, 0) AS total_fee_amount,
    COALESCE(SUM(CASE WHEN uc.command_type = 'payment' THEN uc.amount::numeric ELSE 0 END) / 1000000000, 0) AS total_payments_amount,
    TO_CHAR(TO_TIMESTAMP(b.timestamp::bigint / 1000), 'YYYY-MM-DD HH24:MI:SS TZ') AS human_readable_timestamp
FROM 
    blocks b
LEFT JOIN 
    blocks_user_commands buc ON b.id = buc.block_id
LEFT JOIN 
    user_commands uc ON buc.user_command_id = uc.id
WHERE 
    b.chain_status = 'canonical'
    AND b.height >= 318218
GROUP BY 
    b.id
ORDER BY 
    b.height;
