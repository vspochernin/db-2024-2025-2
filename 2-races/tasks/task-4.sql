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
        -- Рассчитываем среднюю позицию и количество автомобилей для каждого класса.
        SELECT
            c.class AS car_class,
            AVG(r.position) AS class_avg_position,
            COUNT(DISTINCT c.name) AS class_car_count
        FROM Cars c
            JOIN Results r ON c.name = r.car
        GROUP BY
            c.class
    )
SELECT ap.car_name, ap.car_class, ap.average_position, ap.race_count, cls.country AS car_country
FROM
    AveragePosition ap
    JOIN ClassAveragePosition cap ON ap.car_class = cap.car_class
    JOIN Classes cls ON ap.car_class = cls.class
WHERE
    -- Средняя позиция автомобиля должна быть лучше (меньше), чем средняя позиция по классу.
    -- Также проверяем, что в классе больше одного автомобиля.
    ap.average_position < cap.class_avg_position
    AND cap.class_car_count >= 2
    -- Сортируем по классу и по средней позиции в порядке возрастания.
ORDER BY ap.car_class, ap.average_position;
