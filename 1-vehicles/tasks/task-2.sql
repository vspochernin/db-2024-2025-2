-- Выборка данных для Автомобилей.
SELECT v.maker, c.model, c.horsepower, c.engine_capacity, 'Car' AS vehicle_type
FROM Car c
    JOIN Vehicle v ON c.model = v.model
WHERE
    c.horsepower > 150 -- Мощность более 150 л.с.
    AND c.engine_capacity < 3.0 -- Объем двигателя менее 3 литров.
    AND c.price < 35000 -- Цена менее 35 000 долларов.
UNION ALL

-- Выборка данных для Мотоциклов.
SELECT v.maker, m.model, m.horsepower, m.engine_capacity, 'Motorcycle' AS vehicle_type
FROM Motorcycle m
    JOIN Vehicle v ON m.model = v.model
WHERE
    m.horsepower > 150 -- Мощность более чем 150 л.с.
    AND m.engine_capacity < 1.5 -- Объем двигателя менее 1.5 литров>
    AND m.price < 20000 -- Цена менее 20 000 долларов.
UNION ALL

-- Выборка данных для Велосипедов.
SELECT
    v.maker,
    b.model,
    NULL AS horsepower,
    NULL AS engine_capacity,
    'Bicycle' AS vehicle_type
FROM Bicycle b
    JOIN Vehicle v ON b.model = v.model
WHERE
    b.gear_count > 18 -- Количество передач более чем 18.
    AND b.price < 4000 -- Цена менее 4 000 долларов.

-- Сортируем по мощности в порядке убывания.
-- Отдельно указываем, чтобы велосипеды находились в конце.
ORDER BY horsepower DESC NULLS LAST;