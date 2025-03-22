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
    LowPositionCars AS (
        -- Выбираем автомобили с низкой средней позицией больше 3.0.
        SELECT
            car_name,
            car_class,
            average_position,
            race_count
        FROM AveragePosition
        WHERE
            average_position > 3.0
    ),
    ClassLowPositionCount AS (
        -- Подсчитываем количество автомобилей с низкой средней позицией в каждом классе.
        SELECT lpc.car_class, COUNT(*) AS low_position_count
        FROM LowPositionCars lpc
        GROUP BY
            lpc.car_class
    ),
    ClassTotalRaces AS (
        -- Подсчитываем общее количество гонок для каждого класса.
        SELECT c.class AS car_class, COUNT(r.race) AS total_races
        FROM Cars c
            JOIN Results r ON c.name = r.car
        GROUP BY
            c.class
    )
SELECT lpc.car_name, lpc.car_class, lpc.average_position, lpc.race_count, cls.country AS car_country, ctr.total_races, clpc.low_position_count
FROM
    LowPositionCars lpc
    JOIN Classes cls ON lpc.car_class = cls.class
    JOIN ClassTotalRaces ctr ON lpc.car_class = ctr.car_class
    JOIN ClassLowPositionCount clpc ON lpc.car_class = clpc.car_class
    -- Сортируем по количеству автомобилей с низкой средней позицией в порядке убывания.
ORDER BY clpc.low_position_count DESC, lpc.car_name;