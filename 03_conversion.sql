-- ================================================
-- 03: Free → Premium Dönüşüm Oranı
-- Platform: Google BigQuery
-- ================================================

WITH user_subs AS (
    SELECT
        user_id,
        MAX(CASE WHEN subscription_type = 'free'    THEN 1 ELSE 0 END) AS was_free,
        MAX(CASE WHEN subscription_type = 'premium' THEN 1 ELSE 0 END) AS is_premium
    FROM `edtech.sessions`
    GROUP BY user_id
)

SELECT
    COUNT(*)                                                              AS total_users,
    COUNTIF(was_free = 1 AND is_premium = 1)                            AS converted,
    ROUND(COUNTIF(was_free = 1 AND is_premium = 1) * 100.0 / COUNT(*), 1) AS conversion_rate_pct
FROM user_subs;
