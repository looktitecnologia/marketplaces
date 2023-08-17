unit classe.shopee;

interface

uses
  System.SysUtils,
  System.Classes ,
  Data.Db,
  System.DateUtils,
  FireDAC.Comp.Client,
  DataSet.Serialize,
  RESTRequest4D,
  REST.Response.Adapter,
  DataSet.Serialize.Config,
  DataSet.Serialize.Utils,
  System.JSON,
  System.Hash, 
  System.Generics.Collections;

type
  TPedidoItem = class
  public
  private
    FID_Canal: integer;
    FDescricao: string;
    FID_Pedido: string;
    FAtacado: string;
    FQuantidade: Double;
    FSku: string;
    FID_Item: string;
    FPreco_Original: Double;
    FPreco_Final: Double;
    public property ID_Canal      : integer      read FID_Canal        write FID_Canal;
    public property ID_Pedido     : string       read FID_Pedido       write FID_Pedido;
    public property ID_Item       : string       read FID_Item         write FID_Item;
    public property Descricao     : string       read FDescricao       write FDescricao;
    public property Sku           : string       read FSku             write FSku;
    public property Quantidade    : Double       read FQuantidade      write FQuantidade;
    public property Preco_Original: Double       read FPreco_Original  write FPreco_Original;
    public property Preco_Final   : Double       read FPreco_Final     write FPreco_Final;
    public property Atacado       : string       read FAtacado         write FAtacado;
end;

type
  TPedido = class
  private
    FID_Canal: integer;
    FID_Pedido: string;
    FNomePessoa: string;
    FLogradouro: string;
    FTipo_Pagamento: string;
    FPrevEntrega: TDate;
    FObservacao: string;
    FBairro: string;
    FValor_Total: double;
    FUF: string;
    FCep: string;
    FCpfCnpj: string;
    FNumero: string;
    FStatus: string;
    FValor_Frete: double;
    FUsername: string;
    FCidade: string;
    FListaItemsPedido: TObjectList<TPedidoItem>;
    procedure SetCep(const Value: string);
    procedure SetNumero(const Value: string);
    function  RemoverCaracteresEspeciais ( Value: String ) : string;
  public
    public property ID_Canal      : integer      read FID_Canal        write FID_Canal;
    public property ID_Pedido     : string       read FID_Pedido       write FID_Pedido;
    public property NomePessoa    : string       read FNomePessoa      write FNomePessoa;
    public property CpfCnpj       : string       read FCpfCnpj         write FCpfCnpj;
    public property Logradouro    : string       read FLogradouro      write FLogradouro;
    public property Numero        : string       read FNumero          write SetNumero;
    public property Bairro        : string       read FBairro          write FBairro;
    public property Cidade        : string       read FCidade          write FCidade;
    public property UF            : string       read FUF              write FUF;
    public property Cep           : string       read FCep             write SetCep;
    public property Username      : string       read FUsername        write FUsername;
    public property Observacao    : string       read FObservacao      write FObservacao;
    public property Tipo_Pagamento: string       read FTipo_Pagamento  write FTipo_Pagamento;
    public property Valor_Frete   : double       read FValor_Frete     write FValor_Frete;
    public property Valor_Total   : double       read FValor_Total     write FValor_Total;
    public property Status        : string       read FStatus          write FStatus;
    public property PrevEntrega   : TDate        read FPrevEntrega     write FPrevEntrega;
    public property ItemsPedido   : TObjectList<TPedidoItem> read FListaItemsPedido write FListaItemsPedido;

    constructor Create;
    destructor Destroy; override;

    procedure AdicionarItemPedido( value: TPedidoItem );
    procedure RemoverItemPedido  ( index: Integer );
end;


