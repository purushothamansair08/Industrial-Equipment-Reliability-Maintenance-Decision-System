SELECT
    e.age,
    e.no_of_machines,
    e.failure_count,
CAST(
    CAST(e.failure_count AS DECIMAL(10,2))
    / e.no_of_machines
    AS DECIMAL(10,2)
) AS failures_per_machine
FROM
(
    SELECT
        e.age,
        COUNT(DISTINCT e.machineID) AS no_of_machines,
        COUNT(f.failure) AS failure_count
    FROM Equipment e
    LEFT JOIN EquipmentFailures f
        ON e.machineID = f.machineID
    GROUP BY e.age
) e
ORDER BY e.age;