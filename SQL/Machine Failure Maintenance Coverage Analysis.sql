WITH FailureMaintenance AS
(
    SELECT
        f.machineID,
        f.failure,
        f.datetime AS failure_date,
        m.datetime AS maintenance_date
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
)

SELECT
    machineID,
    COUNT(*) AS total_failures,
    COUNT(maintenance_date) AS failures_with_maintenance,
    CAST(
        COUNT(maintenance_date) * 100.0 / COUNT(*)
        AS DECIMAL(10,2)
    ) AS maintenance_coverage_pct
FROM FailureMaintenance
GROUP BY machineID
ORDER BY
    total_failures DESC,
    maintenance_coverage_pct ASC;