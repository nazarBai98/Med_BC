table 50006 "Test Result"
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1;"Patient ID"; Code[20])
        {
            Caption = 'Patient ID';
            TableRelation = Customer."No.";
        }
        field(2; "Test Code"; Code[20])
        {
            Caption = 'Test Code';
            TableRelation = Test.Code;
        }
        field(3; "Test Result"; Decimal)
        {
            Caption = 'Test Result';
        }
        field(4; "Date Time"; DateTime)
        {
            Caption = 'Date Time';
        }
    }

    keys
    {
        key(PK; "Patient ID", "Test Code", "Date Time")
        {
            Clustered = true;
        }
    }
}