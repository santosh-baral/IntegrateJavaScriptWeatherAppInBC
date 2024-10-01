page 50100 LocationAndWeather
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Location And Weather Details';
    SourceTable = "LocationAndWeather";

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
                    Rec.Longitude := GetJsonTokenValue(address, 'longi');
                    Rec.latitude := GetJsonTokenValue(address, 'lati');
                    Rec.Temperature := GetJsonTokenValue(address, 'temp');
                    Rec.Humidity := GetJsonTokenValue(address, 'humidity');
                    Rec.Wind := GetJsonTokenValue(address, 'speed')


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
                field(longitude; Rec.Longitude)
                {
                    Caption = 'longitude';
                    ApplicationArea = All;

                }
                field(latitude; Rec.latitude)
                {
                    Caption = 'latitude';
                    ApplicationArea = All;

                }
                field(Temperature; Rec.Temperature)
                {
                    ApplicationArea = All;

                }
                field(Humidity; Rec.Humidity)
                {
                    ApplicationArea = All;

                }
                field(Wind; Rec.Wind)
                {
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