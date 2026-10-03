SELECT
m.machineID,
    m.comp,
    m.maintenance_count,
    f.failure_count
FROM
(
    SELECT
        machineID,
        comp,
        COUNT(*) AS maintenance_count
    FROM EquipmentMaintenance
    GROUP BY
        machineID,
        comp
) m
INNER JOIN
(
    SELECT
        machineID,
        failure,
        COUNT(*) AS failure_count
    FROM EquipmentFailures
    GROUP BY
        machineID,
        failure
) f
    ON m.machineID = f.machineID
    AND m.comp = f.failure;