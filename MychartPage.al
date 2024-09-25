page 50100 MyChartPage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Chart Control Add-in Example';
    SourceTable = "my Address";

    layout
    {
        area(content)
        {
            usercontrol(MyChartControl; MyControlAddIn)
            {
                ApplicationArea = All;
                trigger showcoordinate(address: JsonObject)
                var
                    myInt: Integer;
                begin
                    Rec.lon := GetJsonTokenValue(address, 'longi');
                    Rec.lat := GetJsonTokenValue(address, 'lati');
                    // Rec.Modify();
                end;
            }
            repeater(content1)
            {
                field(PK; Rec."No.")
                {

                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        CurrPage.MyChartControl.getcity(Rec.Address);
                    end;
                }
                field(longitude; Rec.lon)
                {
                    Caption = 'longitude';
                    ApplicationArea = All;

                }
                field(latitude; Rec.lat)
                {
                    Caption = 'latitude';
                    ApplicationArea = All;

                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Get Your Location")
            {
                ApplicationArea = All;
                Image = Map;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.MyChartControl.getlocation();
                end;
            }
        }
    }

    local procedure GetJsonTokenValue(Json: JsonObject; Property: Text): Text;
    var
        Token: JsonToken;
    begin
        if Json.Get(Property, Token) then
            exit(Token.AsValue().AsText());
    end;

    var
        Name: text;
        lon: text;
        lat: text;
}