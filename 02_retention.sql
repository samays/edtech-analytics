-- ================================================
-- 02: Kullanıcı Retention (D1 / D7)
-- Platform: Google BigQuery
-- ================================================

WITH first_seen AS (
    SELECT
        user_id,
        MIN(CAST(date AS DATE)) AS first_date
    FROM `edtech.sessions`
    GROUP BY user_id
),

activity AS (
    SELECT
        e.user_id,
        DATE_DIFF(CAST(e.date AS DATE), f.first_date, DAY) AS day_diff
    FROM `edtech.sessions` e
    JOIN first_seen f ON e.user_id = f.user_id
)

SELECT
    COUNT(DISTINCT user_id)                                                          AS total_users,
    COUNT(DISTINCT CASE WHEN day_diff = 1  THEN user_id END)                        AS d1_returned,
    COUNT(DISTINCT CASE WHEN day_diff = 7  THEN user_id END)                        AS d7_returned,
    ROUND(COUNT(DISTINCT CASE WHEN day_diff = 1 THEN user_id END) * 1.0
        / COUNT(DISTINCT user_id), 4)                                                AS d1_retention,
    ROUND(COUNT(DISTINCT CASE WHEN day_diff = 7 THEN user_id END) * 1.0
        / COUNT(DISTINCT user_id), 4)                                                AS d7_retention
FROM activity;
