table 50100 "LocationAndWeather"
{
    Caption = 'Location And Weather';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            trigger OnValidate()
            var
                "My Address": Record "LocationAndWeather";
            begin
                if "No." < xRec."No." then
                    if not "My Address".Get(Rec."No.") then begin
                        GenLedgerSetup.Get();
                        NoSeries.TestManual(GenLedgerSetup."Location Nos");
                        "No. Series" := '';
                    end;
            end;
        }
        field(2; Longitude; Text[20])
        {
            Caption = 'Longitude';
        }
        field(3; latitude; Text[20])
        {
            Caption = 'latitude';
        }
        field(4; Address; code[20])
        {

        }
        field(6; Temperature; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Humidity; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Wind; Text[20])
        {
            DataClassification = ToBeClassified;
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
