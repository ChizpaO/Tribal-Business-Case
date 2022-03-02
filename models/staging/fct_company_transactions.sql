WITH companies AS (
    SELECT *
    FROM {{ref('dim_companies')}}
),

card_transactions AS (
    SELECT *
    FROM {{ref('stg_card_transactions')}}  
),

card_status AS (
    SELECT *
    FROM {{ref('dim_card_transaction_status')}} 
),

final AS (
    SELECT
        c.name,
        SUM(CASE WHEN ct.statusid = '0' THEN 1 ELSE 0 END) AS Pending,
        SUM(CASE WHEN ct.statusid = '0' THEN ct.amount_usd ELSE 0 END) AS pending_amount,
        SUM(CASE WHEN ct.statusid = '1' THEN 1 ELSE 0 END) AS Approved,
        SUM(CASE WHEN ct.statusid = '1' THEN ct.amount_usd ELSE 0 END) AS approved_amount,
        SUM(CASE WHEN ct.statusid = '2' THEN 1 ELSE 0 END) AS Declined,
        SUM(CASE WHEN ct.statusid = '2' THEN ct.amount_usd ELSE 0 END) AS declined_amount,
        SUM(CASE WHEN ct.statusid = '3' THEN 1 ELSE 0 END) AS Canceled,
        SUM(CASE WHEN ct.statusid = '3' THEN ct.amount_usd ELSE 0 END) AS canceled_amount,
        SUM(CASE WHEN ct.statusid = '4' THEN 1 ELSE 0 END) AS Won,
        SUM(CASE WHEN ct.statusid = '4' THEN ct.amount_usd ELSE 0 END) AS won_amount,
        SUM(CASE WHEN ct.statusid = '5' THEN 1 ELSE 0 END) AS Lost,
        SUM(CASE WHEN ct.statusid = '5' THEN ct.amount_usd ELSE 0 END) AS lost_amount,
        COUNT(DISTINCT ct.id) AS total_card_transactions,
        SUM(ct.amount_usd) AS total_transaction_amounts
    FROM
        companies c
        INNER JOIN card_transactions ct ON c.id = ct.companyid
        INNER JOIN card_status cs       ON ct.statusid = cs.id

    GROUP BY 1
    ORDER BY c.name
)

SELECT *
FROM final