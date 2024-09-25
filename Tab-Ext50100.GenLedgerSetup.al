tableextension 50100 "Gen. Ledger Setup" extends "General Ledger Setup"
{
    fields
    {
        field(50100; "Location Nos"; Code[20])
        {
            Caption = 'Location Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}
