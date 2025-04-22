table 50002 Alergy
{
    Caption = 'Alergy';
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; Code; Integer)
        {
            Caption = 'Code';
            AutoIncrement = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Patient Code"; Code[20])
        {
            Caption = 'Patient Code';
            TableRelation = Customer."No.";
        }
        field(4; "Drug Component"; Boolean)
        {
            Caption = 'Drug Component';
            InitValue = true;
        }
        field(5; "Alergen"; Code[20])
        {
            Caption = 'Alergen';
            TableRelation = if ("Drug Component" = const(true)) "Drug Component";
        }
    }
    
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}