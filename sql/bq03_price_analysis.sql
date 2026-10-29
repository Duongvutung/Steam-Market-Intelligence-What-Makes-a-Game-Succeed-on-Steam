-- BQ3: Phân tích phân khúc giá và tỷ lệ game Free so với Paid
-- Mục tiêu: Thống kê số lượng game theo các dải giá chuẩn

SELECT 
    CASE 
        WHEN price_initial_USD = 0 THEN 'Free (0)'
        WHEN price_initial_USD > 0 AND price_initial_USD <= 5 THEN 'Low (>0-5)'
        WHEN price_initial_USD > 5 AND price_initial_USD <= 15 THEN 'Mid (>5-15)'
        WHEN price_initial_USD > 15 AND price_initial_USD <= 30 THEN 'High (>15-30)'
        ELSE 'Premium (>30)'
    END AS price_band,
    COUNT(steam_appid) AS total_games,
    ROUND(AVG(CAST(total_positive AS FLOAT) / NULLIF(total_reviews, 0)), 4) * 100 AS avg_positive_ratio
FROM steam_games
WHERE is_released = 1
GROUP BY 
    CASE 
        WHEN price_initial_USD = 0 THEN 'Free (0)'
        WHEN price_initial_USD > 0 AND price_initial_USD <= 5 THEN 'Low (>0-5)'
        WHEN price_initial_USD > 5 AND price_initial_USD <= 15 THEN 'Mid (>5-15)'
        WHEN price_initial_USD > 15 AND price_initial_USD <= 30 THEN 'High (>15-30)'
        ELSE 'Premium (>30)'
    END
ORDER BY total_games DESC;