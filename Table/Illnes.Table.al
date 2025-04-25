table 50000 Illnes
{
    Caption = 'Customer';
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
    }
    
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
    
    // trigger OnInsert()
    // var
    //     TreatmentSetup: Record "Treatment Setup";
    //     NoSeries: Codeunit "No. Series";
    // begin
    //     TreatmentSetup.Get();

    //     if TreatmentSetup."Use No. Series Patt For Diag" then
    //         if TreatmentSetup."Diagnosis Code No. Series" <> '' then begin
    //             Rec.Code := NoSeries.GetNextNo(TreatmentSetup."Diagnosis Code No. Series");
    //         end
    //         else
    //             Error(NoSeriesErr);
    // end;
    
    // var
    //     NoSeriesErr: Label 'Autofilling of Primary key is ON bud No Series is not selected.';
}