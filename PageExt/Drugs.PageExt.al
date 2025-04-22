pageextension 50002 Drugs extends "Item List"
{
    Caption = 'Drugs';
    layout
    {
        modify("Item Category Code")
        {
            Visible = false;
        }
        modify("Assembly BOM")
        {
            Visible = false;
        }
        modify("Cost is Adjusted")
        {
            Visible = false;
        }
        modify("Unit Cost")
        {
            Visible = false;
        }
        modify("Unit Price")
        {
            Visible = false;
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        modify("Item Disc. Group")
        {
            Visible = false;
        }
        modify(ItemAttributesFactBox)
        {
            Visible = false;
        }
        modify("Price/Profit Calculation")
        {
            Visible = false;
        }
    }
    actions
    {
        modify(PricesandDiscounts)
        {
            Visible = false;
        }
        modify(Attributes)
        {
            Visible = false;
        }
        modify(NewFromPicture)
        {
            Visible = false;
        }
        modify(NewFromPicturePromoted)
        {
            Visible = false;
        }
    }
}