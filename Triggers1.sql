use Northwind
select *
	from Customers
	where CustomerID = 'AROUT'
create TRIGGER modificacion_cliente
on Customers
for UPDATE AS
PRINT 'Han actualizado la tabla de Customers'

UPDATE Customers
	set ContactName = 'Maria Walters'
	where CustomerID = 'AROUT'

--Problema#1
create TRIGGER Modificacion_Ordenes
on Orders
for INSERT AS
PRINT 'Han Insertado en la tabla de ORDENES'

insert into Orders(ShipName,ShipCity,ShipCountry)
	values('Kevin Santamaria','Panama','Panama')
select OrderID,ShipName,ShipCity,ShipCountry
	from Orders

--Problema#2
select *
	from Products

create TRIGGER Modificar_Productos
on Products
for update AS
select 'Se a actualizado la tabla productos' as Mensaje
select ProductID,ProductName'Producto_Insertado' from inserted
select ProductID,ProductName'Producto_Borrado' from deleted

update Products
	set ProductName = 'Queso'
	where ProductID = 1

--Problema#3
select * from Products
select * from [Order Details] 
create TRIGGER Modificar_OrderDetails
on [Order Details]
INSTEAD Of insert as
declare @pedidoid int, @productId int, @cantidadPedida int, @cantidadBodega int, @precioProduct money, @discount int

	select @pedidoid = inserted.OrderID,
		   @productId = inserted.ProductID,
		   @cantidadPedida = inserted.Quantity,
		   @precioProduct = inserted.UnitPrice,
		   @discount = inserted.Discount
			from inserted
	select @cantidadBodega = Products.UnitsInStock
			from Products
			where Products.ProductID = @productId
	if(@cantidadPedida<=@cantidadBodega)
		begin
		PRINT 'Se Modifico la tabla ORDERDETAILS'
			insert into [Order Details]
				values(@pedidoid,@productId,@precioProduct,@cantidadPedida,@discount)
		end
		else
		begin
			select 'La cantidad pedida excede la cantidad existente'
		end
		return

select ProductID,UnitsInStock
	from Products
	where ProductID >10 and ProductID<13

--INSERTANDO EN LA TABLA PEDIDO VALORES MAYOR A LA CANTIDAD DE PRODUCTOS EXISTENTE
insert into [Order Details](OrderID,ProductID,UnitPrice,Quantity,Discount)
    values (10999,12,5,100,0)
--INSERTANDO EN LA TABLA PEDIDO VALORES MENOR A LA CANTIDAD DE PRODUCTOS EXISTENTE
insert into [Order Details](OrderID,ProductID,UnitPrice,Quantity,Discount)
    values (10999,11,5,10,0)

--Se procede a listar los registros en la tabla pedidos
select *
	from [Order Details]
	where OrderID = 10999
select ProductID,UnitsInStock
	from Products
	where ProductID = 11

--PROBLEMA#4
ALTER TRIGGER Modificar_OrderDetails
on [Order Details]
INSTEAD Of insert as
declare @pedidoid int, @productId int, @cantidadPedida int, @cantidadBodega int, @precioProduct money, @discount int

	select @pedidoid = inserted.OrderID,
		   @productId = inserted.ProductID,
		   @cantidadPedida = inserted.Quantity,
		   @precioProduct = inserted.UnitPrice,
		   @discount = inserted.Discount
			from inserted
	select @cantidadBodega = Products.UnitsInStock
			from Products
			where Products.ProductID = @productId
	if(@cantidadPedida<=@cantidadBodega)
		begin
		PRINT 'Se Modifico la tabla ORDERDETAILS'
			insert into [Order Details]
				values(@pedidoid,@productId,@precioProduct,@cantidadPedida,@discount)
			update Products
				set UnitsInStock = @cantidadBodega - @cantidadPedida
				where Products.ProductID = @productId
		end
		else
		begin
			select 'La cantidad pedida excede la cantidad existente'
		end
		return

--LISTANDO LOS PRODUCTOS 14
select *
	from [Order Details]
	where OrderID = 10998
select ProductID,UnitsInStock
	from Products
	where ProductID = 14
--INSERTANDO LOS VALORES PARA COMPROPAR EL TRIGGER
insert into [Order Details](OrderID,ProductID,UnitPrice,Quantity,Discount)
    values (10998,14,5,40,0)

--PROBLEMA#5
ALTER TRIGGER Modificar_OrderDetails
on [Order Details]
for insert as
declare @pedidoid int, @productId int, @cantidadPedida int, @cantidadBodega int, @precioProduct money, @discount int
	
	select @pedidoid = inserted.OrderID,
		   @productId = inserted.ProductID,
		   @cantidadPedida = inserted.Quantity,
		   @precioProduct = inserted.UnitPrice,
		   @discount = inserted.Discount
			from inserted
	select @cantidadBodega = Products.UnitsInStock
			from Products
			where Products.ProductID = @productId
	if(@cantidadPedida<=@cantidadBodega)
		begin
		PRINT 'Se Modifico la tabla ORDERDETAILS'
			update Products
				set UnitsInStock = @cantidadBodega - @cantidadPedida
				where Products.ProductID = @productId
		end
		else
		begin
			delete [Order Details]
				where OrderID = @pedidoid and ProductID = @productId
			select 'La cantidad pedida excede la cantidad existente'
		end
		return

--LISTANDO LOS PRODUCTOS 14
select *
	from [Order Details]
	where OrderID = 10998
select ProductID,UnitsInStock
	from Products
	where ProductID = 14
--INSERTANDO LOS VALORES PARA COMPROPAR EL TRIGGER
insert into [Order Details](OrderID,ProductID,UnitPrice,Quantity,Discount)
    values (10999,14,5,5,0)
select *
	from [Order Details]
	where OrderID = 10998
select ProductID,UnitsInStock
	from Products
	where ProductID = 14

--PROBLEMA#6
create TRIGGER Modicacion_Pedidos2
on [Order Details]
INSTEAD Of insert as
Select 'UD. no puede modificar esta tabla' as Mensaje
--Se PROCEDE A INSERTAR EN LA TABLA PEDIDOS
insert into [dbo].[Order Details]
 values (10997,4,8,10,0)
 select *
	from [Order Details]
	where OrderID = 10997


--PROBLEMA#7
alter table [Order Details]
DISABLE TRIGGER Modicacion_Pedidos2

--Se PROCEDE A INSERTAR EN LA TABLA PEDIDOS
insert into [dbo].[Order Details]
 values (10997,4,8,10,0)
 select *
	from [Order Details]
	where OrderID = 10997

