SELECT
    e.age,
    e.no_of_machines,
    e.maintenance_count,
    CAST(
        CAST(e.maintenance_count AS DECIMAL(10,2))
        / e.no_of_machines
        AS DECIMAL(10,2)
    ) AS maintenance_per_machine
FROM
(
    SELECT
        e.age,
        COUNT(DISTINCT e.machineID) AS no_of_machines,
        COUNT(m.comp) AS maintenance_count
    FROM Equipment e
    LEFT JOIN EquipmentMaintenance m
        ON e.machineID = m.machineID
    GROUP BY e.age
) e
ORDER BY e.age;