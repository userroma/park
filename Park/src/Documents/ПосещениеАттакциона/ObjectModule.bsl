
#Область ОбработчикиСобытий

	Procedure Posting(Cancel,Mode)
		//{{__REGISTER_RECORD_WIZARD
		//This fragment was built by the wizard.
		//Warning! All manually made changes will be lost next time you use the wizard.
		
		RegisterRecords.АктивныеПосещения.Write = True;
		RegisterRecords.Write();
		Отказ = false;
		Query = New Query;
		Query.Text =
			"SELECT
			|	АктивныеПосещенияBalance.КоличествоПосещенийBalance КАК КоличествоПосещений,
			|	АктивныеПосещенияBalance.ВидАттракциона
			|FROM
			|	AccumulationRegister.АктивныеПосещения.Balance(, Основание = &Основание) AS АктивныеПосещенияBalance";
		

		Query.SetParameter( "Основание", Основание );
		QueryResult = Query.Execute().Select();		
		
		КоличествоПосещений = 0;
		ВидАттракционаАбонемента = Неопределено;
		
		If QueryResult.Next() Then
			ОсталосьПосещений = QueryResult.КоличествоПосещений;
			ВидАттракционаАбонемента = QueryResult.ВидАттракциона;
		EndIf;
		
		If ОсталосьПосещений < 1 Then
			Отказ = true;
			Message = New UserMessage();
			Message.Text = "No places in the ticket";
			Message.SetData(ThisObject);
			Message.Field = "Основание";
			Message.Message();
		EndIf;
		
		ВидАттракционаДокумента = ВидАттракциона( Аттракцион );
		
		If ЗначениеЗаполнено( ВидАттракционаАбонемента ) И ВидАттракционаАбонемента <> ВидАттракционаДокумента Then
			Отказ = true;
			Message = New UserMessage();
			Message.Text = "incorrect ticket";
			Message.SetData(ThisObject);
			Message.Field = "Основание";
			Message.Message();
		EndIf;
		
		Если Отказ Тогда
			Возврат;
		КонецЕсли;
		
		// register АктивныеПосещения
		RegisterRecords.АктивныеПосещения.Write = True;
		Record = RegisterRecords.АктивныеПосещения.Add();
		Record.Period = Date;
		Record.RecordType = AccumulationRecordType.Expense;
		Record.Основание = Основание;
		Record.ВидАттракциона = ВидАттракционаАбонемента;
		Record.КоличествоПосещений = 1;

			
		

	EndProcedure

	Function ВидАттракциона( Аттракцион )
		
		//{{QUERY_BUILDER_WITH_RESULT_PROCESSING
		// This fragment was built by the wizard.
		// Warning! All manually made changes will be lost next time you use the wizard.
		
		Query = New Query;
		Query.Text =
			"SELECT
			|	Аттракционы.ВидАттракциона
			|FROM
			|	Catalog.Аттракционы AS Аттракционы
			|WHERE
			|	Аттракционы.Ref = &Ref";
		
		Query.SetParameter( "Ref", Аттракцион );
		QueryResult = Query.Execute();
		
		SelectionDetailRecords = QueryResult.Select();
		SelectionDetailRecords.Next();

		Return SelectionDetailRecords.ВидАттракциона;
		
	EndFunction


#КонецОбласти


