pageextension 50100 "Gen. Ledger Setup" extends "General Ledger Setup"
{
    layout
    {
        addafter(Reporting)
        {
            group("No. series")
            {
                field("Location Nos"; Rec."Location Nos")
                {
                    ApplicationArea = All;
                    Caption = 'Location No. Series';
                }
            }
        }
    }
}
