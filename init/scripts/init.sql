CREATE TABLE clients (
    id SERIAL PRIMARY KEY,
    name character varying(200) NOT NULL,
    phone character varying(30) NOT NULL,
    email character varying(200) NOT NULL
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name character varying(200) NOT NULL,
    price numeric NOT NULL,
    category character varying(100),
    in_stock integer DEFAULT 0
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    client_id integer NOT NULL REFERENCES clients (id),
    date date NOT NULL,
    status character varying(100) NOT NULL CHECK (
        status IN (
            'done',
            'in progress',
            'delivery'
        )
    ),
    address character varying(100) NOT NULL
);

CREATE TABLE positions (
    id SERIAL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    amount integer NOT NULL,
    CONSTRAINT positions_pk PRIMARY KEY (id),
    CONSTRAINT order_fk FOREIGN KEY (order_id) REFERENCES orders (id),
    CONSTRAINT product_fk FOREIGN KEY (product_id) REFERENCES products (id)
);

INSERT INTO
    clients (name, phone, email)
VALUES (
        'Иванов Иван Иванович',
        '89992332244',
        'ivanov.ivan@mail.ru'
    );

INSERT INTO
    clients (name, phone, email)
VALUES (
        'Бук Василий Петрович',
        '89992334444',
        'vasya_buk@mail.ru'
    );

INSERT INTO
    clients (name, phone, email)
VALUES (
        'Петрова Мария Петровна',
        '89992334678',
        'masha_111@mail.ru'
    );

INSERT INTO
    clients (name, phone, email)
VALUES (
        'Давыдова  Екатерина Викторовна',
        '88753334444',
        'davidova@mail.ru'
    );

INSERT INTO
    clients (name, phone, email)
VALUES (
        'Юров Юрий Юрьевич',
        '89992334428',
        'yura@mail.ru'
    );

INSERT INTO
    clients (name, phone, email)
VALUES (
        'Мартынова Нина Павловна',
        '89998763444',
        'np@mail.ru'
    );

INSERT INTO
    clients (name, phone, email)
VALUES (
        'Цой Виктор И',
        '85792334444',
        'tsoi@mail.ru'
    );

INSERT INTO
    clients (name, phone, email)
VALUES (
        'А А А',
        '89992274444',
        'aaa@mail.ru'
    );

INSERT INTO
    products (
        name,
        price,
        category,
        in_stock
    )
VALUES (
        'Велосипед горный',
        10000,
        'спорт',
        10
    );

INSERT INTO
    products (
        name,
        price,
        category,
        in_stock
    )
VALUES (
        'Подставка под чайник',
        546,
        'товары для дома',
        7
    );

INSERT INTO
    products (
        name,
        price,
        category,
        in_stock
    )
VALUES (
        'Крем для рук',
        345,
        'косметика',
        4
    );

INSERT INTO
    products (
        name,
        price,
        category,
        in_stock
    )
VALUES (
        'Кружка для чая',
        156,
        'товары для дома',
        17
    );

INSERT INTO
    products (
        name,
        price,
        category,
        in_stock
    )
VALUES (
        'Перчатки',
        35,
        'товары для дома',
        87
    );

INSERT INTO
    products (
        name,
        price,
        category,
        in_stock
    )
VALUES (
        'Мячик для тенниса',
        27,
        'спорт',
        43
    );

INSERT INTO
    products (
        name,
        price,
        category,
        in_stock
    )
VALUES (
        'Полотенце кухонное',
        300,
        'товары для дома',
        22
    );

INSERT INTO
    products (
        name,
        price,
        category,
        in_stock
    )
VALUES (
        'Гель для душа',
        357,
        'косметика',
        1
    );

INSERT INTO
    products (
        name,
        price,
        category,
        in_stock
    )
VALUES (
        'Стиральный порошок',
        600,
        'товары для дома',
        6
    );

INSERT INTO
    products (
        name,
        price,
        category,
        in_stock
    )
VALUES ('Палатка', 5100, 'спорт', 11);

