--3. TRIGGER CONTROL DE PAGO-----------------------------------
create trigger t_control_pago
on visualizaciones
instead of insert
as
	declare @cod_cliente int,
			@p_codigo int,
			@vi_tiempo int,
			@pago money,
			@fecha_p date
			
	select @cod_cliente=inserted.vi_cod_cliente, @p_codigo=inserted.vi_cod_program, @vi_tiempo=inserted.vi_tiempo  
		from inserted
	select @pago=Pago.Pa_monto, @fecha_p=Pago.Pa_Fecha
		from Pago
	if(exists(select pa_monto from pago where Pa_monto in(9.00,14.00,16.00) and @p_codigo=Pa_cod_plan and @cod_cliente=Pa_cod_cliente))
		begin
			insert into visualizaciones
					values(@cod_cliente,@p_codigo,@vi_tiempo)
			select * from programa where Pr_cod_programa=Pr_cod_programa
			select * from inserted
		end
	else
		select 'Su servicio está suspendido por morosidad' as 'MENSAJE'