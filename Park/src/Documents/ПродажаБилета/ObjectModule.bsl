Procedure Posting(Cancel,Mode)
	//{{__REGISTER_RECORD_WIZARD
	//This fragment was built by the wizard.
	//Warning! All manually made changes will be lost next time you use the wizard.
	
	СвойствоНоменклатуры = СвойствоНоменклатуры( Номенклатура );
	// register Sales
	RegisterRecords.Sales.Write = True;
	Record = RegisterRecords.Sales.Add();
	Record.Period = Date;
	Record.ВидАттракциона = СвойствоНоменклатуры.ВидАттракциона;
	Record.Sum = СуммаДокумента;

	// register АктивныеПосещения
	RegisterRecords.АктивныеПосещения.Write = True;
	Record = RegisterRecords.АктивныеПосещения.Add();
	Record.Period = Date;
	Record.RecordType = AccumulationRecordType.Receipt;
	Record.Основание = Ref;
	Record.ВидАттракциона = СвойствоНоменклатуры.ВидАттракциона;
	Record.КоличествоПосещений = СвойствоНоменклатуры.КоличествоПосещений;

	//}}__REGISTER_RECORD_WIZARD
EndProcedure


Function СвойствоНоменклатуры( Номенклатура )
	
	//{{QUERY_BUILDER_WITH_RESULT_PROCESSING
	// This fragment was built by the wizard.
	// Warning! All manually made changes will be lost next time you use the wizard.
	
	Query = New Query;
	Query.Text =
		"SELECT
		|	Номенклатура.ВидАттракциона,
		|	Номенклатура.КоличествоПосещений
		|FROM
		|	Catalog.Номенклатура AS Номенклатура
		|WHERE
		|	Номенклатура.Ref = &Ref";
	
	Query.SetParameter( "Ref", Номенклатура );
	QueryResult = Query.Execute();
	
	SelectionDetailRecords = QueryResult.Select();
	Результат = Новый Структура;
	While SelectionDetailRecords.Next() Do
		Результат.Insert("ВидАттракциона", SelectionDetailRecords.ВидАттракциона);
		Результат.Insert("КоличествоПосещений", SelectionDetailRecords.КоличествоПосещений);
	EndDo;
	
	Return Результат;
	
EndFunction