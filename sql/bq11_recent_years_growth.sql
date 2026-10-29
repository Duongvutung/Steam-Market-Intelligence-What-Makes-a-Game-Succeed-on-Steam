-- BQ11: Tổng hợp khối lượng review bùng nổ theo từng năm phát hành từ 2015 đến nay
SELECT 
    SUBSTRING(release_date, 1, 4) AS release_year,
    COUNT(steam_appid) AS total_games,
    SUM(total_positive + total_negative) AS annual_reviews
FROM steam_games
WHERE is_released = 1 AND release_date LIKE '____-__-%'
GROUP BY SUBSTRING(release_date, 1, 4)
HAVING SUBSTRING(release_date, 1, 4) >= '2015'
ORDER BY release_year DESC;