type
  TShopee = class
  private
    FMensagem_erro  : string;
    FBaseUrl        : string;
    FDadosRetornados: TFDMemTable;
    FPartnerID: Integer;
    FPartnerKey: string;
    FTimeStamp: Int64;
    FSign: String;
    FShopId: Integer;
    FCodeAutorizacao: string;
    FRefreshToken: string;
    FAccessToken: string;
    FIDCanal: Integer;
    FResponse: string;
    FPedidosParaBuscar: string;
    FPedidos: TObjectList<TPedido>;

    procedure ProcessaJsonToOrders  ( Value : String );
    function  RemoverCaracteresEspeciais ( Value: String ) : string;

  public
    public property BaseUrl         : string      read FBaseUrl          write FBaseUrl;
    public property Mensagem_erro   : string      read FMensagem_erro    write FMensagem_erro;
    public property DadosRetornados : TFDMemTable read FDadosRetornados  write FDadosRetornados;
    public property PartnerID       : Integer     read FPartnerID        write FPartnerID;
    public property PartnerKey      : string      read FPartnerKey       write FPartnerKey;
    public property TimeStamp       : Int64       read FTimeStamp        write FTimeStamp;
    public property Sign            : String      read FSign             write FSign;
    public property ShopId          : Integer     read FShopId           write FShopId;
    public property CodeAutorizacao : string      read FCodeAutorizacao  write FCodeAutorizacao;
    public property RefreshToken    : string      read FRefreshToken     write FRefreshToken;
    public property AccessToken     : string      read FAccessToken      write FAccessToken;
    public property IDCanal         : Integer     read FIDCanal          write FIDCanal;
    public property Response        : string      read FResponse;
    public property Pedidos         : TObjectList<TPedido> read FPedidos;

    // Funcoes
    procedure SetTimeStamp;
    procedure SetSign(Path:string; aToken: Boolean; aShopId: Boolean);
    function  GerarTokenAcesso  : Boolean ;
    function  RenovarTokenAcesso: Boolean ;
    function  BuscarOrdens (DataInicial, DataFinal: TDateTime;
  Status: String; TimeRange: String; RetornaPedidos: Boolean): Boolean;
    function  DTToTimeStamp ( DT: TDateTime ) : Int64;
    function  BuscarUmaOrdem ( OrderId: string ) : Boolean;

    // Contructos
    constructor Create;
    destructor  Destroy; Override;

    // Adicionar
    procedure AdicionarPedido( value: TPedido );

end;

implementation

uses
  FMX.Dialogs, System.Types, System.StrUtils;



procedure TShopee.AdicionarPedido(value: TPedido);
var
  ped: TPedido;
begin
  Ped := TPedido.Create;
  ped := value;
  FPedidos.Add(ped);
end;


function TShopee.BuscarOrdens(DataInicial, DataFinal: TDateTime;
  Status: String; TimeRange: String; RetornaPedidos: Boolean): Boolean;
var
    tsDataInicial : Int64;
    tsDataFinal   : Int64;
    Resp          : IResponse;
    ArrayPedidos  : TJSONArray;
    jsonRetorno   : TJSONObject;
    x : Integer;
