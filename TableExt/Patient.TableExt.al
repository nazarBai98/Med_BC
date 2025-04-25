tableextension 50000 Patient extends Customer
{
    Caption = 'Patient';

    fields
    {
        field(50000; "Main Illnes Code"; Code[20])
        {
            Caption = 'Main Illnes Code';
            TableRelation = Illnes.Code;

            trigger OnValidate()
            var
                Diagnosis: Record Illnes;
            begin
                if Diagnosis.Get(Rec."Main Illnes Code") then
                    Rec."Diagnosis Description" := Diagnosis.Description
                else
                    Rec."Diagnosis Description" := '';
            end;
        }
        field(50001; "Diagnosis Description"; Text[100])
        {
            Caption = 'Diagnosis Description';
        }
        field(50002; "Recomended Menu"; Text[200])
        {
            Caption = 'Recomended Menu';
        }
        field(50003; "Sex"; Enum Sex)
        {
            Caption = 'Sex';
        }
        field(50004; "Hospitalisation Date"; Date)
        {
            Caption = 'Hospitalisation Date';
        }
        field(50005; "Extraction Date"; Date)
        {
            Caption = 'Extraction Date';
        }
        field(50006; Extracted; Boolean)
        {
            Caption = 'Active';
        }
        field(50007; "Personal Documet ID"; Code[11])
        {
            Caption = 'Personal Document ID';
        }
        field(50008; Anamnesis; Blob)
        {
            Caption = 'Anamnesis';
        }
        field(50009; Age; Integer)
        {
            Caption = 'Anamnesis';
        }
        field(50010; "Body Weight"; Decimal)
        {
            Caption = 'Body Weight';
            MinValue = 0;
            trigger OnValidate()
            begin
                if Hight <> 0 then
                    BMI := Power("Body Weight" / Hight, 2)
            end;
        }
        field(50011; "Hight"; Decimal)
        {
            Caption = 'Hight';
            MinValue = 0;
            trigger OnValidate()
            begin
                if Hight <> 0 then
                    BMI := Power("Body Weight" / Hight, 2)
            end;
        }
        field(50012; BMI; Decimal)
        {
            Caption = 'BMI';
            Editable = false;
        }
    }
}