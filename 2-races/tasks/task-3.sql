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
    ClassAveragePosition AS (
        -- Рассчитываем среднюю позицию для каждого класса автомобилей.
        SELECT car_class, AVG(average_position) AS class_avg_position
        FROM AveragePosition
        GROUP BY
            car_class
    ),
    MinClassAveragePosition AS (
        -- Находим минимальную среднюю позицию среди всех классов.
        SELECT MIN(class_avg_position) AS min_class_avg_position
        FROM ClassAveragePosition
    ),
    ClassTotalRaces AS (
        -- Рассчитываем общее количество гонок для каждого класса автомобилей.
        SELECT c.class AS car_class, COUNT(r.race) AS total_races
        FROM Cars c
            JOIN Results r ON c.name = r.car
        GROUP BY
            c.class
    )
SELECT ap.car_name, ap.car_class, ap.average_position, ap.race_count, cls.country AS car_country, ctr.total_races
FROM
    AveragePosition ap
    JOIN ClassAveragePosition cap ON ap.car_class = cap.car_class
    JOIN MinClassAveragePosition mcap ON cap.class_avg_position = mcap.min_class_avg_position
    JOIN Classes cls ON ap.car_class = cls.class
    JOIN ClassTotalRaces ctr ON ap.car_class = ctr.car_class
    -- Сортируем по имени автомобиля.
ORDER BY ap.car_name;