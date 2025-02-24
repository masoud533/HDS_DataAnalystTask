PRAGMA foreign_keys=off;
BEGIN TRANSACTION;

ALTER TABLE Brands  RENAME TO old_Brands;
CREATE TABLE Brands(
    brand_id INTEGER NOT NULL,
    brand_name TEXT,
    CONSTRAINT brand_id_pk PRIMARY KEY (brand_id)
);

INSERT INTO Brands SELECT * FROM old_Brands;

COMMIT;
BEGIN TRANSACTION;

ALTER TABLE Categories  RENAME TO old_Categories;
CREATE TABLE Categories(
    category_id INTEGER NOT NULL,
    category_name TEXT,
    CONSTRAINT category_id_pk PRIMARY KEY (category_id)
);

INSERT INTO Categories SELECT * FROM old_Categories;

COMMIT;
BEGIN TRANSACTION;

ALTER TABLE Customers  RENAME TO old_Customers;
CREATE TABLE Customers(
    customer_id INTEGER NOT NULL,
    first_name TEXT,
    last_name TEXT,
    phone TEXT,
    email TEXT,
    street TEXT,
    city TEXT,
    state TEXT,
    zip_code INTEGER,
    CONSTRAINT customer_id_pk PRIMARY KEY (customer_id)
);

INSERT INTO Customers SELECT * FROM old_Customers;

COMMIT;
BEGIN TRANSACTION;

ALTER TABLE Order_items  RENAME TO old_Order_items;
CREATE TABLE Order_items(
    order_id INTEGER NOT NULL,
    item_id INTEGER NOT NULL,
    product_id INTEGER,
    quantity INTEGER,
    list_price REAL,
    discount REAL,
    FOREIGN KEY(order_id) REFERENCES Orders(order_id),
    FOREIGN KEY(product_id) REFERENCES Products(product_id)
);

INSERT INTO Order_items SELECT * FROM old_Order_items;

COMMIT;
BEGIN TRANSACTION;


ALTER TABLE Orders  RENAME TO old_Orders;
CREATE TABLE Orders(
    order_id INTEGER NOT NULL,
    customer_id INTEGER,
    order_status INTEGER,
    order_date TEXT,
    required_date TEXT,
    shipped_date TEXT,
    store_id INTEGER,
    staff_id TEXT,
    CONSTRAINT order_id_pk PRIMARY KEY (order_id),
    FOREIGN KEY(customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY(store_id) REFERENCES Stores(store_id),
    FOREIGN KEY(staff_id) REFERENCES Staffs(staff_id)
);

INSERT INTO Orders SELECT * FROM old_Orders;

COMMIT;
BEGIN TRANSACTION;


ALTER TABLE Stores  RENAME TO old_Stores;
CREATE TABLE Stores(
    store_id INTEGER NOT NULL,
    store_name TEXT,
    phone TEXT,
    email TEXT,
    street TEXT,
    city TEXT,
    state TEXT,
    zip_code TEXT,
    CONSTRAINT store_id_pk PRIMARY KEY (store_id)
);

INSERT INTO Stores SELECT * FROM old_Stores;

COMMIT;
BEGIN TRANSACTION;


ALTER TABLE Stocks  RENAME TO old_Stocks;
CREATE TABLE Stocks(
    store_id INTEGER NOT NULL,
    product_id TEXT,
    quantity TEXT,
    FOREIGN KEY(store_id) REFERENCES Stores(store_id),
    FOREIGN KEY(product_id) REFERENCES Products(product_id)
);

INSERT INTO Stocks SELECT * FROM old_Stocks;

COMMIT;
BEGIN TRANSACTION;

ALTER TABLE Staffs  RENAME TO old_Staffs;
CREATE TABLE Staffs(
    staff_id INTEGER NOT NULL,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    phone TEXT,
    active INTEGER,
    store_id INTEGER,
    manager_id INTEGER,
    CONSTRAINT staff_id_pk PRIMARY KEY (staff_id),
    FOREIGN KEY(store_id) REFERENCES Stores(store_id),
    FOREIGN KEY(manager_id) REFERENCES Staffs(staff_id)
);

INSERT INTO Staffs SELECT * FROM old_Staffs;

COMMIT;
BEGIN TRANSACTION;

ALTER TABLE Products  RENAME TO old_Products;
CREATE TABLE Products(
    product_id INTEGER NOT NULL,
    product_name TEXT,
    brand_id INTEGER,
    category_id INTEGER,
    model_year INTEGER,
    list_price REAL,
    CONSTRAINT product_id_pk PRIMARY KEY (product_id),
    FOREIGN KEY(brand_id) REFERENCES Brands(brand_id),
    FOREIGN KEY(category_id) REFERENCES Categories(category_id)
);

INSERT INTO Products SELECT * FROM old_Products;

COMMIT;
BEGIN TRANSACTION;

PRAGMA foreign_keys=on;

DROP TABLE IF EXISTS old_Brands;
DROP TABLE IF EXISTS old_Categories;
DROP TABLE IF EXISTS old_Customers;
DROP TABLE IF EXISTS old_Order_items;
DROP TABLE IF EXISTS old_Orders;
DROP TABLE IF EXISTS old_Products;
DROP TABLE IF EXISTS old_Staffs;
DROP TABLE IF EXISTS old_Stocks;
DROP TABLE IF EXISTS old_Stores;
COMMIT;