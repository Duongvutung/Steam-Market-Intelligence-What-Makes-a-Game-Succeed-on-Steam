-- BQ9: Thống kê quy mô game theo nhãn phân loại review_score

SELECT 
    review_score,
    COUNT(steam_appid) AS total_games,
    ROUND(AVG(price_initial_USD), 2) AS avg_price
FROM steam_games
WHERE is_released = 1
GROUP BY review_score
ORDER BY total_games DESC;