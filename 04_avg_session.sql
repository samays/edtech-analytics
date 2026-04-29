-- ================================================
-- 04: Ortalama Session Süresi
-- Platform: Google BigQuery
-- ================================================

-- Genel ortalama
SELECT
    ROUND(AVG(time_spent), 2) AS avg_session_minutes
FROM `edtech.sessions`;

-- Abonelik türüne göre
SELECT
    subscription_type,
    COUNT(DISTINCT user_id)                                                AS unique_users,
    COUNT(*)                                                               AS total_sessions,
    ROUND(AVG(time_spent), 1)                                             AS avg_minutes,
    ROUND(COUNTIF(lesson_completed = true) * 100.0 / COUNT(*), 1)        AS completion_rate_pct
FROM `edtech.sessions`
GROUP BY subscription_type
ORDER BY avg_minutes DESC;
