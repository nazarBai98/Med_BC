page 50002 "Drug Component"
{
    Caption = 'Drug Componenet';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Drug Component";
    
    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field("Code"; Rec."Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }
}