WITH
    ClientBookings AS (
        -- Выбираем клиентов, которые сделали более двух бронирований и побывали более чем в одном уникальном отеле.
        SELECT
            c.ID_customer,
            c.name,
            COUNT(b.ID_booking) AS total_bookings, -- Общее количество бронирований клиента.
            COUNT(DISTINCT h.ID_hotel) AS unique_hotels, -- Общее количество уникальных отелей.
            SUM(r.price) AS total_spent -- Общая сумма, потраченная клиентом на все бронирования.
        FROM
            Booking b
            JOIN Customer c ON b.ID_customer = c.ID_customer
            JOIN Room r ON b.ID_room = r.ID_room
            JOIN Hotel h ON r.ID_hotel = h.ID_hotel
        GROUP BY
            c.ID_customer,
            c.name
        HAVING
            COUNT(b.ID_booking) > 2
            AND COUNT(DISTINCT h.ID_hotel) > 1 -- Условия отбора клиентов.
    ),
    ClientSpentMoreThan500 AS (
        -- Выбираем клиентов, которые суммарно потратили более 500 долларов.
        SELECT
            c.ID_customer,
            c.name,
            SUM(r.price) AS total_spent, -- Общая сумма, потраченная клиентом.
            COUNT(b.ID_booking) AS total_bookings -- Общее количество бронирований клиента.
        FROM
            Booking b
            JOIN Customer c ON b.ID_customer = c.ID_customer
            JOIN Room r ON b.ID_room = r.ID_room
        GROUP BY
            c.ID_customer,
            c.name
        HAVING
            SUM(r.price) > 500 -- Условие отбора клиентов по потраченной сумме.
    )
    -- Соединяем клиентов, отобранных по условиям в обоих CTE.
SELECT cb.ID_customer AS ID_customer, cb.name, cb.total_bookings, cb.total_spent, cb.unique_hotels
FROM
    ClientBookings cb
    JOIN ClientSpentMoreThan500 csm ON cb.ID_customer = csm.ID_customer -- Соединяем результаты CTE по ID клиента.
    -- Сортируем по общей сумме, потраченной клиентами, в порядке возрастания.
ORDER BY cb.total_spent ASC;