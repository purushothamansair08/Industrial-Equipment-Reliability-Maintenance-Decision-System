SELECT TOP 1
    e.machineid,
    e.age,
    e.model,
    COUNT(f.failure) AS Failure_count
FROM Equipment e
LEFT JOIN EquipmentFailures f
    ON e.machineid = f.machineid
GROUP BY
    e.machineid,
    e.age,
    e.model
ORDER BY
    e.age DESC,
    Failure_count DESC;