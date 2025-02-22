
#Область ОбработчикиСобытий

	Procedure Posting(Cancel,Mode)
		//{{__REGISTER_RECORD_WIZARD
		//This fragment was built by the wizard.
		//Warning! All manually made changes will be lost next time you use the wizard.
	
		// register АктивныеПосещения
		RegisterRecords.АктивныеПосещения.Write = True;
		Record = RegisterRecords.АктивныеПосещения.Add();
		Record.Period = Date;
		Record.RecordType = AccumulationRecordType.Expense;
		Record.Основание = Основание;
		Record.Аттракцион = Аттакцион;
		Record.КоличествоПосещений = 1;
		
		RegisterRecords.Write();
			
		//{{QUERY_BUILDER_WITH_RESULT_PROCESSING
		// This fragment was built by the wizard.
		// Warning! All manually made changes will be lost next time you use the wizard.
		
		Query = New Query;
		Query.Text =
			"SELECT
			|	АктивныеПосещенияBalance.Основание
			|FROM
			|	AccumulationRegister.АктивныеПосещения.Balance(, Основание = &Основание) AS АктивныеПосещенияBalance
			|WHERE
			|	АктивныеПосещенияBalance.КоличествоПосещенийBalance < 0";
		
		Query.SetParameter("Основание", Основание);
		
		QueryResult = Query.Execute();
		
		If Not QueryResult.IsEmpty() Then
			Отказ = true;
			Message = New UserMessage();
			Message.Text = "incorrect ticket";
			Message.SetData(ThisObject);
			Message.Field = "Основание";
			Message.Message();
		EndIf;
		
		SelectionDetailRecords = QueryResult.Select();
		
		While SelectionDetailRecords.Next() Do
			// Insert selection processing SelectionDetailRecords
		EndDo;
		
		//}}QUERY_BUILDER_WITH_RESULT_PROCESSING
		
		
	
		//}}__REGISTER_RECORD_WIZARD
	EndProcedure

#КонецОбласти


