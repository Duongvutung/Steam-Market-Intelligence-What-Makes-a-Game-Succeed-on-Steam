-- BQ5: Phân tích ảnh hưởng của số lượng achievements đến tỷ lệ review tích cực
SELECT 
    CASE 
        WHEN n_achievements = 0 THEN '0 Achievements'
        WHEN n_achievements BETWEEN 1 AND 10 THEN '1-10 Achievements'
        WHEN n_achievements BETWEEN 11 AND 50 THEN '11-50 Achievements'
        ELSE '50+ Achievements'
    END AS achievement_group,
    COUNT(steam_appid) AS total_games,
    ROUND(AVG(CAST(total_positive AS FLOAT) / NULLIF(total_reviews, 0)) * 100, 2) AS avg_positive_ratio
FROM steam_games
WHERE is_released = 1
GROUP BY 
    CASE 
        WHEN n_achievements = 0 THEN '0 Achievements'
        WHEN n_achievements BETWEEN 1 AND 10 THEN '1-10 Achievements'
        WHEN n_achievements BETWEEN 11 AND 50 THEN '11-50 Achievements'
        ELSE '50+ Achievements'
    END
ORDER BY total_games DESC;