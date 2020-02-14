create procedure punto1
@Pais char(10) = 'null'
as
if(@Pais!='null')
begin
	select ContactName 'Nombre_Cliente', Country 'Pais'
		from Customers
		where Country = @Pais
		order by Pais 
end
	else
		select ContactName 'Nombre_Cliente', Country 'Pais'
		from Customers
		order by Pais

exec punto1 'Argentina'

--Punto2
create procedure Punto2
	@Inicial char(1)
as
	declare @Cantidad int
	select @Cantidad = COUNT(ContactName) 
		from Customers
		where ContactName like @Inicial+'%'
return @Cantidad

declare @cant int
exec @cant = Punto2 's'
select @cant 'Cantidad_Cliente'

--Punto 3
create procedure Punto3
 @Cliente char(8)
as
declare @cantidad int
if exists(select CustomerID from Orders where CustomerID=UPPER(@Cliente))
	begin
	select @cantidad = COUNT(OrderID)
		from Orders
		where CustomerID = UPPER(@Cliente)
	end
	else
		set @cantidad = 0
return @cantidad

declare @Cant char(9), @IdCliente char(5), @Nombre_Cliente char(30)
		set @IdCliente = 'VINET'
exec @Cant = Punto3 @IdCliente
select @Nombre_Cliente = ContactName
			from Customers
			where CustomerID = @IdCliente
select @Cant 'Cantida_ordenes',@Nombre_Cliente 'Nombre'

--Punto 5
CREATE VIEW Problema5 
as
select Products.ProductID,Products.ProductName,Products.SupplierID,Products.QuantityPerUnit,Products.UnitPrice,Products.UnitsInStock,Products.UnitsOnOrder,Products.ReorderLevel,Products.Discontinued,Products.CategoryID,Categories.CategoryName,Categories.Description,Categories.Picture
	from Products,Categories
select * from Problema5
	
--Punto 6
create procedure problema6
as
select *
	from Products
	JOIN Categories
	on Products.CategoryID = Categories.CategoryID
	where CategoryName <> 'Beverages'
	order by Categories.CategoryName

exec problema6
select *
from Categories

--Punto 7
create procedure Problema7
as
declare @Cantidad int
Select @Cantidad = COUNT(CategoryID)
	from Categories
	where CategoryName <> 'Condiments'
return @Cantidad

declare @Cant int
exec @Cant = Problema7
Select @Cant 'Cantidad_Registros'

--Punto 8
create Procedure Problema8
as
Select *
	from Products
	JOIN Categories
	ON Products.CategoryID = Categories.CategoryID
	where CategoryName <> 'Seafood'

exec Problema8

--Punto 9
create Procedure Problema9
@CategoriaName char(20)
as
select ProductName,UnitPrice
	from Products
	JOIN Categories
	ON Products.CategoryID = Categories.CategoryID
	where CategoryName <> @CategoriaName + '%'
	order by CategoryName

exec Problema9 'Meat'

--Punto 10
create procedure Prblema10
@NombreCate char(20)
as 
declare @Cantidad int
select @Cantidad = COUNT(ProductName)
	from Products
	JOIN Categories
	ON Products.CategoryID = Categories.CategoryID
	where CategoryName = @NombreCate
	return @Cantidad

declare @Cant int
exec @Cant = Prblema10 'Grains/Cereals'
select @Cant 'Cantidad_de_productos'

--Punto 11
create procedure Problema11
as
select ProductName,UnitPrice
	from Products
	JOIN Categories
	ON Products.CategoryID = Categories.CategoryID
	where CategoryName = 'Dairy Products' or CategoryName = 'Meat/Poultry'

exec Problema11

--Punto 12
create Procedure Problema12
@CategoriaFrutos char(10), @CategoriaPez char(10)
as
select ProductName,UnitPrice,UnitsInStock
	from Products
	JOIN Categories
	ON Products.CategoryID = Categories.CategoryID
	where CategoryName = @CategoriaFrutos or CategoryName = @CategoriaPez

exec Problema12 'Produce','Seafood'

--Punto 13
select * from Categories
create Procedure Problema13
@Categoria char(12)
as
declare @Promedio int
select @Promedio = SUM(UnitPrice)/COUNT(UnitPrice)
	from Products
	JOIN Categories
	ON Products.CategoryID = Categories.CategoryID
	where CategoryName= @Categoria
return @Promedio

declare @pro int
exec @pro = Problema13'Confections'
select @pro 'Promedio'

--Punto 14
create Procedure Problema14
	@amo char(4)
as
select [Order Details].OrderID,COUNT([Order Details].OrderID) contador
	from [Order Details] 
	JOIN Orders 
	ON [Order Details].OrderID = Orders.OrderID
	where YEAR(OrderDate) = '1996'
	GROUP BY [Order Details].OrderID
	HAVING COUNT(*) =(select MAX(contador) max_contador
							from(select
								[Order Details].OrderID,COUNT(*) contador
								from [Order Details] 
								JOIN Orders 
								ON [Order Details].OrderID = Orders.OrderID
								where YEAR(OrderDate) = '1996'
								GROUP BY [Order Details].OrderID
							) T
							);
select [Order Details].OrderID,COUNT([Order Details].OrderID) contador
	from [Order Details] 
	JOIN Orders 
	ON [Order Details].OrderID = Orders.OrderID
	where YEAR(OrderDate) = @amo
	GROUP BY [Order Details].OrderID
	HAVING COUNT(*) =(select MIN(contador) max_contador
							from(select
								[Order Details].OrderID,COUNT(*) contador
								from [Order Details] 
								JOIN Orders 
								ON [Order Details].OrderID = Orders.OrderID
								where YEAR(OrderDate) = @amo
								GROUP BY [Order Details].OrderID
							) T
							);
--Problema#16
create procedure Problem16
	 @frase varchar(MAX)
as
select * 
from Products
where ProductName like '%' + @frase + '%'

exec Problem16 'ueso'

--Problema#17
create procedure Problem17
	@numeroOrden int
as
declare @resultado int
if exists(select DATEDIFF(DAY,OrderDate,RequiredDate)from Orders where OrderID = @numeroOrden)
		begin
			select @resultado = DATEDIFF(DAY,OrderDate,RequiredDate)
			from Orders
			where OrderID = @numeroOrden
		end
		else 
		begin
			set @resultado = null
		end
return @resultado

declare @resul int
exec @resul = Problem17 10248
select @resul'Dias_transcurridos'

--Problema18
create procedure Problem18
	@idcliente char(5)
as
if exists(select *from Customers where CustomerID = @idcliente)
		begin
			select @idcliente'IdCliente','Si existe' as'Mensaje'
		end
		else 
		begin 
			select @idcliente'IdCliente','No existe' as'Mensaje'
		end

exec Problem18 'a'



