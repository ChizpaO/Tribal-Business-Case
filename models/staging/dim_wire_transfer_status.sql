WITH wire_transfers_status AS (

        SELECT *
        FROM {{source('tribal','wire_transfers_status')}}

)

SELECT *
FROM wire_transfers_status