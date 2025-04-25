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
            group(Anamnesis)
            {
                Caption = 'Anamnesis';
                field(Recipe; Anamnesis)
                {
                    Caption = 'Anamnesis';
                    MultiLine = true;
                    ExtendedDatatype = RichContent;
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        SaveAnamnesis();
                    end;
                }
            }
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

    actions
    {
        addfirst(Action82)
        {
            group("AI functions")
            {
                Caption = 'AI Functions';
                action("Sugest Diagnoses")
                {
                    Caption = 'Sugest Diagnoses from anamnesis.';
                    Image = Suggest;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        AIFunc: Codeunit "AI Functions Manager";
                        SugestesDiagnosesTmp: Record "Secondary Diagnoses" temporary;
                        SugestedDiagnosesPage: Page "Sugested Diagnoses";
                    begin
                        if Anamnesis <> '' then begin
                            AIFunc.GetSuggestedDiagnoses(Anamnesis, Rec."No.", SugestesDiagnosesTmp);
                            if not SugestesDiagnosesTmp.IsEmpty() then begin
                                SugestedDiagnosesPage.SetRecords(SugestesDiagnosesTmp);
                                Commit();
                                SugestedDiagnosesPage.RunModal();
                                CurrPage.Update(true);
                            end;
                        end;
                    end;
                }
                action("Authofill Patient Data")
                {
                    Caption = 'Authofill Patient Data';
                    Image = AuthorizeCreditCard;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        AIFunc: Codeunit "AI Functions Manager";
                        SugestesDiagnosesTmp: Record "Secondary Diagnoses" temporary;
                        SugestedDiagnosesPage: Page "Sugested Diagnoses";
                    begin
                        if Anamnesis <> '' then begin
                            AIFunc.GetSuggestedDiagnoses(Anamnesis, Rec."No.", SugestesDiagnosesTmp);
                            if not SugestesDiagnosesTmp.IsEmpty() then begin
                                SugestedDiagnosesPage.SetRecords(SugestesDiagnosesTmp);
                                Commit();
                                SugestedDiagnosesPage.RunModal();
                                CurrPage.Update(true);
                            end;
                        end;
                    end;
                }
            }
        }
        modify("&Customer")
        {
            Visible = false;
        }
    }

    trigger OnOpenPage()
    begin
        PopulateRichTextField()
    end;

    local procedure PopulateRichTextField()
    var
        InStream: InStream;
    begin
        Rec.CalcFields(Anamnesis);
        Rec.Anamnesis.CreateInStream(InStream, TextEncoding::UTF8);
        InStream.Read(Anamnesis);
    end;

    internal procedure SaveAnamnesis()
    var
        RecipeOutStream: OutStream;
    begin
        Rec.Anamnesis.CreateOutStream(RecipeOutStream, TextEncoding::UTF8);
        RecipeOutStream.Write(Anamnesis);
    end;

    var
        SecondaryDiagnosis: Page "Secodary Diagnoses";
        Anamnesis: Text;
}