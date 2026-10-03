WITH FailureMaintenance AS
(
    SELECT
        f.machineID,
        f.failure,
        f.datetime AS failure_date,
        m.comp,
        m.datetime AS maintenance_date,
        DATEDIFF(day, f.datetime, m.datetime) AS days_taken
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

SELECT TOP 1
    comp,
    CAST(AVG(CAST(days_taken AS DECIMAL(10,2))) AS DECIMAL(10,2)) AS avg_days_to_maintenance
FROM FailureMaintenance
WHERE days_taken IS NOT NULL
GROUP BY comp
ORDER BY AVG(days_taken) DESC;