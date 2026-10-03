WITH ErrorFailure AS
(
    SELECT
        e.machineID,
        e.errorID,
        e.datetime AS error_date,
        f.failure,
        f.datetime AS failure_date
    FROM EquipmentErrors e
    OUTER APPLY
    (
        SELECT TOP 1
            ef.failure,
            ef.datetime
        FROM EquipmentFailures ef
        WHERE ef.machineID = e.machineID
          AND ef.datetime > e.datetime
        ORDER BY ef.datetime
    ) f
),
ErrorSummary AS
(
    SELECT
        errorID,
        COUNT(*) AS total_error_events,
        COUNT(failure) AS errors_followed_by_failure
    FROM ErrorFailure
    GROUP BY errorID
),
ComponentSummary AS
(
    SELECT
        errorID,
        failure AS component,
        COUNT(*) AS failure_count
    FROM ErrorFailure
    WHERE failure IS NOT NULL
    GROUP BY errorID, failure
)
SELECT
    c.errorID,
    c.component,
    c.failure_count,
    e.errors_followed_by_failure,
    CAST(
        c.failure_count * 100.0
        / e.errors_followed_by_failure
        AS DECIMAL(10,2)
    ) AS component_failure_pct
FROM ComponentSummary c
JOIN ErrorSummary e
    ON c.errorID = e.errorID
ORDER BY
    c.errorID,
    component_failure_pct DESC;