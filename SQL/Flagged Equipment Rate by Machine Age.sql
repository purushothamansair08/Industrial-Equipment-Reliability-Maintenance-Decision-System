WITH FailureMaintenance AS
(
    SELECT
        f.machineID,
        f.failure AS component,
        m.datetime AS maintenance_date,
        DATEDIFF(day, f.datetime, m.datetime) AS days_taken
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
FlaggedCombinations AS
(
    SELECT
        machineID,
        component
    FROM FailureMaintenance
    WHERE days_taken IS NOT NULL
    GROUP BY
        machineID,
        component
    HAVING
        COUNT(*) >= 3
        AND AVG(CAST(days_taken AS DECIMAL(10,2))) >= 60
),
FlaggedMachines AS
(
    SELECT DISTINCT
        machineID
    FROM FlaggedCombinations
)

SELECT
    e.age,
    COUNT(DISTINCT e.machineID) AS total_machines,
    COUNT(DISTINCT fm.machineID) AS flagged_machines,
    CAST(
        COUNT(DISTINCT fm.machineID) * 100.0
        / COUNT(DISTINCT e.machineID)
        AS DECIMAL(10,2)
    ) AS flagged_machine_pct
FROM Equipment e
LEFT JOIN FlaggedMachines fm
    ON e.machineID = fm.machineID
GROUP BY
    e.age
ORDER BY
    e.age DESC;