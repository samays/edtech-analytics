-- ================================================
-- 05: Cihaz × Abonelik Segmenti Analizi
-- Platform: Google BigQuery
-- ================================================

SELECT
    device_type,
    subscription_type,
    COUNT(DISTINCT user_id)                                                AS users,
    ROUND(AVG(time_spent), 1)                                             AS avg_time,
    COUNTIF(lesson_completed = true)                                      AS completions,
    ROUND(COUNTIF(lesson_completed = true) * 100.0 / COUNT(*), 1)        AS completion_rate_pct,
    SUM(time_spent)                                                        AS total_minutes
FROM `edtech.sessions`
GROUP BY device_type, subscription_type
ORDER BY avg_time DESC;
