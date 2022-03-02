WITH wire_transfers AS (

        SELECT *
        FROM {{source('tribal','wire_transfers')}}

)

SELECT *
FROM wire_transfers