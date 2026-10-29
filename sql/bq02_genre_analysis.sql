-- BQ2: Phân tích các thể loại game (genres) phổ biến và mức độ đón nhận
-- Mục tiêu: Thống kê số lượng game, tổng lượt review và tỷ lệ tích cực trung bình theo từng nhóm genres

SELECT 
    top 20
    genres,
    COUNT(steam_appid) AS total_games,
    SUM(total_reviews) AS total_reviews_sum,
    ROUND(AVG(CAST(total_positive AS FLOAT) / NULLIF(total_reviews, 0)), 4) AS avg_positive_ratio
FROM steam_games
WHERE is_released = 1 
  AND genres IS NOT NULL
GROUP BY genres
ORDER BY total_games DESC