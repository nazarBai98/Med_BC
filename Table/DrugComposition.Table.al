table 50005 "Drug Composition"
{
    Caption = 'Drug Composition';
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "Component Code"; Code[20])
        {
            Caption = 'Component Code';
            TableRelation = "Drug Component".Code;
        }
        field(2; "Drug Code"; Code[20])
        {
            Caption = 'Drug Code';
            TableRelation = Item."No.";
        }
        field(3; Dose; Decimal)
        {
            Caption = 'Dose';
            MinValue = 0;
            trigger OnValidate()
            var
                DrugComposition: Record "Drug Composition";
            begin
                UpdateRatioPerDrug();
            end;
        }
        field(4; Ratio; Decimal)
        {
            Caption = 'Ratio';
            Editable = false;
        }
        field(5; "Unit Of Measure"; Code[20])
        {
            Caption = 'Unit Of Measure';
            FieldClass = FlowField;
            CalcFormula = lookup("Drug Component"."Unit Of Measure" where(Code = field("Component Code")));
        }
        field(6; "Unit Of Measure Description"; Text[100])
        {
            Caption = 'UOM Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Unit of Measure".Description where(Code = field("Unit Of Measure")));
        }
    }
    
    keys
    {
        key(PK; "Component Code", "Drug Code")
        {
            Clustered = true;
        }
    }

    local procedure UpdateRatioPerDrug()
    var
        DrugCompositionLocal: Record "Drug Composition";
        TotalDrugDose: Decimal;
    begin
        DrugCompositionLocal.SetRange("Drug Code", Rec."Drug Code");
        DrugCompositionLocal.CalcSums(Dose);
        TotalDrugDose := DrugCompositionLocal.Dose;

        if DrugCompositionLocal.FindSet() then
            repeat
                if DrugCompositionLocal.Dose <> 0 then
                    DrugCompositionLocal.Ratio := TotalDrugDose / DrugCompositionLocal.Dose;
            until DrugCompositionLocal.Next() = 0;
    end;
}