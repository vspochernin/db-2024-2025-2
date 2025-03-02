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