begin

    // Converte
    tsDataInicial := DateTimeToUnix( IncHour(DataInicial,3) );
    tsDataFinal   := DateTimeToUnix( IncHour(DataFinal,3) );

    // Limpa Lista
    FPedidosParaBuscar := '';

    // Gero o Sign e o TimeStamp
    SetTimeStamp;
    SetSign ( '/api/v2/order/get_order_list' , True , True );

    // Faz o Request
    resp    :=  TRequest.New.BaseURL( BaseUrl )
                .Resource('/api/v2/order/get_order_list')
                .AddParam('partner_id'  , PartnerId.ToString)
                .AddParam('timestamp'   , TimeStamp.ToString)
                .AddParam('access_token', AccessToken)
                .AddParam('shop_id'     , ShopId.ToString)
                .AddParam('sign'        , Sign)
                .AddParam('time_from'   , tsDataInicial.ToString)
                .AddParam('time_to'     , tsDataFinal.ToString)
                .AddParam('order_status', Status)
                .AddParam('time_range_field', TimeRange)
                .AddParam('page_size'   , '50')
                .AddParam('cursor','1')
                .Timeout(10000)
                .get;

    // Verifica o retorno
    if resp.StatusCode = 0 then
        Mensagem_erro := 'Não foi possível acessar o servidor'
    else if Resp.StatusCode <> 200 then
        Mensagem_erro := resp.Content
    else
      begin
          try

              // Faz a lista com os Pedidos Encontrados
              jsonRetorno := TJSONObject.ParseJSONValue(resp.Content) as TJSONObject;
              jsonRetorno := jsonRetorno.GetValue<TJSONObject>('response');
              ArrayPedidos:= jsonRetorno.GetValue<TJSONArray>('order_list');
              for x := 0 to ArrayPedidos.Size-1 do
                  begin
                      FPedidosParaBuscar  := FPedidosParaBuscar + ArrayPedidos.get(x).GetValue<string>('order_sn');
                      if x <> ArrayPedidos.Size-1 then
                          FPedidosParaBuscar  := FPedidosParaBuscar + ',';
                  end;
              ArrayPedidos.DisposeOf;

              // Verifica se e para retornar os pedidos
              if RetornaPedidos then
                  Result  := BuscarUmaOrdem('TODAS');


          except
              Mensagem_erro := 'Falha ao ler informações';
          end;
      end;

end;


function TShopee.BuscarUmaOrdem(OrderId: string): Boolean;
var
    Resp              : IResponse;
    CamposAdicionais  : string;
begin

    // Limpa os Dados Retornados
    DadosRetornados.FieldDefs.Clear;

    // Gero o Sign e o TimeStamp
    SetTimeStamp;
    SetSign ( '/api/v2/order/get_order_detail' , True , True );

    // Se busca todas
    if ( OrderId = 'TODAS' ) and ( FPedidosParaBuscar='' ) then
        begin
            Mensagem_erro := 'Nenhuma ordem encontrada';
            Result  := False;
            Exit;
        end
    else if ( OrderId = 'TODAS' ) and ( FPedidosParaBuscar <> '' ) then
        OrderId := FPedidosParaBuscar;


    // Campos Adicionais
    CamposAdicionais  := 'order_sn,' +
                         'order_status,' +
                         'buyer_user_id,' +
                         'buyer_username,' +
                         'estimated_shipping_fee,'+
                         'recipient_address,'+
                         'actual_shipping_fee ,'+
                         'goods_to_declare,'+
                         'note,'+
                         'item_list,'+
                         'pay_time,'+
                         'dropshipper,'+
                         'dropshipper_phone,'+
                         'split_up,'+
                         'buyer_cancel_reason,'+
                         'cancel_by,'+
                         'cancel_reason,'+
                         'actual_shipping_fee_confirmed,'+
                         'buyer_cpf_id,'+
                         'fulfillment_flag,'+
                         'pickup_done_time,'+
                         'package_list,'+
                         'shipping_carrier,'+
                         'payment_method,'+
                         'total_amount,'+
                         'buyer_username,'+
                         'invoice_data, '+
                         'checkout_shipping_carrier, '+
                         'reverse_shipping_fee, '+
                         'order_chargeable_weight_gram, '+
                         'edt, '+
                         'prescription_check_status, ' +
			                   'message_to_seller,' +
                         'buyer_cnpj_id,' +
                         'buyer_name,' +
                         'buyer_phone_number,' +
                         'address';

    // Faz o Request
    resp    :=  TRequest.New.BaseURL( BaseUrl )
                .Resource('/api/v2/order/get_order_detail')
                .AddParam('partner_id'    , PartnerId.ToString)
                .AddParam('timestamp'     , TimeStamp.ToString)
                .AddParam('access_token'  , AccessToken)
                .AddParam('shop_id'       , ShopId.ToString)
                .AddParam('sign'          , Sign)
                .AddParam('order_sn_list' , OrderId)
                .AddParam('response_optional_fields', CamposAdicionais)
                .DataSetAdapter(DadosRetornados)
                .Timeout(10000)
                .get;

    // Verifica o retorno
    if resp.StatusCode = 0 then
        Mensagem_erro := 'Não foi possível acessar o servidor'
    else if Resp.StatusCode <> 200 then
        Mensagem_erro := resp.Content
    else
        begin
            Result := true;
            ProcessaJsonToOrders( resp.Content );
        end;

