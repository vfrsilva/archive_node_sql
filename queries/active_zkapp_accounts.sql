SELECT
    TO_CHAR(TO_TIMESTAMP(b.timestamp::bigint / 1000), 'YYYY-MM-DD') AS human_readable_timestamp,
    (b.global_slot_since_hard_fork / 7140 + 1) AS epoch,
    bzc.status AS zkapp_command_status,
    COUNT(DISTINCT zfpb.public_key_id) AS unique_public_key_count
FROM
    zkapp_commands zc
    JOIN blocks_zkapp_commands bzc ON zc.id = bzc.zkapp_command_id
    JOIN blocks b ON bzc.block_id = b.id
    JOIN zkapp_fee_payer_body zfpb ON zc.zkapp_fee_payer_body_id = zfpb.id
WHERE
    b.chain_status = 'canonical'
    AND b.height >= 359605
GROUP BY
    human_readable_timestamp,
    epoch,
    bzc.status
ORDER BY
    human_readable_timestamp;