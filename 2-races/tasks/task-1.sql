WITH
    AveragePosition AS (
        -- Рассчитываем среднюю позицию и количество гонок для каждого автомобиля.
        SELECT
            c.name AS car_name,
            c.class AS car_class,
            ROUND(AVG(r.position), 4) AS average_position,
            COUNT(r.race) AS race_count
        FROM Cars c
            JOIN Results r ON c.name = r.car
        GROUP BY
            c.name,
            c.class
    ),
    MinAveragePosition AS (
        -- Находим минимальную среднюю позицию в гонках для каждого класса.
        SELECT car_class, MIN(average_position) AS min_avg_position
        FROM AveragePosition
        GROUP BY
            car_class
    )
SELECT ap.car_name, ap.car_class, ap.average_position, ap.race_count
FROM
    AveragePosition ap
    JOIN MinAveragePosition map ON ap.car_class = map.car_class
    AND ap.average_position = map.min_avg_position
    -- Сортируем конечный результат по средней позиции.
ORDER BY ap.average_position;