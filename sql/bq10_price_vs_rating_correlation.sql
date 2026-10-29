-- BQ10: Khảo sát mối quan hệ giữa các phân khúc giá và tỷ lệ đánh giá tích cực
SELECT 
    CASE 
        WHEN price_initial_USD = 0 THEN '0. Free'
        WHEN price_initial_USD <= 10 THEN '1. Under $10'
        WHEN price_initial_USD <= 30 THEN '2. $10 - $30'
        ELSE '3. Above $30'
    END AS price_tier,
    COUNT(steam_appid) AS total_games,
    ROUND(AVG(CAST(total_positive AS FLOAT) / NULLIF(total_reviews, 0)) * 100, 2) AS avg_positive_ratio
FROM steam_games
WHERE is_released = 1
GROUP BY 
    CASE 
        WHEN price_initial_USD = 0 THEN '0. Free'
        WHEN price_initial_USD <= 10 THEN '1. Under $10'
        WHEN price_initial_USD <= 30 THEN '2. $10 - $30'
        ELSE '3. Above $30'
    END
ORDER BY price_tier ASC;