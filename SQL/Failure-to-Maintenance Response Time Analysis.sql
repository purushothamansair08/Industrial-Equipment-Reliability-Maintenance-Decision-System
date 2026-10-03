SELECT
    f.machineID,
    f.failure,
    f.datetime AS failure_date,
    m.comp,
    m.datetime AS maintenance_date,
    DATEDIFF(day, f.datetime, m.datetime) as days_taken
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
ORDER BY
    f.machineID,
    f.datetime;