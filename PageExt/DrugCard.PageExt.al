pageextension 50003 "Drug Card" extends "Item Card"
{
    Caption = 'Drug Card';

    layout
    {
        modify("Item Category Code")
        {
            Visible = false;
        }
        modify("Prices & Sales")
        {
            Visible = false;
        }
        modify(Replenishment)
        {
            Visible = false;
        }
        modify(Planning)
        {
            Visible = false;
        }
        modify(ItemTracking)
        {
            Visible = false;
        }
        modify(Warehouse)
        {
            Visible = false;
        }

        addafter(Item)
        {
            group("Drug Composition")
            {
                Caption = 'Drug Composition';
                part("Drug Composition List Part"; "Drug Composition")
                {
                    Caption = 'Drug Composition';
                    ApplicationArea = All;
                    SubPageLink = "Drug Code" = field("No.");
                }
            }
        }
    }
}