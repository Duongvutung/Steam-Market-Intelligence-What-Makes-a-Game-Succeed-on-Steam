-- BQ7: Top 10 nhà phát hành (Publishers) có tổng lượng tương tác lớn nhất

SELECT 
    TOP 10
    publishers,
    COUNT(steam_appid) AS total_games,
    SUM(total_positive + total_negative) AS total_reviews_sum,
    ROUND(AVG(CAST(total_positive AS FLOAT) / NULLIF(total_reviews, 0)) * 100, 2) AS avg_positive_ratio
FROM steam_games
WHERE is_released = 1 AND publishers IS NOT NULL AND publishers != ''
GROUP BY publishers
ORDER BY total_reviews_sum DESC