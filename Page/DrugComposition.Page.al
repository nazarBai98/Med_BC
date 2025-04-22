page 50003 "Drug Composition"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Drug Composition";
    
    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Component Code"; Rec."Component Code")
                {
                }
                field(Dose; Rec.Dose)
                {
                }
                field("Unit Of Measure"; Rec."Unit Of Measure")
                {
                    Editable = false;
                }
                field("Unit Of Measure Description"; Rec."Unit Of Measure Description")
                {
                    Editable = false;
                }
                field(Ratio; Rec.Ratio)
                {
                    Editable = false;
                }
            }
        }
    }
}