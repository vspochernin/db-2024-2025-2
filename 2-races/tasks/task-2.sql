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
        -- Находим минимальную среднюю позицию среди всех автомобилей.
        SELECT MIN(average_position) AS min_avg_position
        FROM AveragePosition
    )
SELECT ap.car_name, ap.car_class, ap.average_position, ap.race_count, cls.country AS car_country
FROM
    AveragePosition ap
    JOIN MinAveragePosition map ON ap.average_position = map.min_avg_position
    JOIN Classes cls ON ap.car_class = cls.class
    -- Сортируем по имени автомобиля.
ORDER BY ap.car_name
    -- Даем предел выборке до одного результата, чтобы выбрать только один автомобиль.
LIMIT 1;
