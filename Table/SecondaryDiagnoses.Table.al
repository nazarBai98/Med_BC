table 50008 "Secondary Diagnoses"
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "Illnes Code"; Code[20])
        {
            Caption = 'Illnes Code';
        }
        field(2; "Patient Code"; Code[20])
        {
            Caption = 'Patient Code';
            TableRelation = Customer."No.";
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
        }
        field(4; "Date Of Diagnosis"; Date)
        {
            Caption = 'Date Of Diagnosis';
        }
        field(5; "Illnes Description"; Text[100])
        {
            Caption = 'Illnes Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Illnes.Description where(Code = field("Illnes Code")));
        }
    }
    
    keys
    {
        key(PK; "Illnes Code", "Patient Code", "Line No.")
        {
            Clustered = true;
        }
    }
}