INSERT INTO
    products (
        name,
        price,
        category,
        in_stock
    )
VALUES ('Спальник', 3500, 'спорт', 9);

INSERT INTO
    products (
        name,
        price,
        category,
        in_stock
    )
VALUES (
        'Крем для лица',
        1400,
        'косметика',
        13
    );

INSERT INTO
    products (
        name,
        price,
        category,
        in_stock
    )
VALUES (
        'Тарелка',
        130,
        'товары для дома',
        24
    );

INSERT INTO
    orders (
        client_id,
        date,
        status,
        address
    )
VALUES (
        3,
        '2019-03-14',
        'done',
        'Санкт-Петербург'
    );

INSERT INTO
    orders (
        client_id,
        date,
        status,
        address
    )
VALUES (
        7,
        '2020-07-18',
        'in progress',
        'Казань'
    );

INSERT INTO
    orders (
        client_id,
        date,
        status,
        address
    )
VALUES (
        7,
        '2020-07-18',
        'in progress',
        'Казань'
    );

INSERT INTO
    orders (
        client_id,
        date,
        status,
        address
    )
VALUES (
        2,
        '2020-08-11',
        'in progress',
        'Москва'
    );

INSERT INTO
    orders (
        client_id,
        date,
        status,
        address
    )
VALUES (
        2,
        '2020-09-02',
        'in progress',
        'Новосибирск'
    );

INSERT INTO
    orders (
        client_id,
        date,
        status,
        address
    )
VALUES (
        7,
        '2020-04-10',
        'done',
        'Новгород'
    );

INSERT INTO
    orders (
        client_id,
        date,
        status,
        address
    )
VALUES (
        3,
        '2019-06-23',
        'done',
        'Мурманск'
    );

INSERT INTO
    orders (
        client_id,
        date,
        status,
        address
    )
VALUES (
        4,
        '2020-07-28',
        'delivery',
        'Самара'
    );

INSERT INTO
    orders (
        client_id,
        date,
        status,
        address
    )
VALUES (
        5,
        '2019-01-24',
        'done',
        'Иркутск'
    );

INSERT INTO
    orders (
        client_id,
        date,
        status,
        address
    )
VALUES (
        7,
        '2020-02-25',
        'done',
        'Санкт-Петербург'
    );

INSERT INTO
    orders (
        client_id,
        date,
        status,
        address
    )
VALUES (
        7,
        '2020-04-16',
        'in progress',
        'Пермь'
    );

INSERT INTO
    orders (
        client_id,
        date,
        status,
        address
    )
VALUES (
        5,
        '2020-05-04',
        'done',
        'Казань'
    );

INSERT INTO
    orders (
        client_id,
        date,
        status,
        address
    )
VALUES (
        5,
        '2020-07-09',
        'delivery',
        'Вологда'
    );

INSERT INTO
    orders (
        client_id,
        date,
        status,
        address
    )
VALUES (
        3,
        '2020-08-11',
        'delivery',
        'Казань'
    );

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (3, 4, 1);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (3, 7, 2);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (3, 13, 3);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (1, 2, 1);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (1, 3, 2);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (1, 4, 1);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (1, 7, 4);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (1, 9, 2);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (1, 12, 1);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (2, 10, 1);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (2, 11, 2);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (4, 1, 1);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (5, 6, 5);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (5, 2, 1);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (5, 13, 3);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (5, 9, 2);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (6, 4, 5);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (6, 8, 3);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (7, 1, 1);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (8, 11, 2);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (8, 5, 3);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (9, 4, 1);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (9, 7, 2);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (9, 3, 3);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (9, 12, 1);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (9, 8, 2);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (10, 2, 3);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (11, 10, 1);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (12, 7, 2);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (12, 1, 4);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (13, 3, 1);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (13, 5, 2);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (13, 6, 3);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (13, 9, 1);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (13, 11, 2);

INSERT INTO
    positions (order_id, product_id, amount)
VALUES (14, 11, 3);