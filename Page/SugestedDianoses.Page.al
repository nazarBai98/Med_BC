page 50004 "Sugested Diagnoses"
{
    Caption = 'Sugested Diagnoses';
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Secondary Diagnoses";
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
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
                field("Patient Code"; Rec."Patient Code")
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Insert As Primary Diagnosis")
            {
                Caption = 'Insert As Primary Diagnosis';
                Image = Insert;
                trigger OnAction()
                var
                    Patient: Record Customer;
                begin
                    Patient.Get(Rec."Patient Code");
                    Patient."Main Illnes Code" := Rec."Illnes Code";
                    Patient.Modify(true);
                    Rec.Delete(true);
                end;
            }
            action("Insert Selected As Secondary Diagnoses")
            {
                Caption = 'Insert Selected As Secondary Diagnoses';
                Image = Insert;
                trigger OnAction()
                begin
                    SetSelectionFilter(Rec);
                    if Rec.FindSet() then
                        repeat
                            InsertSecondaryDiagnoses(Rec);
                            Rec.Delete(true);
                        until Rec.Next() = 0;
                end;
            }
            action("Insert All As Secondary Diagnoses")
            {
                Caption = 'Insert All As Secondary Diagnoses';
                Image = Insert;
                trigger OnAction()
                begin
                    Rec.SetRange("Patient Code", Rec."Patient Code");
                    if Rec.FindSet() then
                        repeat
                            InsertSecondaryDiagnoses(Rec);
                            Rec.Delete(true);
                        until Rec.Next() = 0;
                end;
            }
        }
    }

    procedure SetRecords(var SuggestedDiagnosis: Record "Secondary Diagnoses" temporary)
    begin
        if SuggestedDiagnosis.FindSet() then begin
            repeat
                Rec.Init();
                Rec.TransferFields(SuggestedDiagnosis);
                Rec.Insert(true);
            until SuggestedDiagnosis.Next() = 0;
        end;
    end;

    local procedure InsertSecondaryDiagnoses(var SecondaryDiagnosesTmp: Record "Secondary Diagnoses")
    var
        SecondaryDiagnoses: Record "Secondary Diagnoses";
    begin
        SecondaryDiagnoses.Init();
        SecondaryDiagnoses.TransferFields(SecondaryDiagnosesTmp);
        SecondaryDiagnoses.Insert(true);
    end;
}