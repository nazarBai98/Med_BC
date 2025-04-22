pageextension 50000 Patient extends "Customer List"
{
    Caption = 'Patient';
    
    layout
    {
        addafter(Name)
        {
            field("Main Diagnosis Code";Rec."Main Illnes Code")
            {
                ApplicationArea = All;
            }
            field("Hospitalisation Date";Rec."Hospitalisation Date")
            {
                ApplicationArea = All;
            }
            field("Diagnosis Description";Rec."Diagnosis Description")
            {
                ApplicationArea = All;
            }
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Balance (LCY)")
        {
            Visible = false;
        }
        modify("Balance Due (LCY)")
        {
            Visible = false;
        }
        modify("Sales (LCY)")
        {
            Visible = false;
        }
        modify("Payments (LCY)")
        {
            Visible = false;
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange(Extracted, false);
    end;
}