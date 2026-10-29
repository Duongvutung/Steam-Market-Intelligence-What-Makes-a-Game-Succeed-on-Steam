-- BQ1: Phân tích xu hướng phát hành game theo các năm
-- Mục tiêu: Đếm số lượng game phát hành chính thức qua từng năm dựa trên release_date

SELECT 
    YEAR(release_date) as release_year,
    COUNT(steam_appid) AS total_games
FROM steam_games
WHERE is_released = 1 
GROUP BY YEAR(release_date)
ORDER BY release_year DESC;