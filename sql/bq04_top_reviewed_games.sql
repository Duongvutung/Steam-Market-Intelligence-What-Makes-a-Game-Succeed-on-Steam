-- BQ4: Top 10 tựa game có tổng số lượt review cao nhất (Độ phủ tương tác lớn nhất)
-- Mục tiêu: Xác định các tựa game bom tấn dẫn dắt cộng đồng Steam

SELECT 
    top 10 
    name,
    developers,
    publishers,
    price_initial_USD,
    total_positive + total_negative AS total_reviews_calc,
    ROUND(CAST(total_positive as FLOAT) / NULLIf(total_reviews, 0) * 100, 2) as positive_ratio
FROM steam_games
WHERE is_released = 1
ORDER BY total_reviews_calc DESC
