table 50100 "My Address"
{
    Caption = 'My Address';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            trigger OnValidate()
            var
                "My Address": Record "My Address";
            begin
                if "No." < xRec."No." then
                    if not "My Address".Get(Rec."No.") then begin
                        GenLedgerSetup.Get();
                        NoSeries.TestManual(GenLedgerSetup."Location Nos");
                        "No. Series" := '';
                    end;
            end;
        }
        field(2; Lon; Text[20])
        {
            Caption = 'Lon';
        }
        field(3; lat; Text[20])
        {
            Caption = 'lat';
        }
        field(4; Address; code[20])
        {

        }
        field(5; "No. series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var

    begin
        if "No." = '' then begin
            GenLedgerSetup.Get();
            GenLedgerSetup.TestField("Location Nos");
            "No. Series" := GenLedgerSetup."Location Nos";
            if NoSeries.AreRelated(GenLedgerSetup."Location Nos", xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeries.GetNextNo("No. Series");
        end;
    end;

    var
        GenLedgerSetup: Record "General Ledger Setup";
        NoSeries: Codeunit "No. Series";
}
