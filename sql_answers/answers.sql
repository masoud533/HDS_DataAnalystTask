-- answer one

select o.order_id as orderID, O.customer_id,round(sum(oi.list_price), 0) as orderPrice
from orders o
JOIN Order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id
ORDER BY  orderPrice DESC;

-- answer two and three

SELECT
    C.customer_id AS costumerID,
    C.first_name AS firstName,
    C.last_name AS lastName,
    C.email AS email,
    C.phone AS phone,
    COUNT(o.order_id) AS countOrders
FROM Orders o
JOIN Customers C on C.customer_id = o.customer_id
WHERE substr(order_date, -4) = '2016'
GROUP BY C.customer_id, C.first_name, C.last_name
ORDER BY countOrders DESC;

-- answer four
SELECT
    C.customer_id AS costumerID,
    C.first_name AS firstName,
    C.last_name AS lastName,
    C.email AS email,
    C.phone AS phone,
    COUNT(o.order_id) AS countOrders
FROM Orders o
JOIN Customers C on C.customer_id = o.customer_id
WHERE substr(order_date, -4) = '2016'
GROUP BY C.customer_id, C.first_name, C.last_name
HAVING COUNT(o.order_id) = 2;

-- answer five

SELECT customer_id,
       first_name,
       last_name,
       product_id,
       product_name,
       list_price
FROM (
    SELECT o.customer_id,
           C.first_name,
           C.last_name,
           oi.product_id,
           p.product_name,
           p.list_price,
           RANK() OVER (PARTITION BY o.customer_id ORDER BY p.list_price DESC) AS rank_order
    FROM orders o
    JOIN Order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    JOIN Customers C on C.customer_id = o.customer_id
)
WHERE rank_order = 2
ORDER BY list_price DESC;
