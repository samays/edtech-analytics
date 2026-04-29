-- ================================================
-- 01: Kurs Bazında Completion Rate
-- Platform: Google BigQuery
-- ================================================

SELECT
    course_id,
    COUNT(*)                                                        AS total_sessions,
    COUNTIF(lesson_completed = true)                               AS completed,
    ROUND(COUNTIF(lesson_completed = true) * 100.0 / COUNT(*), 1) AS completion_rate_pct
FROM `edtech.sessions`
GROUP BY course_id
ORDER BY completion_rate_pct DESC;