end;


constructor TShopee.Create;
begin

    // Configura o dataSet Serialize
    TDataSetSerializeConfig.GetInstance.CaseNameDefinition := TCaseNameDefinition.cndLower;
    TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator:= '.';

    // Cria os MemTables
    DadosRetornados := TFDMemTable.Create(nil);

    // Pedidos
    FPedidos  := TObjectList<TPedido>.create;

end;


function TShopee.DTToTimeStamp(DT: TDateTime): Int64;
begin
  Result  := Round(( IncHour(Now,3) - 25569) * 86400);
end;


destructor TShopee.Destroy;
begin
  FreeAndNil(FPedidos);
  DadosRetornados.DisposeOf;
  inherited;
end;


function TShopee.GerarTokenAcesso: Boolean;
var
    Resp            : IResponse;
    Json            : TJsonObject;
begin

    // Resultado
    Result  := False;

    // Limpa Mensagem de Erro
    Mensagem_erro := '';

    // Base Url
    if BaseUrl.trim = '' then
        begin
            Mensagem_erro := 'Url base não informada';
            Exit;
        end;

    // Verifica se tem o Cutome rkEy
    if PartnerID = 0 then
        begin
            Mensagem_erro := 'Partner Id não informada';
            Exit;
        end;

    // Verifica se tem o Secret Key
    if PartnerKey.trim = '' then
        begin
            Mensagem_erro := 'Partner Key não informado';
            Exit;
        end;

    // Shop ID
    if ShopId = 0 then
        begin
            Mensagem_erro :=  'Shop ID não informado';
            Exit;
        end;


    // Limpa os Dados Retornados
    DadosRetornados.FieldDefs.Clear;

    // Gero o Sign e o TimeStamp
    SetTimeStamp;
    SetSign ( '/api/v2/auth/token/get' , False , False );

    // Crio o Json
    Json      := TJSONObject.Create;
    Json.AddPair('code'       , CodeAutorizacao );
    Json.AddPair('partner_id' , TJSONNumber.Create( PartnerID ) );
    Json.AddPair('shop_id'    , TJSONNumber.Create( ShopId ) );

    // Faz o Request
    resp    :=  TRequest.New.BaseURL( BaseUrl )
                .Resource('/api/v2/auth/token/get')
                .AddParam('sign'       , Sign)
                .AddParam('partner_id' , PartnerId.ToString)
                .AddParam('timestamp'  , TimeStamp.ToString)
                .AddBody(Json.ToJSON)
                .Accept('application/json')
                .DataSetAdapter(DadosRetornados)
                .Timeout(10000)
                .Post;

    // Verifica o retorno
    if resp.StatusCode = 0 then
        Mensagem_erro := 'Não foi possível acessar o servidor'
    else if Resp.StatusCode <> 200 then
        Mensagem_erro := resp.Content
    else
        begin
            try
                RefreshToken  := DadosRetornados.FieldByName('refresh_token').AsString.trim;
                AccessToken   := DadosRetornados.FieldByName('access_token').AsString.trim;
                Result        := True;
            except on e:Exception do
                Result  := False;
            end;
        end;

    // Destroy o Json
    Json.DisposeOf;

end;


procedure TShopee.ProcessaJsonToOrders(Value: String);
var
    jsonRetorno : TJSONObject;
    ArrayPedidos: TJSONArray;
    ArrayItems  : TJSONArray;
    cPedido     : TPedido;
    cItem       : TPedidoItem;
    x,y         : Integer;
    Atacado     : string;
    aValues     : TStringDynArray;
