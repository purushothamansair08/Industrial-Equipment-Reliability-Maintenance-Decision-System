SELECT
    machineID,
    failure AS component,
    COUNT(*) AS failure_count
FROM EquipmentFailures
GROUP BY
    machineID,
    failure
ORDER BY
    failure_count DESC,
    machineID;