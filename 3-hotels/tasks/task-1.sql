WITH
    CustomerBookings AS (
        -- Агрегируем бронирования клиентов для получения данных о количестве бронирований, уникальных отелях и средней продолжительности пребывания.
        SELECT
            c.ID_customer,
            c.name,
            c.email,
            c.phone,
            COUNT(b.ID_booking) AS total_bookings,
            COUNT(DISTINCT r.ID_hotel) AS unique_hotels,
            STRING_AGG(DISTINCT h.name, ', ') AS hotel_names,
            AVG(
                (
                    b.check_out_date - b.check_in_date
                )
            )::numeric AS average_stay_length
        FROM
            Customer c
            JOIN Booking b ON c.ID_customer = b.ID_customer
            JOIN Room r ON b.ID_room = r.ID_room
            JOIN Hotel h ON r.ID_hotel = h.ID_hotel
        GROUP BY
            c.ID_customer,
            c.name,
            c.email,
            c.phone
        HAVING
            COUNT(DISTINCT r.ID_hotel) > 1 -- Условие для отбора клиентов с бронированием в более чем одном отеле.
    )
SELECT
    name,
    email,
    phone,
    total_bookings,
    hotel_names AS hotels,
    ROUND(average_stay_length, 4) AS average_stay_length
FROM CustomerBookings
WHERE
    total_bookings > 2 -- Отбираем клиентов с более чем двумя бронированиями.
    -- Сортируем по количеству бронирований в порядке убывания.
ORDER BY total_bookings DESC;