begin

    // Limpo os Pedidos
    FPedidos.Clear;

    try

        // Faz o Parse
        jsonRetorno := TJSONObject.ParseJSONValue(RemoverCaracteresEspeciais(Value)) as TJSONObject;
        jsonRetorno := jsonRetorno.GetValue<TJSONObject>('response');

        // Pegos os Itens Retornados
        ArrayPedidos:= jsonRetorno.GetValue<TJSONArray>('order_list');

        // Crio os Pedidos
        for x := 0 to ArrayPedidos.Size-1 do
            begin

                // Cria o Pedido
                FPedidos.Add(TPedido.Create);
                cPedido := FPedidos[FPedidos.Count-1];

                // Coloca as informações
                cPedido.ID_Canal   := FIDCanal;
                cPedido.ID_Pedido  := ArrayPedidos.Get(x).GetValue<string>('order_sn');
                cPedido.NomePessoa := ArrayPedidos.Get(x).GetValue<TJSONObject>('recipient_address').GetValue<string>('name');
                cPedido.Cep        := ArrayPedidos.Get(x).GetValue<TJSONObject>('recipient_address').GetValue<string>('zipcode');
                cPedido.Numero     := ArrayPedidos.Get(x).GetValue<TJSONObject>('recipient_address').GetValue<string>('full_address');
                cPedido.CpfCnpj    := ArrayPedidos.Get(x).GetValue<string>('buyer_cpf_id');
                cPedido.Username   := ArrayPedidos.Get(x).GetValue<string>('buyer_username');
                cPedido.Observacao := ArrayPedidos.Get(x).GetValue<string>('message_to_seller') + #13#10 +
                                      ArrayPedidos.Get(x).GetValue<string>('note');
                cPedido.Tipo_Pagamento:= ArrayPedidos.Get(x).GetValue<string>('payment_method');
                cPedido.Valor_Frete := ArrayPedidos.Get(x).GetValue<double>('estimated_shipping_fee');
                cPedido.Valor_Total := ArrayPedidos.Get(x).GetValue<double>('total_amount');
                cPedido.PrevEntrega := UnixToDateTime( ArrayPedidos.Get(x).GetValue<int64>('ship_by_date') );

                // Acerta o Endereço caso não achou no via cep
                if cPedido.Logradouro = '' then
                    begin
                        aValues := SplitString(ArrayPedidos.Get(x).GetValue<TJSONObject>('recipient_address').GetValue<string>('full_address'),',');
                        cPedido.Logradouro  := Trim( AValues[0] );
                        cPedido.Cidade      := ArrayPedidos.Get(x).GetValue<TJSONObject>('recipient_address').GetValue<string>('city');
                        cPedido.Bairro      := ArrayPedidos.Get(x).GetValue<TJSONObject>('recipient_address').GetValue<string>('district');
                    end;


                // Pega o Array dos Itens
                ArrayItems  :=  ArrayPedidos.Get(x).GetValue<TJsonArray>('item_list');

                //Cria o Item do Pediso
                if not Assigned(cItem) then
                  cItem := TPedidoItem.Create;

                // Adiciona os Itens
                for y := 0 to ArrayItems.Size -1 do
                    begin

                      // Cria o item
                      cPedido.ItemsPedido.Add(TPedidoItem.Create);
                      cItem := cPedido.ItemsPedido[cPedido.ItemsPedido.Count-1];

                      // Atacado
                      if ArrayItems.Get(y).GetValue<boolean>('wholesale') then
                        Atacado := '1'
                      else
                        Atacado := '0';

                      // Coloca os Dados do Item
                      cItem.FID_Canal   := IDCanal;
                      cItem.FDescricao  := ArrayItems.Get(y).GetValue<string>('item_name');
                      cItem.FID_Pedido  := cPedido.FID_Pedido;
                      cItem.FAtacado    := Atacado;
                      cItem.FQuantidade := ArrayItems.Get(y).GetValue<double>('model_quantity_purchased');
                      cItem.FSku        := ArrayItems.Get(y).GetValue<string>('item_sku');
                      cItem.FID_Item    := ArrayItems.Get(y).GetValue<Int64>('item_id').ToString;
                      cItem.FPreco_Original :=  ArrayItems.Get(y).GetValue<double>('model_original_price');
                      cItem.FPreco_Final:=  ArrayItems.Get(y).GetValue<double>('model_discounted_price');

                    end;

            end;

    except

        // Limpa Pedido
        FPedidos.Clear;
        Mensagem_erro := 'Falha ao ler dados dos pedidos';

    end;

