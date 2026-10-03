SELECT
    COUNT(*) AS total_priority_candidates,

    SUM(
        CASE
            WHEN maintenance_priority = 'High Attention'
            THEN 1
            ELSE 0
        END
    ) AS high_attention_count,

    SUM(
        CASE
            WHEN maintenance_priority = 'Monitor'
            THEN 1
            ELSE 0
        END
    ) AS monitor_count,

    SUM(
        CASE
            WHEN maintenance_priority = 'Covered'
            THEN 1
            ELSE 0
        END
    ) AS covered_count,

    CAST(
        AVG(CAST(failure_count AS DECIMAL(10,2)))
        AS DECIMAL(10,2)
    ) AS avg_failures_per_candidate,

    CAST(
        AVG(CAST(avg_days_to_maintenance AS DECIMAL(10,2)))
        AS DECIMAL(10,2)
    ) AS avg_days_to_maintenance,

    CAST(
        AVG(CAST(maintenance_coverage_pct AS DECIMAL(10,2)))
        AS DECIMAL(10,2)
    ) AS avg_maintenance_coverage_pct

FROM vw_Equipment_Reliability_Priority;