SELECT DISTINCT ON (token.value, token_symbol.value) token.value, token_symbol.id, token_symbol.value
FROM tokens token
INNER JOIN public_keys token_owner_pk ON token.owner_public_key_id = token_owner_pk.id
INNER JOIN tokens default_token ON default_token.value = 'wSHV2S4qX9jFsLjQo8r1BsMLH2ZRKsZx6EJd1sbozGPieEC4Jf'
INNER JOIN account_identifiers token_owner_ai ON token_owner_pk.id = token_owner_ai.public_key_id AND default_token.id = token_owner_ai.token_id
INNER JOIN accounts_accessed token_owner_accounts_accessed ON token_owner_ai.id = token_owner_accounts_accessed.account_identifier_id
INNER JOIN token_symbols token_symbol ON token_owner_accounts_accessed.token_symbol_id = token_symbol.id
INNER JOIN blocks token_block ON token_owner_accounts_accessed.block_id = token_block.id
ORDER BY token.value, token_symbol.value, token_block.height DESC