end;


function TShopee.RemoverCaracteresEspeciais(Value: String): string;
const
  //Lista de caracteres especiais
  xCarEsp: array[1..38] of String = ('á', 'à', 'ã', 'â', 'ä','Á', 'À', 'Ã', 'Â', 'Ä',
                                     'é', 'è','É', 'È','í', 'ì','Í', 'Ì',
                                     'ó', 'ò', 'ö','õ', 'ô','Ó', 'Ò', 'Ö', 'Õ', 'Ô',
                                     'ú', 'ù', 'ü','Ú','Ù', 'Ü','ç','Ç','ñ','Ñ');
  //Lista de caracteres para troca
  xCarTro: array[1..38] of String = ('a', 'a', 'a', 'a', 'a','A', 'A', 'A', 'A', 'A',
                                     'e', 'e','E', 'E','i', 'i','I', 'I',
                                     'o', 'o', 'o','o', 'o','O', 'O', 'O', 'O', 'O',
                                     'u', 'u', 'u','u','u', 'u','c','C','n', 'N');
var
  xTexto : string;
  i : Integer;
begin
   xTexto := Value;
   for i:=1 to 38 do
     xTexto := StringReplace(xTexto, xCarEsp[i], xCarTro[i], [rfreplaceall]);
   Result := xTexto;
end;


function TShopee.RenovarTokenAcesso: Boolean;
var
    Resp            : IResponse;
    Json            : TJsonObject;
begin

    // Resultado
    Result  := False;

    // Limpa Mensagem de Erro
    Mensagem_erro := '';

    // Base Url
    if BaseUrl.trim = '' then
        begin
            Mensagem_erro := 'Url base não informada';
            Exit;
        end;

    // Verifica se tem o Cutome rkEy
    if PartnerID = 0 then
        begin
            Mensagem_erro := 'Partner Id não informada';
            Exit;
        end;

    // Verifica se tem o Secret Key
    if PartnerKey.trim = '' then
        begin
            Mensagem_erro := 'Partner Key não informado';
            Exit;
        end;

    // Shop ID
    if ShopId = 0 then
        begin
            Mensagem_erro :=  'Shop ID não informado';
            Exit;
        end;


    // Limpa os Dados Retornados
    DadosRetornados.FieldDefs.Clear;

    // Gero o Sign e o TimeStamp
    SetTimeStamp;
    SetSign ( '/api/v2/auth/access_token/get' , False , False );

    // Crio o Json
    Json      := TJSONObject.Create;
    Json.AddPair('refresh_token', RefreshToken);
    Json.AddPair('partner_id'   , TJSONNumber.Create( PartnerID ) );
    Json.AddPair('shop_id'      , TJSONNumber.Create(ShopId) );

    // Faz o Request
    resp    :=  TRequest.New.BaseURL( BaseUrl )
                .Resource('/api/v2/auth/access_token/get')
                .AddParam('sign'       , Sign)
                .AddParam('partner_id' , PartnerId.ToString)
                .AddParam('timestamp'  , TimeStamp.ToString)
                .AddBody(Json.ToJSON)
                .Accept('application/json')
                .DataSetAdapter(DadosRetornados)
                .Timeout(10000)
                .Post;

    // Verifica o retorno
    if resp.StatusCode = 0 then
        Mensagem_erro := 'Não foi possível acessar o servidor'
    else if Resp.StatusCode <> 200 then
        Mensagem_erro := resp.Content
    else
        begin

            try
                RefreshToken  := DadosRetornados.FieldByName('refresh_token').AsString.trim;
                AccessToken   := DadosRetornados.FieldByName('access_token').AsString.trim;
                Result  := True;
            except on e:Exception do
                Result  := False;
            end;


        end;

    // Destroy o Json
    Json.DisposeOf;

