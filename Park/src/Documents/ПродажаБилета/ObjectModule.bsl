Procedure Posting(Cancel,Mode)
	//{{__REGISTER_RECORD_WIZARD
	//This fragment was built by the wizard.
	//Warning! All manually made changes will be lost next time you use the wizard.

	// register Sales
	RegisterRecords.Sales.Write = True;
	Record = RegisterRecords.Sales.Add();
	Record.Period = Date;
	Record.RecordType = AccumulationRecordType.Receipt;
	Record.Аттракцион = Аттракцион;
	Record.Sum = СуммаДокумента;

	// register АктивныеПосещения
	RegisterRecords.АктивныеПосещения.Write = True;
	Record = RegisterRecords.АктивныеПосещения.Add();
	Record.Period = Date;
	Record.RecordType = AccumulationRecordType.Receipt;
	Record.Основание = Ref;
	Record.Аттракцион = Аттракцион;
	Record.КоличествоПосещений = 1;

	//}}__REGISTER_RECORD_WIZARD
EndProcedure