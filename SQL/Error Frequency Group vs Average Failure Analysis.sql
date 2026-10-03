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
),
GroupedMachines AS
(
    SELECT
        machineID,
        error_count,
        failure_count,
        CASE
            WHEN error_count < 35 THEN 'Low'
            WHEN error_count BETWEEN 35 AND 44 THEN 'Medium'
            ELSE 'High'
        END AS error_group
    FROM MachineSummary
)
SELECT
    error_group,
    COUNT(*) AS machine_count,
    SUM(error_count) AS total_errors,
    SUM(failure_count) AS total_failures,
    CAST(
        AVG(CAST(failure_count AS DECIMAL(10,2)))
        AS DECIMAL(10,2)
    ) AS avg_failures_per_machine
FROM GroupedMachines
GROUP BY error_group;