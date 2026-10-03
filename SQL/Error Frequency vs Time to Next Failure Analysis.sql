WITH ErrorFailureResponse AS
(
    SELECT
        e.machineID,
        e.datetime AS error_date,
        f.datetime AS failure_date,
        DATEDIFF(day, e.datetime, f.datetime) AS days_to_failure
    FROM EquipmentErrors e
    OUTER APPLY
    (
        SELECT TOP 1
            ef.datetime
        FROM EquipmentFailures ef
        WHERE ef.machineID = e.machineID
          AND ef.datetime > e.datetime
        ORDER BY ef.datetime
    ) f
),
MachineSummary AS
(
    SELECT
        machineID,
        COUNT(*) AS error_count,
        AVG(CAST(days_to_failure AS DECIMAL(10,2))) AS avg_days_to_failure
    FROM ErrorFailureResponse
    WHERE days_to_failure IS NOT NULL
    GROUP BY machineID
)
SELECT
    CASE
        WHEN error_count < 35 THEN 'Low'
        WHEN error_count BETWEEN 35 AND 44 THEN 'Medium'
        ELSE 'High'
    END AS error_group,
    COUNT(*) AS machine_count,
    CAST(
        AVG(avg_days_to_failure)
        AS DECIMAL(10,2)
    ) AS avg_days_to_failure
FROM MachineSummary
GROUP BY
    CASE
        WHEN error_count < 35 THEN 'Low'
        WHEN error_count BETWEEN 35 AND 44 THEN 'Medium'
        ELSE 'High'
    END;