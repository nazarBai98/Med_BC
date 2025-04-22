pageextension 50001 "Patient Card" extends "Customer Card"
{
    Caption = 'Patient Card';

    layout
    {
        addafter(Name)
        {
            field("Personal Documet ID"; Rec."Personal Documet ID")
            {
                ApplicationArea = All;
            }
        }
        modify("Balance (LCY)")
        {
            Visible = false;
        }
        modify(BalanceAsVendor)
        {
            Visible = false;
        }
        modify("Balance Due (LCY)")
        {
            Visible = false;
        }
        modify("Credit Limit (LCY)")
        {
            Visible = false;
        }
        modify(Blocked)
        {
            Visible = false;
        }
        modify(TotalSales2)
        {
            Visible = false;
        }
        modify(CustInvDiscAmountLCY)
        {
            Visible = false;
        }
        modify("Home Page")
        {
            Visible = false;
        }
        modify(Invoicing)
        {
            Visible = false;
        }
        modify(Payments)
        {
            Visible = false;
        }
        modify(Shipping)
        {
            Visible = false;
        }
        modify(Statistics)
        {
            Visible = false;
        }
        addafter(General)
        {
            group(Diagnosis)
            {
                field("Main Diagnosis Code"; Rec."Main Illnes Code")
                {
                    ApplicationArea = All;
                }
                field("Diagnosis Description"; Rec."Diagnosis Description")
                {
                    ApplicationArea = All;
                }
            }

            group("Secodary Diagnoses")
            {
                Caption = 'Secodary Diagnoses';
                part("Secodary Diagnoses List Part"; "Secodary Diagnoses")
                {
                    Caption = 'Secodary Diagnoses';
                    ApplicationArea = All;
                    SubPageLink = "Patient Code" = field("No.");
                }
            }
            group(Alergies)
            {
                Caption = 'Alergies';
                part("Alergies List Part"; Alergies)
                {
                    Caption = 'Alergies';
                    ApplicationArea = All;
                    SubPageLink = "Patient Code" = field("No.");
                }
            }
        }
    }

    var
        SecondaryDiagnosis: Page "Secodary Diagnoses";
}