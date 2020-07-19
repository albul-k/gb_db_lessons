﻿/*
3-2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие обоих полей или одно из них. 
Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
При попытке присвоить полям NULL-значение необходимо отменить операцию.
*/

DELIMITER //
DROP TRIGGER IF EXISTS check_products_insert//
CREATE TRIGGER check_products_insert BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF (COALESCE(NULL, NEW.name, NEW.description) IS NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Значение поля name или поля description должно быть отлично от NULL';
	END IF;
END//

DELETE FROM products WHERE products.id IN (11, 12, 13)//
INSERT INTO products VALUES (11, NULL, 'Тестовое описание', 0, 1, NOW(), NOW())//
INSERT INTO products VALUES (12, 'Тестовое название', NULL, 0, 1, NOW(), NOW())//
INSERT INTO products VALUES (13, NULL, NULL, 0, 1, NOW(), NOW())//

SELECT * FROM products//