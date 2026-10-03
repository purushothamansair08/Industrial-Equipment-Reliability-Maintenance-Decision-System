WITH ErrorSummary AS
(
    SELECT
        machineID,
        COUNT(*) AS error_count
    FROM EquipmentErrors
    GROUP BY machineID
),
FailureSummary AS
(
    SELECT
        machineID,
        COUNT(*) AS failure_count
    FROM EquipmentFailures
    GROUP BY machineID
),
MachineSummary AS
(
    SELECT
        e.machineID,
        e.error_count,
        ISNULL(f.failure_count, 0) AS failure_count
    FROM ErrorSummary e
    LEFT JOIN FailureSummary f
        ON e.machineID = f.machineID
)

SELECT
    failure_count,
    COUNT(*) AS machine_count,
    SUM(error_count) AS total_errors,
    CAST(
        AVG(CAST(error_count AS DECIMAL(10,2)))
        AS DECIMAL(10,2)
    ) AS avg_errors_per_machine
FROM MachineSummary
GROUP BY failure_count
ORDER BY failure_count;