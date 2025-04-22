table 50004 "Drug Component"
{
    Caption = 'Drug Component';
    DataClassification = CustomerContent;
    LookupPageId = "Drug Component";
    DrillDownPageId = "Drug Component";
    
    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Drug Component';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Unit Of Measure"; Code[20])
        {
            Caption = 'Unit Of Measure';
            TableRelation = "Unit of Measure";
        }
        field(4; "Unit Of Measure Description"; Text[100])
        {
            Caption = 'UOM Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Unit of Measure".Description where(Code = field("Unit Of Measure")));
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