-- BQ6: So sánh chi tiết hiệu suất giữa Game Free và Game Trả phí
SELECT 
    CASE 
        WHEN price_initial_USD = 0 THEN 'Free' 
        ELSE 'Paid' 
    END AS pricing_model,
    COUNT(steam_appid) AS total_games,
    SUM(total_positive + total_negative) AS total_reviews_sum,
    ROUND(AVG(CAST(total_positive AS FLOAT) / NULLIF(total_reviews, 0)) * 100, 2) AS avg_positive_ratio
FROM steam_games
WHERE is_released = 1
GROUP BY 
    CASE 
        WHEN price_initial_USD = 0 THEN 'Free' 
        ELSE 'Paid' 
    END;