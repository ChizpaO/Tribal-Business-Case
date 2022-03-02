WITH companies AS (

        SELECT *
        FROM {{source('tribal','companies')}}

)

SELECT *
FROM companies