end;


procedure TShopee.SetSign(Path:string; aToken: Boolean; aShopId: Boolean);
var
    s: String;
begin
    s     := PartnerID.ToString +
             Path +
             TimeStamp.ToString;

    if aToken then
      s := s + AccessToken;

    if aShopId then
      s := s + ShopId.ToString;

    Sign  := THashSHA2.GetHMAC( s , PartnerKey , SHA256);
end;


procedure TShopee.SetTimeStamp;
begin
    FTimeStamp  := Round(( IncHour(Now,3) - 25569) * 86400);
end;



{ TPedido }
procedure TPedido.AdicionarItemPedido(value: TPedidoItem);
var
    Ped: TPedidoItem;
begin
    Ped:= TPedidoItem.Create;
    Ped:= value;
    FListaItemsPedido.Add(Ped);
end;


constructor TPedido.Create;
begin
    FListaItemsPedido := TObjectList<TPedidoItem>.Create;
end;


destructor TPedido.Destroy;
begin
  FreeAndNil(FListaItemsPedido);
  inherited;
end;


function TPedido.RemoverCaracteresEspeciais(Value: String): string;
const
  //Lista de caracteres especiais
  xCarEsp: array[1..38] of String = ('á', 'à', 'ã', 'â', 'ä','Á', 'À', 'Ã', 'Â', 'Ä',
                                     'é', 'è','É', 'È','í', 'ì','Í', 'Ì',
                                     'ó', 'ò', 'ö','õ', 'ô','Ó', 'Ò', 'Ö', 'Õ', 'Ô',
                                     'ú', 'ù', 'ü','Ú','Ù', 'Ü','ç','Ç','ñ','Ñ');
  //Lista de caracteres para troca
  xCarTro: array[1..38] of String = ('a', 'a', 'a', 'a', 'a','A', 'A', 'A', 'A', 'A',
                                     'e', 'e','E', 'E','i', 'i','I', 'I',
                                     'o', 'o', 'o','o', 'o','O', 'O', 'O', 'O', 'O',
                                     'u', 'u', 'u','u','u', 'u','c','C','n', 'N');
var
  xTexto : string;
  i : Integer;
begin
   xTexto := Value;
   for i:=1 to 38 do
     xTexto := StringReplace(xTexto, xCarEsp[i], xCarTro[i], [rfreplaceall]);
   Result := xTexto;
end;


procedure TPedido.RemoverItemPedido(index: Integer);
begin
  FListaItemsPedido.Delete(index);
end;


procedure TPedido.SetCep(const Value: string);
var
  resp    : IResponse;
  jsonObj : TJSONObject;
begin

    // Faz o Request
    resp    :=  TRequest.New.BaseURL( 'https://viacep.com.br/ws/' + Value +'/json' )
                .Timeout(10000)
                .get;

    // Verifica
    if resp.StatusCode = 0 then
        FCep  := Value
    else if Resp.StatusCode <> 200 then
        FCep  := Value
    else
        begin
            try
              jsonObj     := TJSONObject.ParseJSONValue( RemoverCaracteresEspeciais(resp.content) ) as TJSONObject;
              FLogradouro := jsonObj.GetValue<string>('logradouro','');
              FBairro     := jsonObj.GetValue<string>('bairro','');
              FCidade     := jsonObj.GetValue<string>('localidade','');
              FUF         := jsonObj.GetValue<string>('uf','');
              FCep        := Value;
            except
              FCep  := Value;
            end;
        end;
end;


procedure TPedido.SetNumero(const Value: string);
var
  aValues : TStringDynArray;
begin
  aValues := SplitString( Value , ',' );
  FNumero := Trim(aValues[1]);
end;

end.
