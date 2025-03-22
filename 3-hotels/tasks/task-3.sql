WITH
    HotelCategory AS (
        -- Определяем категории каждого отеля на основе средней цены на номер.
        SELECT
            h.ID_hotel,
            h.name AS hotel_name,
            CASE
                WHEN AVG(r.price) < 175 THEN 'Дешевый'
                WHEN AVG(r.price) BETWEEN 175 AND 300  THEN 'Средний'
                WHEN AVG(r.price) > 300 THEN 'Дорогой'
            END AS hotel_category
        FROM Hotel h
            JOIN Room r ON h.ID_hotel = r.ID_hotel
        GROUP BY
            h.ID_hotel,
            h.name
    ),
    CustomerPreferences AS (
        -- Определяем предпочитаемый типа отеля для каждого клиента.
        SELECT
            c.ID_customer,
            c.name,
            COALESCE(
                MAX(
                    CASE
                        WHEN hc.hotel_category = 'Дорогой' THEN 'Дорогой'
                    END
                ),
                MAX(
                    CASE
                        WHEN hc.hotel_category = 'Средний' THEN 'Средний'
                    END
                ),
                'Дешевый'
            ) AS preferred_hotel_type,
            STRING_AGG(DISTINCT hc.hotel_name, ', ') AS visited_hotels -- Список уникальных отелей.
        FROM
            Booking b
            JOIN Customer c ON b.ID_customer = c.ID_customer
            JOIN Room r ON b.ID_room = r.ID_room
            JOIN HotelCategory hc ON r.ID_hotel = hc.ID_hotel
        GROUP BY
            c.ID_customer,
            c.name
    )
    -- Вывод результата.
SELECT cp.ID_customer, cp.name, cp.preferred_hotel_type, cp.visited_hotels
FROM CustomerPreferences cp
ORDER BY
    CASE cp.preferred_hotel_type
        WHEN 'Дешевый' THEN 1
        WHEN 'Средний' THEN 2
        WHEN 'Дорогой' THEN 3
    END,
    cp.id_customer;
