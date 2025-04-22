page 50001 Alergies
{
    Caption = 'Alergies';
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = Alergy;
    
    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(Code;Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Drug Component"; Rec."Drug Component")
                {
                }
                field(Alergen; Rec.Alergen)
                {
                }
            }
        }
    }
}