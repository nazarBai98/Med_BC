report 50101 "ICD11 Import"
{
    ProcessingOnly = true;
    Caption = 'Import ICD-11 Diagnoses';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    trigger OnPreReport()
    begin
        ReadExcelSheet();
        ImportICD11Rows();
    end;

    local procedure ReadExcelSheet()
    var
        FileMgt: Codeunit "File Management";
        IStream: InStream;
        FromFile: Text;
    begin
        UploadIntoStream(UploadExcelMsg, '', '', FromFile, IStream);
        if FromFile <> '' then begin
            FileName := FileMgt.GetFileName(FromFile);
            SheetName := TempExcelBuffer.SelectSheetsNameStream(IStream);
        end else
            Error(NoFileFoundMsg);
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.OpenBookStream(IStream, SheetName);
        TempExcelBuffer.ReadSheet();
    end;

    local procedure ImportICD11Rows()
    var
        Illness: Record "Illnes";
        RowNo: Integer;
        Code: Text[20];
        Description: Text[100];
    begin
        
        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindLast() then
            MaxRowNo := TempExcelBuffer."Row No.";

        for RowNo := 2 to MaxRowNo do begin
            Code := CopyStr(GetValueAtCell(RowNo, 1, 20), 1, 20);
            Description := GetValueAtCell(RowNo, 2, 100);

            if (Code <> '') and (Description <> '') then begin
                Illness.Init();
                Code := Code.Trim();
                Description := Description.Trim();
                Illness.Code := Code;
                Illness.Description := Description;
                if Illness.Insert(true) then;
            end;
        end;

        Message('ICD-11 import complete.');
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer; MaxLen: Integer): Text
    begin
        TempExcelBuffer.Reset();
        if TempExcelBuffer.Get(RowNo, ColNo) then
            exit(CopyStr(TempExcelBuffer."Cell Value as Text", 1, MaxLen));
        exit('');
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        SheetName: Text[250];
        MaxRowNo: Integer;
        FileName: Text;
        NoFileFoundMsg: Label 'No Excel file found!';
        UploadExcelMsg: Label 'Please Choose the Excel file.';
}
