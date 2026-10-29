-- BQ8: Phân tích ảnh hưởng của hệ điều hành (platforms) đến số lượng game
SELECT 
    platforms,
    COUNT(steam_appid) AS total_games,
    ROUND(AVG(CAST(total_positive AS FLOAT) / NULLIF(total_reviews, 0)) * 100, 2) AS avg_positive_ratio
FROM steam_games
WHERE is_released = 1
GROUP BY platforms
ORDER BY total_games DESC;