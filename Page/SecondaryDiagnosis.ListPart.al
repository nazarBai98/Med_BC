page 50000 "Secodary Diagnoses"
{
    Caption = 'Secodary Diagnoses';
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Secondary Diagnoses";
    
    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Line No."; Rec."Line No.")
                {
                }
                field("Illnes Code"; Rec."Illnes Code")
                {
                }
                field("Illnes Description"; Rec."Illnes Description")
                {
                }
                field("Date Of Diagnosis"; Rec."Date Of Diagnosis")
                {
                }
            }
        }
    }
}