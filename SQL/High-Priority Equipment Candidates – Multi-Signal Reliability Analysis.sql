WITH ErrorSummary AS
(
    SELECT
        machineID,
        COUNT(*) AS error_count
    FROM EquipmentErrors
    GROUP BY machineID
),
FailureMaintenance AS
(
    SELECT
        f.machineID,
        f.failure AS component,
        f.datetime AS failure_date,
        m.datetime AS maintenance_date,
        DATEDIFF(day, f.datetime, m.datetime) AS days_to_maintenance
    FROM EquipmentFailures f
    OUTER APPLY
    (
        SELECT TOP 1
            em.datetime
        FROM EquipmentMaintenance em
        WHERE em.machineID = f.machineID
          AND em.comp = f.failure
          AND em.datetime > f.datetime
        ORDER BY em.datetime
    ) m
),
FailureSummary AS
(
    SELECT
        machineID,
        component,
        COUNT(*) AS failure_count,
        AVG(
            CAST(days_to_maintenance AS DECIMAL(10,2))
        ) AS avg_days_to_maintenance
    FROM FailureMaintenance
    WHERE days_to_maintenance IS NOT NULL
    GROUP BY
        machineID,
        component
)
SELECT
    f.machineID,
    e.model,
    e.age,
    f.component,
    f.failure_count,
    CAST(
        f.avg_days_to_maintenance AS DECIMAL(10,2)
    ) AS avg_days_to_maintenance,
    es.error_count
FROM FailureSummary f
INNER JOIN Equipment e
    ON f.machineID = e.machineID
INNER JOIN ErrorSummary es
    ON f.machineID = es.machineID
WHERE f.failure_count >= 3
  AND f.avg_days_to_maintenance >= 60
  AND es.error_count >= 45
ORDER BY
    f.failure_count DESC,
    f.avg_days_to_maintenance DESC,
    es.error_count DESC;