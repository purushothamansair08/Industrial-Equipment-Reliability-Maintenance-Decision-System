-- ============================================================
-- CORE TABLE DATA INTEGRITY CHECK
-- ============================================================

-- 1. Check for duplicate Equipment machine IDs
SELECT
    machineID,
    COUNT(*) AS DuplicateCount
FROM Equipment
GROUP BY machineID
HAVING COUNT(*) > 1;


-- 2. Check for orphan machine IDs in Measurements
SELECT COUNT(*) AS OrphanMeasurements
FROM EquipmentMeasurements em
LEFT JOIN Equipment e
    ON em.machineID = e.machineID
WHERE e.machineID IS NULL;


-- 3. Check for orphan machine IDs in Errors
SELECT COUNT(*) AS OrphanErrors
FROM EquipmentErrors ee
LEFT JOIN Equipment e
    ON ee.machineID = e.machineID
WHERE e.machineID IS NULL;


-- 4. Check for orphan machine IDs in Maintenance
SELECT COUNT(*) AS OrphanMaintenance
FROM EquipmentMaintenance em
LEFT JOIN Equipment e
    ON em.machineID = e.machineID
WHERE e.machineID IS NULL;


-- 5. Check for orphan machine IDs in Failures
SELECT COUNT(*) AS OrphanFailures
FROM EquipmentFailures ef
LEFT JOIN Equipment e
    ON ef.machineID = e.machineID
WHERE e.machineID IS NULL;