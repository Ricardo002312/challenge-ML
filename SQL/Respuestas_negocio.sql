
--Lista los usuarios que cumplan años hoy cuyas ventas en enero 2020 sea superior a 1500.

SELECT c.nombre, c.apellido, c.fecha_nacimiento, COUNT(o.id) as cantidad_ventas
FROM Customer c
JOIN OrderP o ON c.id = o.customer_id
WHERE DATE_FORMAT(c.fecha_nacimiento, '%m-%d') = DATE_FORMAT(NOW(), '%m-%d')
    AND o.fecha >= '2020-01-01' AND o.fecha <= '2020-01-31'
GROUP BY c.id
HAVING cantidad_ventas > 1500;

--Por cada mes del 2020, se solicita el top 5 de usuarios que más vendieron($) en la categoría Celulares.


SELECT
    MONTH(o.fecha) AS mes,
    YEAR(o.fecha) AS año,
    c.nombre,
    c.apellido,
    COUNT(o.id) AS cantidad_ventas,
    SUM(o.cantidad) AS cantidad_productos_vendidos,
    SUM(o.monto_total) AS monto_total_transaccionado
FROM Customer c
JOIN (
    SELECT
        o.customer_id,
        o.fecha,
        o.cantidad,
        i.precio * o.cantidad AS monto_total
    FROM OrderP o
    JOIN Item i ON o.item_id = i.id
    JOIN Category cat ON i.category_id = cat.id
    WHERE cat.descripcion = 'Celulares' AND YEAR(o.fecha) = 2020
) o ON c.id = o.customer_id
GROUP BY mes, año, c.id, c.nombre, c.apellido
ORDER BY monto_total_transaccionado DESC
LIMIT 5;

--Poblar una nueva tabla con el precio y estado de los Ítems a fin del día.


CREATE PROCEDURE RegistroDiarioItemStatus()
BEGIN
    CREATE TABLE ItemStatus (
        item_id INT,
        precio DECIMAL(10,2),
        estado VARCHAR(50)
    );

    INSERT INTO ItemStatus (item_id, precio, estado)
    SELECT i.id, i.precio, i.estado
    FROM Item i
    WHERE DATE(i.fecha_baja) = CURDATE();
END;

CALL RegistroDiarioItemStatus();