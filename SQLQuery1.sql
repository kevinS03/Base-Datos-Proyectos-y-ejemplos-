use Northwind;
--Primer consulta
CREATE PROCEDURE  pa_Producs_x_Name
  @ProductName varchar(50)
AS
  SELECT  *  FROM Products
     WHERE Productname  LIKE  @ProductName+'%'

--Primera ejecucion
execute pa_Producs_x_Name 'A'

--Segundo problema
CREATE PROCEDURE pa_Producs_Traer_Nombre_Precio
	@ProductID int,
	@ProductName  varchar(50) output,
	@UnitPrice  Money output
AS
       SELECT @ProductName = ProductName,
		@UnitPrice = UnitPrice
       FROM Products
	WHERE ProductID = @ProductID

--segunda ejecucion
declare @Nombre varchar(50), @Precio Money
Execute pa_Producs_Traer_Nombre_Precio
    10, @Nombre OUTPUT, @Precio OUTPUT
SELECT @Nombre AS Nombre,  @Precio AS Precio

--Tecer Problema
CREATE PROCEDURE pa_Product_cantidad
  @ProductName varchar(50)
AS
  DECLARE @Cantidad int
  SELECT @Cantidad = COUNT(*)
     FROM Products 
     WHERE productName  LIKE  @ProductName+'%'
  RETURN @Cantidad

--Tercer ejecucion
DECLARE @R int
EXECUTE @R = pa_Product_cantidad 'A'
SELECT @R AS Cantidad
