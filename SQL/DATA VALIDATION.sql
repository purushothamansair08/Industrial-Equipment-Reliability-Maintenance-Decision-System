/* ============================================================
   DATA VALIDATION
   Industrial Equipment Reliability & Maintenance
   ============================================================ */
-- 1. Machine + Component Uniqueness
-- Each machine-component combination should appear only once
-- in the final reliability priority view.

SELECT
    machineID,
    component,
    COUNT(*) AS row_count
FROM vw_Equipment_Reliability_Priority
GROUP BY
    machineID,
    component
HAVING COUNT(*) > 1;
-- ============================================================
-- 2. Business Rule Validation
-- Every candidate must satisfy:
-- Failure Count >= 3
-- Average Days to Maintenance >= 60
-- Error Count >= 45
-- ============================================================
SELECT *
FROM vw_Equipment_Reliability_Priority
WHERE failure_count < 3
   OR avg_days_to_maintenance < 60
   OR error_count < 45;
-- ============================================================
-- 3. Priority Classification Validation
-- Verify that maintenance coverage correctly determines
-- the assigned maintenance priority.
-- ============================================================
SELECT *
FROM vw_Equipment_Reliability_Priority
WHERE
       (maintenance_coverage_pct < 80
        AND maintenance_priority <> 'High Attention')

    OR (maintenance_coverage_pct >= 80
        AND maintenance_coverage_pct < 100
        AND maintenance_priority <> 'Monitor')

    OR (maintenance_coverage_pct = 100
        AND maintenance_priority <> 'Covered');
-- ============================================================
-- 4. NULL Validation
-- Required fields in the final decision view should not be NULL.
-- ============================================================
SELECT *
FROM vw_Equipment_Reliability_Priority
WHERE machineID IS NULL
   OR component IS NULL
   OR failure_count IS NULL
   OR avg_days_to_maintenance IS NULL
   OR error_count IS NULL
   OR maintenance_coverage_pct IS NULL
   OR maintenance_priority IS NULL;
-- ============================================================
-- 5. Priority Summary Validation
-- Confirm the final number of records by priority.
-- ============================================================
SELECT
    maintenance_priority,
    COUNT(*) AS candidate_count
FROM vw_Equipment_Reliability_Priority
GROUP BY maintenance_priority
ORDER BY maintenance_priority;
-- ============================================================
-- 6. Final Validation Summary
-- ============================================================

SELECT
    COUNT(*) AS total_priority_candidates,
    SUM(CASE
            WHEN maintenance_priority = 'High Attention'
            THEN 1 ELSE 0
        END) AS high_attention_count,
    SUM(CASE
            WHEN maintenance_priority = 'Monitor'
            THEN 1 ELSE 0
        END) AS monitor_count,
    SUM(CASE
            WHEN maintenance_priority = 'Covered'
            THEN 1 ELSE 0
        END) AS covered_count
FROM vw_Equipment_Reliability_Priority;

