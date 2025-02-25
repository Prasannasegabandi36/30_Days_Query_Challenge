CREATE TABLE orders 
(
	customer_id 	INT,
	dates 			DATE,
	product_id 		INT
);
INSERT INTO orders VALUES
(1, '2024-02-18', 101),
(1, '2024-02-18', 102),
(1, '2024-02-19', 101),
(1, '2024-02-19', 103),
(2, '2024-02-18', 104),
(2, '2024-02-18', 105),
(2, '2024-02-19', 101),
(2, '2024-02-19', 106); 

select dates, cast(product_id as varchar) as products 
from orders
--where customer_id=1 and dates='2024-02-18'

-- now merege columns
union
select dates,string_agg(cast(product_id as varchar), ',') as products
from orders
-- this is for single seggregation where customer_id=1 and dates='2024-02-18'
group by customer_id, dates
-- for order we use
order by dates, products
