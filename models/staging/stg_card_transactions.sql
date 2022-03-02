WITH card_transactions AS (

        SELECT  cardid,
                companyid,
                createdat,
                UPPER(currency) AS currency,
                id,
                isactive,
                issuertypeid,
                merchantid,
                statusid,
                updatedat,
                userid,
                amount_usd
        FROM {{source('tribal','card_transactions')}}

)

SELECT *
FROM card_transactions