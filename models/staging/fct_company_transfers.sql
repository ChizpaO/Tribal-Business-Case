WITH companies AS (
    SELECT *
    FROM {{ref('dim_companies')}}
),

transfers AS (
    SELECT *
    FROM {{ref('stg_wire_transfers')}} 
),

transfer_status AS (
    SELECT *
    FROM {{ref('dim_wire_transfer_status')}} 
),

final AS (
    SELECT
        t.companyid,
        c.name,
        SUM(CASE WHEN  t.statusid = '1' THEN 1 ELSE 0 END) AS Procesing,
        SUM(CASE WHEN  t.statusid = '1' THEN t.usd_amount ELSE 0 END) AS procesing_amount,
        SUM(CASE WHEN  t.statusid = '2' THEN 1 ELSE 0 END) AS Retunred,
        SUM(CASE WHEN  t.statusid = '2' THEN t.usd_amount ELSE 0 END) AS returned_amount,
        SUM(CASE WHEN  t.statusid = '3' THEN 1 ELSE 0 END) AS Completed,
        SUM(CASE WHEN  t.statusid = '3' THEN t.usd_amount ELSE 0 END) AS completed_amount,
        SUM(CASE WHEN  t.statusid = '4' THEN 1 ELSE 0 END) AS Failed,
        SUM(CASE WHEN  t.statusid = '4' THEN t.usd_amount ELSE 0 END) AS failed_amount,
        COUNT(DISTINCT t.id) AS total_transfers,
        SUM(t.usd_amount) AS total_amount_transfers
    FROM
        companies c
        INNER JOIN transfers t          ON t.companyid = c.id
        INNER JOIN transfer_status ts   ON t.statusid = ts.id
    GROUP BY 1, 2
    ORDER BY c.name
)

SELECT *
FROM final