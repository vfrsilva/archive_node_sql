SELECT DISTINCT
    vk.id AS verification_key_id,
    vk.verification_key,
    vkh.value AS verification_key_hash,
    u.value AS zkapp_uri,
    f.id AS field_id,
    f.field AS field_value,
    e.id AS event_id,
    e.element_ids AS event_element_ids
FROM 
    zkapp_verification_keys vk
LEFT JOIN 
    zkapp_verification_key_hashes vkh ON vk.hash_id = vkh.id
LEFT JOIN 
    zkapp_accounts za ON za.verification_key_id = vk.id
LEFT JOIN 
    zkapp_uris u ON za.zkapp_uri_id = u.id
LEFT JOIN 
    zkapp_states zs ON za.app_state_id = zs.id
LEFT JOIN 
    zkapp_field f ON 
        f.id IN (
            zs.element0, 
            zs.element1, 
            zs.element2, 
            zs.element3, 
            zs.element4, 
            zs.element5, 
            zs.element6, 
            zs.element7
        )
LEFT JOIN 
    zkapp_account_update_body zaubb ON zaubb.verification_key_hash_id = vkh.id
LEFT JOIN 
    zkapp_events e ON zaubb.events_id = e.id
ORDER BY 
    vk.id, f.id, e.id;
