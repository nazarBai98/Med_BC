codeunit 50000 "AI Functions Manager"
{
    procedure GetSuggestedDiagnoses(Prompt: Text; PatientCode: Code[20]; var SugestesDiagnosesTmp: Record "Secondary Diagnoses" temporary)
    var
        Client: HttpClient;
        Header: HttpHeaders;
        ContentHeaders: HttpHeaders;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        Content: HttpContent;
        JsonContent: Text;
        ResponseText: Text;
        APIKey: Text;
        TempBlob: Codeunit "Temp Blob";
        OStream: OutStream;
        IStream: InStream;
    begin
        APIKey := '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';

        TempBlob.CreateOutStream(OStream);
        BuildOpenAIRequestBody(Prompt).WriteTo(OStream);

        RequestMessage.SetRequestUri('https://api.openai.com/v1/chat/completions');
        RequestMessage.Method('POST');
        RequestMessage.GetHeaders(Header);
        Header.Add('Authorization', 'Bearer ' + APIKey);

        TempBlob.CreateInStream(IStream);
        Content.GetHeaders(ContentHeaders);
        ContentHeaders.Remove('Content-Type');
        ContentHeaders.Add('Content-Type', 'application/json');
        Content.WriteFrom(IStream);

        RequestMessage.Content(Content);

        if Client.Send(RequestMessage, ResponseMessage) then begin
            ResponseMessage.Content().ReadAs(ResponseText);
            ParseTextAsSugestedDiagnoses(ResponseText, PatientCode, SugestesDiagnosesTmp);
        end else
            Error('Failed to reach OpenAI API');
    end;

    procedure AuthofillPatianteData(Prompt: Text; Patient: Record Customer)
    var
        Client: HttpClient;
        Header: HttpHeaders;
        ContentHeaders: HttpHeaders;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        Content: HttpContent;
        JsonContent: Text;
        ResponseText: Text;
        APIKey: Text;
        TempBlob: Codeunit "Temp Blob";
        OStream: OutStream;
        IStream: InStream;
    begin
        APIKey := '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';

        TempBlob.CreateOutStream(OStream);
        BuildOpenAIRequestBodyForAuthofillingPatientData(Prompt).WriteTo(OStream);

        RequestMessage.SetRequestUri('https://api.openai.com/v1/chat/completions');
        RequestMessage.Method('POST');
        RequestMessage.GetHeaders(Header);
        Header.Add('Authorization', 'Bearer ' + APIKey);

        TempBlob.CreateInStream(IStream);
        Content.GetHeaders(ContentHeaders);
        ContentHeaders.Remove('Content-Type');
        ContentHeaders.Add('Content-Type', 'application/json');
        Content.WriteFrom(IStream);

        RequestMessage.Content(Content);

        if Client.Send(RequestMessage, ResponseMessage) then begin
            ResponseMessage.Content().ReadAs(ResponseText);
            ParseAnamnesisEnhancementResponse(ResponseText, Patient);
        end else
            Error('Failed to reach OpenAI API');
    end;

    procedure ParseAnamnesisEnhancementResponse(ResponseText: Text; var Patient: Record Customer)
    var
        JsonToken: JsonToken;
        JsonObject: JsonObject;
        Choices: JsonArray;
        Choice: JsonObject;
        Message: JsonObject;
        Content: Text;
        AgeTxt, HeightTxt, WeightTxt : Text;
        Menu: Text;
        SexTxt: Text;
        Value: Text;
        KeyValue: List of [Text];
        Pair: Text;
        SepPos: Integer;
    begin
        if not JsonToken.ReadFrom(ResponseText) then
            Error('Failed to parse JSON response.');

        JsonObject := JsonToken.AsObject();
        if not JsonObject.Get('choices', JsonToken) then
            Error('Missing "choices" in response.');

        Choices := JsonToken.AsArray();
        Choices.Get(0, JsonToken);
        Choice := JsonToken.AsObject();

        if not Choice.Get('message', JsonToken) then
            Error('Missing "message" in response.');
        Message := JsonToken.AsObject();

        if not Message.Get('content', JsonToken) then
            Error('Missing "content" in message.');
        Content := JsonToken.AsValue().AsText();

        // Parse content formatted like: name:..., age:..., sex:..., etc.
        KeyValue := Content.Split(';');
        foreach Pair in KeyValue do begin
            SepPos := StrPos(Pair, ':');
            if SepPos > 0 then begin
                case LowerCase(CopyStr(Pair, 1, SepPos - 1).Trim()) of
                    'age':
                        Evaluate(Patient.Age, CopyStr(Pair, SepPos + 1).Trim());
                    'height':
                        Evaluate(Patient.Hight, CopyStr(Pair, SepPos + 1).Trim());
                    'weight':
                        Evaluate(Patient."Body Weight", CopyStr(Pair, SepPos + 1).Trim());
                    'sex':
                        begin
                            SexTxt := LowerCase(CopyStr(Pair, SepPos + 1).Trim());
                            case SexTxt of
                                'male':
                                    Patient.Sex := Patient.Sex::Male;
                                'female':
                                    Patient.Sex := Patient.Sex::Female;
                                else
                                    Patient.Sex := Patient.Sex::Other;
                            end;
                        end;
                    'menu':
                        Patient."Recomended Menu" := CopyStr(Pair, SepPos + 1).Trim();
                end;
            end;
        end;

        Patient."Extraction Date" := Today;
        Patient.Extracted := true;

        // Optionally update BMI again:
        if Patient.Hight <> 0 then
            Patient.BMI := Power(Patient."Body Weight" / Patient.Hight, 2);
    end;

    local procedure BuildOpenAIRequestBodyForAuthofillingPatientData(Prompt: Text): JsonObject
    var
        JsonBody: JsonObject;
        MessagesArray: JsonArray;
        SystemMessage: JsonObject;
        UserMessage: JsonObject;
    begin
        SystemMessage.Add('role', 'system');
        SystemMessage.Add('content',
        'You are a medical assistant. Extract the following from the patient''s anamnesis: ' +
        'Name Age (in years) Sex (Male/Female/Other) Height (in cm) Weight (in kg) ' +
        'Generate a recommended 3-meal healthy menu for the next day based on their profile and symptoms. ' +
        'Return the data in this format: ' +
        'name:<Full Name>; age:<Age>; sex:<Sex>; height:<Height>; weight:<Weight>; ' +
        'menu:<Breakfast, lunch, and dinner recommendation in natural language (1 paragraph)>'
    );

        UserMessage.Add('role', 'user');
        UserMessage.Add('content', Prompt);

        MessagesArray.Add(SystemMessage);
        MessagesArray.Add(UserMessage);

        JsonBody.Add('model', 'gpt-4-turbo');
        JsonBody.Add('messages', MessagesArray);
        JsonBody.Add('temperature', 0.7);

        exit(JsonBody);
    end;

    local procedure BuildOpenAIRequestBody(Prompt: Text): JsonObject
    var
        JsonBody: JsonObject;
        MessagesArray: JsonArray;
        SystemMessage: JsonObject;
        UserMessage: JsonObject;
    begin
        SystemMessage.Add('role', 'system');
        SystemMessage.Add('content',
            'You are a medical assistant. Based on the patient''s description, return a list of the most likely diagnoses using ICD-11 codes only. ' +
            'Each diagnosis must be in the format: <ICD-11 Code>: <Short description under 100 characters>. ' +
            'Do not include hyphens, bullets, dashes, colons before the code, or any other special symbols. ' +
            'Only return raw code:description pairs separated by commas, like this: MG40.0: Cardiogenic shock, BA00: Hypertension.'
        );

        UserMessage.Add('role', 'user');
        UserMessage.Add('content', Prompt);

        MessagesArray.Add(SystemMessage);
        MessagesArray.Add(UserMessage);

        JsonBody.Add('model', 'gpt-4-turbo');
        JsonBody.Add('messages', MessagesArray);
        JsonBody.Add('temperature', 0.7);

        exit(JsonBody);
    end;


    local procedure ParseTextAsSugestedDiagnoses(Text: Text; PatientCode: Code[20]; var SugestesDiagnosesTmp: Record "Secondary Diagnoses" temporary)
    var
        Illnes: Record Illnes;
        JsonToken: JsonToken;
        JsonObject: JsonObject;
        Choices: JsonArray;
        Choice: JsonObject;
        Message: JsonObject;
        Entries: List of [Text];
        Entry: Text;
        Description: Text;
        Code: Text;
        SeparatorPos: Integer;
    begin
        if not JsonToken.ReadFrom(Text) then
            Error('Failed to parse JSON response');

        JsonObject := JsonToken.AsObject();
        if not JsonObject.Get('choices', JsonToken) then
            Error('Missing "choices" in response');

        Choices := JsonToken.AsArray();

        Choices.Get(0, JsonToken);
        Choice := JsonToken.AsObject();
        Choice.Get('message', JsonToken);
        Message := JsonToken.AsObject();
        Message.Get('content', JsonToken);
        Entries := JsonToken.AsValue().AsText().Split(',');

        foreach Entry in Entries do begin
            Entry := Entry.Trim();
            SeparatorPos := StrPos(Entry, ':');

            if SeparatorPos > 0 then begin
                Code := CopyStr(Entry, 1, SeparatorPos - 1).Trim();
                Description := CopyStr(Entry, SeparatorPos + 1).Trim();

                if not Illnes.Get(Code) then begin
                    Illnes.Init();
                    Illnes.Code := Code;
                    Illnes.Description := Description;
                    Illnes.Insert(true);
                end;
                SugestesDiagnosesTmp.Init();
                SugestesDiagnosesTmp."Patient Code" := PatientCode;
                SugestesDiagnosesTmp."Illnes Code" := Code;
                SugestesDiagnosesTmp."Illnes Description" := Description;
                SugestesDiagnosesTmp.Insert();
            end;
        end;
    end;

}