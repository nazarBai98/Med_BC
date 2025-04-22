table 50007 Test
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; Code; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Biological Material"; Enum "Biological Material")
        {
            Caption = 'Biological Material';
        }
        field(4; "Unit Of Measure"; Code[10])
        {
            Caption = 'Unit Of Measure';
            TableRelation = "Unit of Measure";
        }
        field(5; "Minimal Normal Value"; Decimal)
        {
            Caption = 'Minimal Normal Value';
        }
        field(6; "Maximum Normal Value"; Decimal)
        {
            Caption = 'Maximum Normal Value';
        }
        field(7; Sex; Enum Sex)
        {
            Caption = 'Sex';
        }
    }
    
    keys
    {
        key(PK; Code, Sex, "Biological Material")
        {
            Clustered = true;
        }
    }
}