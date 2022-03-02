WITH card_transaction_status AS (

        SELECT *
        FROM {{source('tribal','card_transaction_status')}}

)

SELECT *
FROM card_transaction_status