table 50001 "Treatment Setup"
{
    Caption = 'Treatment Setup';
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; Code; Code[1])
        {
            Caption = 'Code';
        }
        field(2; "Diagnosis Code No. Series"; Code[20])
        {
            Caption = 'Diagnosis Code No. Series';
            ToolTip = 'Determins the code of No. Series that will be used while inserting records into Diagnosis Table.';
            TableRelation = "No. Series".Code;
        }
        field(3; "Use No. Series Patt For Diag"; Boolean)
        {
            Caption = 'Use No. Series While Creating Diagnosis';
            ToolTip = 'Determines wheder to use No Series Pattern while Inserting Records in Diagnosis Table.';
        }
    }
    
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
    
    trigger OnInsert()
    begin
        // if not Rec.Get() then begin
        //     Rec.Init();
        //     Rec.Insert();
        // end;
    end;
}