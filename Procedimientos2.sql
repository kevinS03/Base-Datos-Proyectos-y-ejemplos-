--practica1
create procedure MONTOPAGAR
	@Valor money output,
	@ITBMS money output
as
set @ITBMS = @ITBMS * @Valor
set @Valor = @Valor + @ITBMS
return

declare @impuesto money, @total money
		set @impuesto = 0.07
		set @total = 0
execute MONTOPAGAR @total output ,@impuesto output
select @impuesto'7%',@total'Total'

--practica2
create procedure CANTITERRI
	@NameTerri char(30)
as
declare @Cantidad int
select @Cantidad = COUNT(TerritoryDescription)
	from Territories
	where TerritoryDescription = @NameTerri  
	group by TerritoryDescription
return @Cantidad

declare @cant int,@NombreTE char(30)
	set @NombreTE = 'Orlando'
exec @cant = CANTITERRI @NombreTE
select @NombreTE'NombreTerritorio',@cant'Valor'

--Problema#3
create procedure NotasLetras
	@nota int
as

if(@nota>60 and @nota<101)
		begin
			select str(@nota)'Mensaje'
		end
		else
		begin
			select 'No se encuentra en el rando' as 'Mensaje'
		end
exec NotasLetras 67

--Problema#4
create procedure primaAntiguedad
	@contrato date
as
if((select DATEDIFF(year,@contrato,GETDATE()))>=3)
		begin
			select 'Derecho a prima' as 'PRIMA'
		end
	else
		begin
			select 'Sin derecho a prima' as 'PRIMA'
		end
execute primaAntiguedad '2013/02/3'

--Practica#5
create procedure ajusteSalario
as
select DATEDIFF(year,HireDate,GETDATE())
	from Employees



