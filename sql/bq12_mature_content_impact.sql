-- BQ12: Đánh giá tác động của độ tuổi yêu cầu (required_age) đến quy mô tương tác

SELECT 
    required_age,
    COUNT(steam_appid) AS total_games,
    ROUND(AVG(CAST(total_positive AS FLOAT) / NULLIF(total_reviews, 0)) * 100, 2) AS avg_positive_ratio,
    SUM(total_positive + total_negative) AS total_reviews_sum
FROM steam_games
WHERE is_released = 1
GROUP BY required_age
ORDER BY required_age ASC;