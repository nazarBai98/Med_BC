page 50005 Illneses
{
    Caption = 'Illneses';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Illnes;
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
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
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                Caption = 'import';
                Image = Import;
                
                trigger OnAction()
                    var
                        Import: Report "ICD11 Import";
                begin
                    Import.RunModal();
                end;
            }
        }
    }
}