SELECT v.maker, m.model
FROM Motorcycle m
    -- Проводим соединение с таблицей Vehicle для получения информации о производителе.
    JOIN Vehicle v ON m.model = v.model
WHERE
    m.horsepower > 150 -- Мощность больше 150 лошадиных сил.
    AND m.price < 20000 -- Цена меньше 20 000 долларов.
    AND m.type = 'Sport' -- Тип мотоцикла: только Sport.
    -- Сортируем по мощности в порядке убывания.
ORDER BY m.horsepower DESC;
