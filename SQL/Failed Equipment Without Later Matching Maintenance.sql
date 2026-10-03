SELECT
    e.machineid,
    e.model,
    e.age,
    f.failure,
    f.datetime AS failure_date
FROM Equipment e
INNER JOIN EquipmentFailures f
    ON e.machineid = f.machineid
WHERE NOT EXISTS
(
    SELECT 1
    FROM EquipmentMaintenance m
    WHERE m.machineid = f.machineid
      AND m.comp = f.failure
      AND m.datetime > f.datetime
)
ORDER BY
    e.machineid,
    f.datetime;