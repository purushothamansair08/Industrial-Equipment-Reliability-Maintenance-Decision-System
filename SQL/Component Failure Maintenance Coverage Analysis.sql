WITH FailureMaintenance AS
(
    SELECT
        f.machineID,
        f.failure,
        f.datetime AS failure_date,
        m.comp,
        m.datetime AS maintenance_date
    FROM EquipmentFailures f
    OUTER APPLY
    (
        SELECT TOP 1
            em.comp,
            em.datetime
        FROM EquipmentMaintenance em
        WHERE em.machineID = f.machineID
          AND em.comp = f.failure
          AND em.datetime > f.datetime
        ORDER BY em.datetime
    ) m
)

SELECT
    failure AS comp,
    COUNT(*) AS total_failures,
    COUNT(maintenance_date) AS failures_with_maintenance,
    CAST(
        COUNT(maintenance_date) * 100.0 / COUNT(*)
        AS DECIMAL(10,2)
    ) AS maintenance_coverage_pct
FROM FailureMaintenance
GROUP BY failure
ORDER BY maintenance_coverage_pct DESC;