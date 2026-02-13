SELECT *
FROM cafe_sales_dirty;

CREATE TABLE cafe_sales_clean (LIKE cafe_sales_dirty);

INSERT INTO cafe_sales_clean
SELECT * FROM cafe_sales_dirty;

SELECT *
FROM cafe_sales_clean;

SELECT item
FROM cafe_sales_clean
GROUP BY item;

UPDATE cafe_sales_clean
SET item =
	CASE WHEN item 
	IN ('Smoothie', 'Sandwich', 'Cookie', 'Cake', 'Salad', 'Tea', 'Coffee', 'Juice')
	THEN item
	ELSE NULL
END;

SELECT item
FROM cafe_sales_clean;

UPDATE cafe_sales_clean
SET quantity =
	CASE WHEN quantity !~ '^[0-9]+$'
	THEN NULL
	ELSE quantity
END;

ALTER TABLE cafe_sales_clean
ALTER COLUMN quantity TYPE int USING quantity::integer;

SELECT *
FROM cafe_sales_clean;

UPDATE cafe_sales_clean 
SET price_per_unit = NULL
WHERE price_per_unit IN ('UNKNOWN', 'ERROR');

ALTER TABLE cafe_sales_clean
ALTER COLUMN price_per_unit TYPE decimal(10,2) USING price_per_unit::numeric;

SELECT price_per_unit
FROM cafe_sales_clean;


UPDATE cafe_sales_clean 
SET total_spent = NULL
WHERE total_spent IN ('UNKNOWN', 'ERROR');

ALTER TABLE cafe_sales_clean
ALTER COLUMN total_spent TYPE decimal(10,2) USING total_spent::numeric;

SELECT payment_method
FROM cafe_sales_clean
GROUP BY payment_method;

UPDATE cafe_sales_clean 
SET payment_method = NULL
WHERE payment_method IN ('UNKNOWN', 'ERROR');

SELECT payment_method
FROM cafe_sales_clean
GROUP BY payment_method;





