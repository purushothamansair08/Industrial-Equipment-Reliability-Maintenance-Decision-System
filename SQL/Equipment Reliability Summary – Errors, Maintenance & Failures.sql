SELECT
    e.machineID,
    e.model,
    e.age,
    ISNULL(er.error_count, 0) AS error_count,
    ISNULL(m.maintenance_count, 0) AS maintenance_count,
    ISNULL(f.failure_count, 0) AS failure_count
FROM Equipment e

LEFT JOIN
(
    SELECT
        machineID,
        COUNT(*) AS error_count
    FROM EquipmentErrors
    GROUP BY machineID
) er
    ON e.machineID = er.machineID

LEFT JOIN
(
    SELECT
        machineID,
        COUNT(*) AS maintenance_count
    FROM EquipmentMaintenance
    GROUP BY machineID
) m
    ON e.machineID = m.machineID

LEFT JOIN
(
    SELECT
        machineID,
        COUNT(*) AS failure_count
    FROM EquipmentFailures
    GROUP BY machineID
) f
    ON e.machineID = f.machineID;