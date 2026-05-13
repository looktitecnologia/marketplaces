unit classe.bling;

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
  TContatoBling = class
    private
      Frg: string;
      Ffantasia: string;
      Fbairro: string;
      Femail: string;
      Fuf: string;
      Fcep: string;
      FId: Int64;
      Fnumero: string;
      Fie: string;
      Fmunicipio: string;
      Ftipo_pessoa: string;
      Fcomplemento: string;
      Fnome: string;
      Fendereco: string;
      Ftelefone: string;
      Fcelular: string;
      FnumeroDocumento: string;
    public
      public property id: Int64 read FId write FId;
      public property nome: string read Fnome write Fnome;
      public property fantasia: string read Ffantasia write Ffantasia;
      public property tipo_pessoa: string read Ftipo_pessoa write Ftipo_pessoa;
      public property numeroDocumento: string read FnumeroDocumento write FnumeroDocumento;
      public property telefone: string read Ftelefone write Ftelefone;
      public property celular: string read Fcelular write Fcelular;
      public property ie: string read Fie write Fie;
      public property rg: string read Frg write Frg;
      public property email: string read Femail write Femail;

      // Dados endereco
      public property cep: string read Fcep write Fcep;
      public property endereco: string read Fendereco write Fendereco;
      public property numero: string read Fnumero write Fnumero;
      public property bairro: string read Fbairro write Fbairro;
      public property municipio: string read Fmunicipio write Fmunicipio;
      public property uf: string read Fuf write Fuf;
      public property complemento: string read Fcomplemento write Fcomplemento;

  end;

type
  TPedidoCabecalho = class
    private
      FId: Int64;
    public
      public property id: Int64 read FId write FId;
  end;

type
  TPedidoParcelaBling = class
    private
      FValor: Double;
      FformaPagamento: Int64;
      FdataVencimento: TDate;
      FId: Int64;
      Fobservacoes: string;
    public
      public property id: Int64 read FId write FId;
      public property dataVencimento: TDate read FdataVencimento write FdataVencimento;
      public property valor: Double read FValor write FValor;
      public property observacoes: string read Fobservacoes write Fobservacoes;
      public property formaPagamento: Int64 read FformaPagamento write FformaPagamento;
  end;

type
  TPedidoItemBling = class
    private
      Fdesconto: Double;
      Fvalor: Double;
      Fdescricao: string;
      Fcodigo: string;
      FId: Int64;
      FdescricaoDetalhada: string;
      Funidade: string;
      Fquantidade: Integer;
      FId_item: Int64;
    public
      public property id_item: Int64 read FId_item write FId_item;
      public property id: Int64 read FId write FId;
      public property codigo: string read Fcodigo write Fcodigo;
      public property unidade: string read Funidade write Funidade;
      public property quantidade: Integer read Fquantidade write Fquantidade;
      public property desconto: Double read Fdesconto write Fdesconto;
      public property valor: Double read Fvalor write Fvalor;
      public property descricao: string read Fdescricao write Fdescricao;
      public property descricaoDetalhada: string read FdescricaoDetalhada write FdescricaoDetalhada;
  end;

type
  TPedidoTransporteBling = class
  private
    FBairro: string;
    FCep: string;
    FComplemento: string;
    FEndereco: string;
    FFrete: Double;
    FFretePorConta: Integer;
    FId_Contato: Int64;
    FMunicipio: string;
    FNome: string;
    FNomePais: string;
    FNumero: string;
    FPesoBruto: Double;
    FPrazoEntrega: Integer;
    FQuantidadeVolumes: Integer;
    FUf: string;
  public
    property bairro: string read FBairro write FBairro;
    property cep: string read FCep write FCep;
    property complemento: string read FComplemento write FComplemento;
    property endereco: string read FEndereco write FEndereco;
    property frete: Double read FFrete write FFrete;
    property freteporconta: Integer read FFretePorConta write FFretePorConta;
    property id_contato: Int64 read FId_Contato write FId_Contato;
    property municipio: string read FMunicipio write FMunicipio;
    property nome: string read FNome write FNome;
    property nomepais: string read FNomePais write FNomePais;
    property numero: string read FNumero write FNumero;
    property pesobruto: Double read FPesoBruto write FPesoBruto;
    property prazoentrega: Integer read FPrazoEntrega write FPrazoEntrega;
    property quantidadevolumes: Integer read FQuantidadeVolumes write FQuantidadeVolumes;
    property uf: string read FUf write FUf;
  end;

type
  TPedidoBling = class
    private
      FnumeroLoja: string;
      FId: Int64;
      FData: TDate;
      FdataSaida: TDate;
      FdataPrevista: TDate;
      FtotalProdutos: Double;
      Ftotal: Double;
      Fid_contato: int64;
      Fnome: string;
      Ftipo_pessoa: string;
      FnumeroDocumento: string;
      Ftelefone: string;
      Fcelular: string;
      Ffantasia: string;
      Frg: string;
      Fie: string;
      Femail: string;
      Fbairro: string;
      Fuf: string;
      Fcep: string;
      Fnumero: string;
      Fmunicipio: string;
      Fcomplemento: string;
      Fendereco: string;
      Fsituacao: Integer;
      FobservacoesInternas: string;
      FoutrasDespesas: Double;
      Fobservacoes: string;
      Fdesconto: Double;
      Fcategoria: Integer;
      FItens: TObjectList<TPedidoItemBling>;
      FParcelas: TObjectList<TPedidoParcelaBling>;
      FTransporte: TPedidoTransporteBling;
      FId_loja: string;
      Fnumero_ped: integer;
      Fnota: Int64;

    public

      // Dados do pedido
      public property id: Int64 read FId write FId;
      public property id_loja: string read FId_loja write FId_loja;
      public property numeroLoja: string read FnumeroLoja write FnumeroLoja;
      public property numero_ped: integer read Fnumero_ped write Fnumero_ped;
      public property data: TDate read FData write FData;
      public property dataSaida: TDate read FdataSaida write FdataSaida;
      public property dataPrevista: TDate read FdataPrevista write FdataPrevista;
      public property totalProdutos: Double read FtotalProdutos write FtotalProdutos;
      public property total: Double read Ftotal write Ftotal;
      public property situacao: Integer read Fsituacao write Fsituacao;
      public property outrasDespesas: Double read FoutrasDespesas write FoutrasDespesas;
      public property observacoes: string read Fobservacoes write Fobservacoes;
      public property observacoesInternas: string read FobservacoesInternas write FobservacoesInternas;
      public property desconto: Double read Fdesconto write Fdesconto;
      public property categoria: Integer read Fcategoria write Fcategoria;
      public property nota: Int64 read Fnota write Fnota;
      public property Itens: TObjectList<TPedidoItemBling> read FItens write FItens;
      public property Parcelas: TObjectList<TPedidoParcelaBling> read FParcelas write FParcelas;
      public property Transporte: TPedidoTransporteBling read FTransporte write FTransporte;

      // Dados do Cliente
      public property id_contato: int64 read Fid_contato write Fid_contato;
      public property nome: string read Fnome write Fnome;
      public property fantasia: string read Ffantasia write Ffantasia;
      public property tipo_pessoa: string read Ftipo_pessoa write Ftipo_pessoa;
      public property numeroDocumento: string read FnumeroDocumento write FnumeroDocumento;
      public property telefone: string read Ftelefone write Ftelefone;
      public property celular: string read Fcelular write Fcelular;
      public property ie: string read Fie write Fie;
      public property rg: string read Frg write Frg;
      public property email: string read Femail write Femail;

      // Dados endereco
      public property cep: string read Fcep write Fcep;
      public property endereco: string read Fendereco write Fendereco;
      public property numero: string read Fnumero write Fnumero;
      public property bairro: string read Fbairro write Fbairro;
      public property municipio: string read Fmunicipio write Fmunicipio;
      public property uf: string read Fuf write Fuf;
      public property complemento: string read Fcomplemento write Fcomplemento;

      // procedure
      procedure AddItem ( I: TPedidoItemBling );
      procedure DelItem ( Index: Integer );
      procedure AddParcela ( P: TPedidoParcelaBling );
      procedure DelParcela ( Index: Integer );

      // Contructos
      constructor Create;
      destructor  Destroy; Override;

  end;

type
  TSituacoesBling = class
    private
      FId: integer;
      FNome: string;
    public
      public property id: integer read FId write FId;
      public property nome: string read FNome write FNome;
  end;

type
  TModulosBling = class
    private
      FDescricao: string;
      FId: Integer;
      FNome: string;
      Fsituacoes: TObjectList<TSituacoesBling>;
    public
      public property id: Integer read FId write FId;
      public property nome: string read FNome write FNome;
      public property descricao: string read FDescricao write FDescricao;
      public property situacoes: TObjectList<TSituacoesBling> read Fsituacoes write Fsituacoes;

      procedure AddSituacao( S: TSituacoesBling );
      procedure DelSituacao( Index: Integer );

      // Contructos
      constructor Create;
      destructor  Destroy; Override;
  end;

type
  TFormasPagamento = class
    private
      Fdescricao: string;
      Ftipopagamento: Integer;
      FId: Int64;
    public
      public property id: Int64 read FId write FId;
      public property descricao: string read Fdescricao write Fdescricao;
      public property tipopagamento: Integer read Ftipopagamento write Ftipopagamento;
  end;

type
  TDeposito = class
    private
      Fdescricao: string;
      Fid: Int64;
      Fpadrao: Boolean;
      FSituacao: Integer;
    public
      public property id: Int64 read Fid write Fid;
      public property descricao: string read Fdescricao write Fdescricao;
      public property situacao: Integer read FSituacao write FSituacao;
      public property padrao: Boolean read Fpadrao write Fpadrao;
  end;

type
  TNota = class
    private
      Fdata_emissao: TDate;
      Fid: Int64;
      Fserie: string;
      Fnota: Int64;
      Fdata_operacao: TDate;
      Fchave: string;
    public
      public property id: Int64 read Fid write Fid;
      public property serie: string read Fserie write Fserie;
      public property nota: Int64 read Fnota write Fnota;
      public property data_emissao: TDate read Fdata_emissao write Fdata_emissao;
      public property data_operacao: TDate read Fdata_operacao write Fdata_operacao;
      public property chave: string read Fchave write Fchave;
  end;

type
  TBling = class
    private
      FErro: string;
      FRefreshToken: string;
      FCode: string;
      FAccessToken: string;
      FClientId: string;
      FSecretKey: string;
      FCodigoState: string;
      FValidadeToken: TDateTime;
      FModulos: TObjectList<TModulosBling>;
      FPedido: TPedidoBling;
      FFormasPagamento: TObjectList<TFormasPagamento>;
      FDepositos: TObjectList<TDeposito>;
      FNota: TNota;

      function ValidarToken: Boolean;
      function CStringDate(Dt:string) : TDate;

    public

      const
        url = 'https://www.bling.com.br/Api/v3';

      public property ClientId      : string read FClientId write FClientId;
      public property SecretKey     : string read FSecretKey write FSecretKey;
      public property CodigoState   : string read FCodigoState write FCodigoState;
      public property Code          : string read FCode write FCode;
      public property AccessToken   : string read FAccessToken write FAccessToken;
      public property RefreshToken  : string read FRefreshToken write FRefreshToken;
      public property Erro          : string read FErro;
      public property ValidadeToken : TDateTime read FValidadeToken write FValidadeToken;
      public property TokenValido   : Boolean read ValidarToken;
      public property Modulos       : TObjectList<TModulosBling> read FModulos write FModulos;
      public property Pedido        : TPedidoBling read FPedido write FPedido;
      public property FormasPagamento: TObjectList<TFormasPagamento> read FFormasPagamento write FFormasPagamento;
      public property Depositos     : TObjectList<TDeposito> read FDepositos write FDepositos;
      public property Nota          : TNota read FNota write FNota;

      // Procedures e FFuncoes
      function  GerarCodigoStateAleatorio( Tamanho: Integer = 16 ): string;
      function  GerarUrlCode       : string;
      function  GerarAccessToken   : Boolean;
      function  RenovarAccessToken : Boolean;

      // Formas Pagamento
      procedure AddFormasPagamento( P: TFormasPagamento );
      procedure DelFormasPagamento( Index: Integer );
      function  ListarFormasPagamento: Boolean;

      // Modulos
      procedure AddModulo( M: TModulosBling );
      procedure DelModulo( Index: Integer );
      function  ListarModulo : Boolean;

      // Situacao
      function  ListarSituacao ( M: TModulosBling ): Boolean;

      // Pedidos
      function  ListaPedidos (dtInicial, dtFinal: TDate; id_situacao: Integer): TObjectList<TPedidoCabecalho>;
      procedure BuscaPedido  ( id_pedido: Int64 );
      function  AtualizaSituacaoPedido ( id_pedido: Int64 ; id_situacao: integer ) : Boolean;


      // Depositos
      function  ListarDepositos : Boolean;


      // Produtos
      function BuscaIDProduto( sku : string ) : Int64;


      // Nota Fiscal
      function  BuscaNota ( id_nota: Int64 ): TNota;


      // Contatos ( cliente )
      function BuscaContato (idContato: Int64): TContatoBling;


      // Remover Caracteres Especiais
      function RemoverCaracteresEspeciais(Value:String) : string;

      // Enviar Estoque
      function EnviarEstoque(id_produto: Int64; id_estoque: Int64; quantidade: Integer): Boolean;

      // Contructos
      constructor Create;
      destructor  Destroy; Override;

  end;

implementation

{ TBling }

procedure TBling.AddFormasPagamento(P: TFormasPagamento);
begin
   FFormasPagamento.Add(P);
end;


procedure TBling.AddModulo(M: TModulosBling);
begin

    // Adiciona
    FModulos.Add(M);

end;


function TBling.AtualizaSituacaoPedido(id_pedido: Int64;
  id_situacao: integer): Boolean;
var
    Resp      : IResponse;

    // Json
    jsonObj   : TJSONObject;
    jsonData  : TJSONObject;
    jsonItens : TJSONArray;
    jsonErr   : TJSONObject;
    jsonParc  : TJSONArray;

    // Item e Parcela
    Item      : TPedidoItemBling;
    Parc      : TPedidoParcelaBling;
    Contato   : TContatoBling;

    x         : Integer;
begin

    FErro    := '';
    Result   := False;

    // Verifica se o Token nao é Valido
    if TokenValido = false then
        begin

            // tenta renovr token
            if RenovarAccessToken = false then
                begin

                    // Tenta gerar o primeiro Token
                    if GerarAccessToken = false then
                        exit;

                end;

        end;


    // Verifica se tem AcessToken
    Resp    :=   TRequest.New.BaseURL( url )
                .Resource('/pedidos/vendas/' + id_pedido.ToString + '/situacoes/' + id_situacao.ToString )
                .TokenBearer(AccessToken)
                .ContentType('application/json')
                .Timeout(10000)
                .Patch;

    // Json
    jsonObj := TJSONObject.Create;
    jsonObj := TJSONObject.ParseJSONValue(Resp.Content) as TJSONObject;

    // Verifica se teve alguma retorno
    if Resp.StatusCode = 204 then
        begin

            // Resultado
            result  := True;

        end
    else
        begin
            jsonErr := jsonObj.GetValue<TJSONObject>('error',nil);
            if jsonErr = nil then
              FErro := 'Falha ao pegar erro'
            else
              FErro := jsonErr.GetValue<string>('description','Falha ao pegar erro');
            Pedido  := nil;
        end;

end;


function TBling.BuscaContato(idContato: Int64): TContatoBling;
var
    Resp    : IResponse;
    jsonObj : TJSONObject;
    jsonData: TJSONObject;
    jsonEnd : TJSONObject;
    jsonErr : TJSONObject;
    x       : Integer;
begin

    Result   := nil;
    FErro    := '';

    // Verifica se o Token nao é Valido
    if TokenValido = false then
        begin

            // tenta renovr token
            if RenovarAccessToken = false then
                begin

                    // Tenta gerar o primeiro Token
                    if GerarAccessToken = false then
                        exit;

                end;

        end;


    // Verifica se tem AcessToken
    Resp    :=   TRequest.New.BaseURL( url )
                .Resource('/contatos/' + idContato.ToString)
                .TokenBearer(AccessToken)
                .ContentType('application/json')
                .Timeout(10000)
                .Get;

    // Json
    jsonObj := TJSONObject.Create;
    jsonObj := TJSONObject.ParseJSONValue(Resp.Content) as TJSONObject;

    // Verifica se teve alguma retorno
    if Resp.StatusCode = 200 then
        begin

            // Converte o Array
            jsonData := jsonObj.GetValue<TJSONObject>('data',nil);

            // Verifica se tem informacoes
            if jsonData <> nil then
                begin

                    // Dados Principais
                    Result            := TContatoBling.Create;
                    Result.id         := jsonData.GetValue<int64>('id',0);
                    Result.nome       := jsonData.GetValue<string>('nome','');
                    Result.fantasia   := jsonData.GetValue<string>('fantasia','');
                    Result.tipo_pessoa:= jsonData.GetValue<string>('tipo','');
                    Result.numeroDocumento:= jsonData.GetValue<string>('numeroDocumento','');
                    Result.telefone   := jsonData.GetValue<string>('telefone','');
                    Result.celular    := jsonData.GetValue<string>('celular','');
                    Result.ie         := jsonData.GetValue<string>('ie','');
                    Result.rg         := jsonData.GetValue<string>('rg','');
                    Result.email      := jsonData.GetValue<string>('email','');

                    // Dados Enderecos
                    jsonEnd           := jsonData.GetValue<TJSONObject>('endereco',nil).GetValue<TJSONObject>('geral',nil);
                    Result.cep        := jsonEnd.GetValue<string>('cep','');
                    Result.endereco   := jsonEnd.GetValue<string>('endereco','');
                    Result.numero     := jsonEnd.GetValue<string>('numero','');
                    Result.bairro     := jsonEnd.GetValue<string>('bairro','');
                    Result.municipio  := jsonEnd.GetValue<string>('municipio','');
                    Result.uf         := jsonEnd.GetValue<string>('uf','');
                    Result.complemento:= jsonEnd.GetValue<string>('complemento','');

                end;
            

        end
    else
        begin
            jsonErr := jsonObj.GetValue<TJSONObject>('error',nil);
            if jsonErr = nil then
              FErro := 'Falha ao pegar erro'
            else
              FErro := jsonErr.GetValue<string>('description','Falha ao pegar erro');
        end;

end;


function TBling.BuscaIDProduto(sku: string): Int64;
var
    Resp    : IResponse;
    jsonObj : TJSONObject;
    jsonData: TJSONArray;
    jsonEnd : TJSONObject;
    jsonErr : TJSONObject;
    x       : Integer;
begin

    Result   := 0;
    FErro    := '';

    // Verifica se o Token nao é Valido
    if TokenValido = false then
        begin

            // tenta renovr token
            if RenovarAccessToken = false then
                begin

                    // Tenta gerar o primeiro Token
                    if GerarAccessToken = false then
                        exit;

                end;

        end;


    // Verifica se tem AcessToken
    Resp    :=   TRequest.New.BaseURL( url )
                .Resource('/produtos')
                .AddParam('limite','10')
                .AddParam('codigo',sku)
                .TokenBearer(AccessToken)
                .ContentType('application/json')
                .Timeout(10000)
                .Get;

    // Json
    jsonObj := TJSONObject.Create;
    jsonObj := TJSONObject.ParseJSONValue(Resp.Content) as TJSONObject;

    // Verifica se teve alguma retorno
    if Resp.StatusCode = 200 then
        begin

            // Converte o Array
            jsonData := jsonObj.GetValue<TJSONArray>('data',nil);

            // Verifica se tem informacoes
            if jsonData <> nil then
                begin
                    Result  := TJsonObject(jsonData.Items[0]).GetValue<Int64>('id',0);
                end;


        end
    else
        begin
            jsonErr := jsonObj.GetValue<TJSONObject>('error',nil);
            if jsonErr = nil then
              FErro := 'Falha ao pegar erro'
            else
              FErro := jsonErr.GetValue<string>('description','Falha ao pegar erro');
        end;

end;

function TBling.BuscaNota(id_nota: Int64): TNota;
var
    Resp      : IResponse;

    // Json
    jsonObj   : TJSONObject;
    jsonData  : TJSONObject;
    jsonErr   : TJSONObject;

begin

    FErro    := '';

    // Verifica se o Token nao é Valido
    if TokenValido = false then
        begin

            // tenta renovr token
            if RenovarAccessToken = false then
                begin

                    // Tenta gerar o primeiro Token
                    if GerarAccessToken = false then
                        exit;

                end;

        end;


    // Verifica se tem AcessToken
    Resp    :=   TRequest.New.BaseURL( url )
                .Resource('/nfe/' + id_nota.ToString)
                .TokenBearer(AccessToken)
                .ContentType('application/json')
                .Timeout(10000)
                .Get;

    // Json
    jsonObj := TJSONObject.Create;
    jsonObj := TJSONObject.ParseJSONValue(Resp.Content) as TJSONObject;

    // Verifica se teve alguma retorno
    if Resp.StatusCode = 200 then
        begin

            // Converte o Array
            jsonData := jsonObj.GetValue<TJSONObject>('data',nil);

            // Se trouxe alguma respota
            if jsonData <> nil then
                begin

                    // Resul
                    Result  := TNota.Create;
                    Result.id           :=  jsonData.GetValue<int64>('id',0);
                    Result.serie        :=  jsonData.GetValue<string>('serie','');
                    Result.nota         :=  jsonData.GetValue<int64>('numero',0);
                    Result.data_emissao :=  CStringDate( jsonData.GetValue<string>('dataEmissao' ,'1900-01-01') );
                    Result.data_operacao:=  CStringDate( jsonData.GetValue<string>('dataOperacao','1900-01-01') );
                    Result.chave        :=  jsonData.GetValue<string>('chaveAcesso','');

                end
            else
                Result  := nil;

        end
    else
        begin
            jsonErr := jsonObj.GetValue<TJSONObject>('error',nil);
            if jsonErr = nil then
              FErro := 'Falha ao pegar erro'
            else
              FErro := jsonErr.GetValue<string>('description','Falha ao pegar erro');
            Result  := nil;
        end;

end;


procedure TBling.BuscaPedido(id_pedido: Int64);
var
    Resp      : IResponse;

    // Json
    jsonObj   : TJSONObject;
    jsonData  : TJSONObject;
    jsonItens : TJSONArray;
    jsonErr   : TJSONObject;
    jsonParc  : TJSONArray;
    jsonTrasp : TJSONObject;
    jsonLoja  : TJSONObject;
    jsonNota  : TJSONObject;

    // Item e Parcela
    Item      : TPedidoItemBling;
    Parc      : TPedidoParcelaBling;
    Contato   : TContatoBling;

    x         : Integer;
begin

    FErro    := '';

    // Verifica se o Token nao é Valido
    if TokenValido = false then
        begin

            // tenta renovr token
            if RenovarAccessToken = false then
                begin

                    // Tenta gerar o primeiro Token
                    if GerarAccessToken = false then
                        exit;

                end;

        end;


    // Verifica se tem AcessToken
    Resp    :=   TRequest.New.BaseURL( url )
                .Resource('/pedidos/vendas/' + id_pedido.ToString)
                .TokenBearer(AccessToken)
                .ContentType('application/json')
                .Timeout(10000)
                .Get;

    // Json
    jsonObj := TJSONObject.Create;
    jsonObj := TJSONObject.ParseJSONValue(Resp.Content) as TJSONObject;

    // Verifica se teve alguma retorno
    if Resp.StatusCode = 200 then
        begin

            // Converte o Array
            jsonData := jsonObj.GetValue<TJSONObject>('data',nil);

            // Se trouxe alguma respota
            if jsonData <> nil then
                begin

                    // Cria o pedido
                    if not Assigned(pedido) then
                        Pedido  := TPedidoBling.Create;

                    // Preenche os pedido
                    Pedido.id             := jsonData.GetValue<int64>('id',0);
                    Pedido.numeroLoja     := jsonData.GetValue<string>('numeroLoja','');
                    Pedido.data           := CStringDate( jsonData.GetValue<string>('data'          ,'1900-01-01') );
                    Pedido.dataSaida      := CStringDate( jsonData.GetValue<string>('dataSaida'     ,'1900-01-01') );
                    Pedido.dataPrevista   := CStringDate( jsonData.GetValue<string>('dataPrevista'  ,'1900-01-01') );
                    Pedido.totalProdutos  := jsonData.GetValue<Double>('totalProdutos' , 0 );
                    Pedido.total          := jsonData.GetValue<Double>('total'         , 0 );
                    Pedido.situacao       := jsonData.GetValue<TJSONObject>('situacao',nil).GetValue<int64>('id',0);
                    Pedido.outrasDespesas := jsonData.GetValue<Double>('outrasDespesas', 0 );
                    Pedido.observacoes    := RemoverCaracteresEspeciais( jsonData.GetValue<string>('observacoes'   , '') );
                    Pedido.observacoesInternas:= RemoverCaracteresEspeciais ( jsonData.GetValue<string>('observacoesInternas','') );
                    Pedido.desconto       := jsonData.GetValue<TJSONObject>('desconto',nil).GetValue<Double>('valor',0);
                    Pedido.categoria      := jsonData.GetValue<TJSONObject>('categoria',nil).GetValue<Integer>('id',0);
                    Pedido.numero_ped     := jsonData.GetValue<int64>('numero',0);

                    // Preenche o Id Loja ( origem do pedido )
                    jsonLoja  := jsonData.GetValue<TJSONObject>('loja',nil);
                    if jsonLoja <> nil then
                        Pedido.id_loja  := jsonLoja.GetValue<string>('id','');


                    // Json Nota
                    jsonNota  := jsonData.GetValue<TJSONObject>('notaFiscal',nil);
                    if jsonNota <> nil then
                        Pedido.nota     := jsonNota.GetValue<int64>('id',0)
                    else
                        Pedido.nota     := 0;


                    // Se tem nota Busca a Nota
                    if Pedido.nota > 0 then
                        begin

                            // Busca a nota
                            Nota  := TNota.Create;
                            Nota  := BuscaNota(Pedido.nota);

                        end;


                    // Adiciona Itens
                    jsonItens   :=  jsonData.GetValue<TJsonArray>('itens',nil);
                    Pedido.Itens.Clear;
                    for x := 0 to jsonItens.Count -1 do
                        begin

                            // Cria Item
                            Item  := TPedidoItemBling.Create;
                            Item.id_item      := jsonItens[x].GetValue<int64>('id',0);
                            Item.id           := jsonItens[x].GetValue<TJSONObject>('produto',nil).GetValue<Int64>('id',0);
                            Item.codigo       := jsonItens[x].GetValue<string>('codigo','');
                            Item.unidade      := jsonItens[x].GetValue<string>('unidade','');
                            Item.quantidade   := jsonItens[x].GetValue<integer>('quantidade',1);
                            Item.desconto     := jsonItens[x].GetValue<Double>('desconto',0);
                            Item.valor        := jsonItens[x].GetValue<Double>('valor',0);
                            Item.descricao    := RemoverCaracteresEspeciais(  jsonItens[x].GetValue<string>('descricao','') );
                            Item.descricaoDetalhada:= RemoverCaracteresEspeciais( jsonItens[x].GetValue<string>('descricaoDetalhada','') );

                            // Adicioa
                            Pedido.AddItem(Item);

                        end;

                    // Adicioan Parcelas
                    jsonParc  := jsonData.GetValue<TJSONArray>('parcelas',nil);
                    Pedido.Parcelas.Clear;
                    for x := 0 to jsonParc.Count -1 do
                        begin

                            // Cria Item
                            Parc                := TPedidoParcelaBling.Create;
                            Parc.id             := jsonParc[x].GetValue<int64>('id',0);
                            Parc.dataVencimento := CStringDate( jsonParc[x].GetValue<string>('dataVencimento','1900-01-01') );
                            Parc.valor          := jsonParc[x].GetValue<Double>('valor',0);
                            Parc.observacoes    := RemoverCaracteresEspeciais( jsonParc[x].GetValue<string>('observacoes','') );
                            Parc.formaPagamento := jsonParc[x].GetValue<TJSONObject>('formaPagamento',nil).GetValue<Int64>('id',0);

                            // Adiciona
                            Pedido.AddParcela(Parc);

                        end;

                    // Dados do contato
                    Pedido.id_contato   := jsonData.GetValue<TJSONObject>('contato',nil).GetValue<Int64>('id',0);

                    // Busca o Contato
                    Contato := BuscaContato(pedido.id_contato);
                    if Contato <> nil then
                        begin

                            // Adiciona os dados
                            Pedido.nome       := RemoverCaracteresEspeciais( Contato.nome );
                            Pedido.fantasia   := RemoverCaracteresEspeciais( Contato.fantasia );
                            Pedido.tipo_pessoa:= Contato.tipo_pessoa;
                            Pedido.numeroDocumento:= Contato.numeroDocumento;
                            Pedido.telefone   := Contato.telefone;
                            Pedido.celular    := Contato.celular;
                            Pedido.ie         := Contato.ie;
                            Pedido.rg         := Contato.rg;
                            Pedido.email      := Contato.email;
                            Pedido.cep        := Contato.cep;
                            Pedido.endereco   := RemoverCaracteresEspeciais( Contato.endereco );
                            Pedido.numero     := Contato.numero;
                            Pedido.bairro     := RemoverCaracteresEspeciais( Contato.bairro );
                            Pedido.municipio  := RemoverCaracteresEspeciais( Contato.municipio );
                            Pedido.uf         := Contato.uf;
                            Pedido.complemento:= RemoverCaracteresEspeciais( Contato.complemento );

                        end;

                    // Transporte
                    jsonTrasp :=  jsonData.GetValue<TJSONObject>('transporte',nil);
                    if jsonTrasp <> nil then
                        begin
                            Pedido.Transporte.freteporconta     := jsonTrasp.GetValue<integer>('fretePorConta',0);
                            Pedido.Transporte.frete             := jsonTrasp.GetValue<Double>('frete',0);
                            Pedido.Transporte.quantidadevolumes := jsonTrasp.GetValue<integer>('quantidadeVolumes',0);
                            Pedido.Transporte.pesobruto         := jsonTrasp.GetValue<Double>('pesoBruto',0);
                            pedido.Transporte.prazoentrega      := jsonTrasp.GetValue<integer>('prazoEntrega',0);
                            pedido.Transporte.id_contato        := jsonTrasp.GetValue<TJSONObject>('contato',nil).GetValue<int64>('id',0);
                            Pedido.Transporte.nome              := RemoverCaracteresEspeciais( jsonTrasp.GetValue<TJSONObject>('etiqueta',nil).GetValue<string>('nome','') );
                            Pedido.Transporte.endereco          := RemoverCaracteresEspeciais( jsonTrasp.GetValue<TJSONObject>('etiqueta',nil).GetValue<string>('endereco','') );
                            Pedido.Transporte.numero            := jsonTrasp.GetValue<TJSONObject>('etiqueta',nil).GetValue<string>('numero','');
                            Pedido.Transporte.complemento       := RemoverCaracteresEspeciais( jsonTrasp.GetValue<TJSONObject>('etiqueta',nil).GetValue<string>('complemento','') );
                            Pedido.Transporte.municipio         := RemoverCaracteresEspeciais( jsonTrasp.GetValue<TJSONObject>('etiqueta',nil).GetValue<string>('municipio','') );
                            Pedido.Transporte.uf                := jsonTrasp.GetValue<TJSONObject>('etiqueta',nil).GetValue<string>('uf','');
                            Pedido.Transporte.cep               := jsonTrasp.GetValue<TJSONObject>('etiqueta',nil).GetValue<string>('cep','');
                            Pedido.Transporte.bairro            := RemoverCaracteresEspeciais( jsonTrasp.GetValue<TJSONObject>('etiqueta',nil).GetValue<string>('bairro','') );
                            Pedido.Transporte.nomepais          := jsonTrasp.GetValue<TJSONObject>('etiqueta',nil).GetValue<string>('nomePais','');
                        end;

                end
            else
                Pedido  := nil;

        end
    else
        begin
            jsonErr := jsonObj.GetValue<TJSONObject>('error',nil);
            if jsonErr = nil then
              FErro := 'Falha ao pegar erro'
            else
              FErro := jsonErr.GetValue<string>('description','Falha ao pegar erro');
            Pedido.id  := 0;
        end;

end;


constructor TBling.Create;
begin

    // Criar Lista de Modulos
    FModulos := TObjectList<TModulosBling>.Create;

    // Formas Pagamento
    FormasPagamento := TObjectList<TFormasPagamento>.Create;

    // Depositos
    Depositos := TObjectList<TDeposito>.Create;

    // Pedido
    Pedido  := TPedidoBling.Create;

end;


function TBling.CStringDate(Dt: string): TDate;
var
    dia, mes, ano: Word;
begin

    if Dt = '0000-00-00' then
        begin
            Result  := EncodeDate(1900,01,01);
            exit;
        end;

    // 2023-07-01
    ano := StrToInt( Copy( Dt, 1 , 4 ) );
    mes := StrToInt( Copy( Dt, 6 , 2 ) );
    dia := StrToInt( Copy( Dt, 9 , 2 ) );
    Result  := EncodeDate(ano, mes, dia);
end;


procedure TBling.DelFormasPagamento(Index: Integer);
begin
    FFormasPagamento.Delete(Index);
end;


procedure TBling.DelModulo(Index: Integer);
begin

    // Deletar
    FModulos.Delete(Index);

end;


destructor TBling.Destroy;
begin

    // Destru Lista de Modulos
    FreeAndNil(FModulos);

    // Pedido
    FreeAndNil(Pedido);

    // Formas Pagamento
    FreeAndNil(FormasPagamento);

    // Depositos
    FreeAndNil(Depositos);

    inherited;

end;


function TBling.EnviarEstoque(id_produto: Int64; id_estoque: Int64; quantidade: Integer): Boolean;
var
    Resp      : IResponse;
    jsonObj   : TJSONObject;
    jsonEst   : TJSONObject;
    jsonProd  : TJSONObject;
    jsonDep   : TJSONObject;
    jsonErr   : TJSONObject;
begin

    // Limpa
    FErro    := '';
    Result   := False;


    // Produto
    jsonProd  := TJSONObject.Create;
    jsonProd.AddPair('id',TJSONNumber.Create(id_produto));


    // Deposito
    JsonDep  := TJSONObject.Create;
    JsonDep.AddPair('id',TJSONNumber.Create(id_estoque));


    // Estoque
    jsonEst := TJSONObject.Create;
    jsonEst.AddPair('quantidade',TJSONNumber.Create(quantidade));
    jsonEst.AddPair('operacao','B');
    jsonEst.AddPair('observacoes','Enviado estoque ' + FormatDateTime('dd/MM/yyyy hh:mm' , now));
    jsonEst.AddPair('data',FormatDateTime('yyyy-MM-dd hh:mm:ss' , now));
    jsonEst.AddPair('produto',jsonProd );
    jsonEst.AddPair('deposito',JsonDep );



    // Verifica se tem AcessToken
    Resp    :=   TRequest.New.BaseURL( url )
                .Resource('/estoques' )
                .TokenBearer(AccessToken)
                .ContentType('application/json')
                .AddBody(jsonEst.ToString)
                .Timeout(10000)
                .Post;

    // Json
    jsonObj := TJSONObject.Create;
    jsonObj := TJSONObject.ParseJSONValue(Resp.Content) as TJSONObject;

    // Verifica se teve alguma retorno
    if Resp.StatusCode = 201 then
        begin

            // Resultado
            result  := True;

        end
    else
        begin
            jsonErr := jsonObj.GetValue<TJSONObject>('error',nil);
            if jsonErr = nil then
              FErro := 'Falha ao pegar erro'
            else
              FErro := jsonErr.GetValue<string>('description','Falha ao pegar erro');
            Pedido  := nil;
        end;

end;


function TBling.GerarAccessToken: Boolean;
var
    Resp    : IResponse;
    jsonObj : TJSONObject;
    jsonErr : TJSONObject;
begin

    Result  := False;
    FErro    := '';
    Sleep(1000);    // Aguarda para não dar erro 429

    // Verifica se tem AcessToken
    Resp    :=   TRequest.New.BaseURL( url )
                .Resource('/oauth/token')
                .ContentType('application/x-www-form-urlencoded')
                .BasicAuthentication( FClientId , FSecretKey )
                .AddBody('grant_type=authorization_code')
                .AddBody('&')
                .AddBody('code=' + Fcode)
                .Timeout(10000)
                .Post;

    // Json
    jsonObj := TJSONObject.Create;
    jsonObj := TJSONObject.ParseJSONValue(Resp.Content) as TJSONObject;

    // Verifica se teve alguma retorno
    if Resp.StatusCode = 200 then
        begin
            RefreshToken  := jsonObj.GetValue<string>('refresh_token','');
            AccessToken   := jsonObj.GetValue<string>('access_token' ,'');
            ValidadeToken := IncMinute( Now , jsonObj.GetValue<integer>('expires_in' ,0)  div 60 );
            Result        := True;
        end
    else
        begin
            jsonErr := jsonObj.GetValue<TJSONObject>('error',nil);
            RefreshToken  := '';
            AccessToken   := '';
            if jsonErr = nil then
              FErro := 'Falha ao pegar erro'
            else
              FErro := jsonErr.GetValue<string>('description','Falha ao pegar erro');
            Result        := False;
        end;

end;


function TBling.GerarCodigoStateAleatorio(Tamanho: Integer): string;
const
  SpecialChars = '@#$*';
var
  CharPool  : string;
  CharIndex : Integer;
  i         : Integer;
begin
  // Define o pool de caracteres a serem utilizados
  CharPool := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
              'abcdefghijklmnopqrstuvwxyz' +
              '0123456789' +
              SpecialChars;

  // Inicializa a semente do gerador de números aleatórios
  Randomize;

  // Gera a senha aleatória
  Result := '';
  for i := 1 to Tamanho do
    begin
        CharIndex := Random(Length(CharPool)) + 1;
        Result := Result + CharPool[CharIndex];
    end;
end;


function TBling.GerarUrlCode: string;
const
    url = 'https://www.bling.com.br/Api/v3/oauth/authorize?response_type=code';
begin

    Result  :=  url +
                '&client_id='    + FClientId   +
                '&state='        + CodigoState;

end;


function TBling.ListaPedidos(dtInicial, dtFinal: TDate; id_situacao: Integer): TObjectList<TPedidoCabecalho>;
var
    Resp    : IResponse;
    jsonObj : TJSONObject;
    jsonData: TJsonArray;
    jsonErr : TJSONObject;
    x       : Integer;
    Ped     : TPedidoCabecalho;
begin

    FErro    := '';
    Result   := TObjectList<TPedidoCabecalho>.Create;

    // Verifica se o Token nao é Valido
    if TokenValido = false then
        begin

            // tenta renovr token
            if RenovarAccessToken = false then
                begin

                    // Tenta gerar o primeiro Token
                    if GerarAccessToken = false then
                        exit;

                end;

        end;


    // Verifica se tem AcessToken
    Resp    :=   TRequest.New.BaseURL( url )
                .Resource('/pedidos/vendas')
                .AddParam('dataInicial', FormatDateTime('yyyy-MM-dd',dtInicial) )
                .AddParam('dataFinal'  , FormatDateTime('yyyy-MM-dd',dtFinal  ) )
                .AddParam('idsSituacoes'        , id_situacao.ToString )
                .TokenBearer(AccessToken)
                .ContentType('application/json')
                .Timeout(10000)
                .Get;

    // Json
    jsonObj := TJSONObject.Create;
    jsonObj := TJSONObject.ParseJSONValue(Resp.Content) as TJSONObject;

    // Verifica se teve alguma retorno
    if Resp.StatusCode = 200 then
        begin

            // Converte o Array
            jsonData := jsonObj.GetValue<TJsonArray>('data',nil);

            // Se trouxe alguma respota
            if jsonData <> nil then
                begin

                    // Passa pelos regitros
                    for x := 0 to jsonData.Count -1 do
                        begin

                            // Pedido
                            Ped     := TPedidoCabecalho.Create;
                            Ped.id  := (TJSONObject.ParseJSONValue(jsonData.Items[x].ToString) as TJSONObject).GetValue<Int64>('id',0);

                            // Adciona
                            Result.Add(Ped);

                        end;

                end
            else
                Result  := nil;

        end
    else
        begin
            jsonErr := jsonObj.GetValue<TJSONObject>('error',nil);
            if jsonErr = nil then
              FErro := 'Falha ao pegar erro'
            else
              FErro := jsonErr.GetValue<string>('description','Falha ao pegar erro');
            Result  := nil;
        end;

end;


function TBling.ListarDepositos: Boolean;
var
    Resp    : IResponse;
    jsonObj : TJSONObject;
    jsonData: TJsonArray;
    jsonErr : TJSONObject;
    D       : TDeposito;
    x       : Integer;
begin

    Result  := False;
    FErro    := '';

    // Verifica se o Token nao é Valido
    if TokenValido = false then
        begin

            // tenta renovr token
            if RenovarAccessToken = false then
                begin

                    // Tenta gerar o primeiro Token
                    if GerarAccessToken = false then
                        exit;

                end;

        end;


    // Verifica se tem AcessToken
    Resp    :=   TRequest.New.BaseURL( url )
                .Resource('/depositos')
                .TokenBearer(AccessToken)
                .ContentType('application/json')
                .Timeout(10000)
                .Get;

    // Json
    jsonObj := TJSONObject.Create;
    jsonObj := TJSONObject.ParseJSONValue(Resp.Content) as TJSONObject;

    // Verifica se teve alguma retorno
    if Resp.StatusCode = 200 then
        begin

            // Converte o Array
            jsonData := jsonObj.GetValue<TJsonArray>('data',nil);

            // Limpa Depositos
            Depositos.Clear;

            // Varre os Registros
            for x := 0 to jsonData.Count -1 do
              begin

                  // Nova Deposito
                  D     := TDeposito.Create;
                  D.id        := (TJSONObject.ParseJSONValue(jsonData.Items[x].ToString) as TJSONObject).GetValue<int64>('id',0);
                  D.descricao := (TJSONObject.ParseJSONValue(jsonData.Items[x].ToString) as TJSONObject).GetValue<string>('descricao','');
                  D.situacao  := (TJSONObject.ParseJSONValue(jsonData.Items[x].ToString) as TJSONObject).GetValue<integer>('situacao',0);
                  D.padrao    := (TJSONObject.ParseJSONValue(jsonData.Items[x].ToString) as TJSONObject).GetValue<Boolean>('padrao',true);

                  // Adiciona
                  FDepositos.Add(D);

              end;

            // Finaliza
            Result  := True;

        end
    else
        begin
            jsonErr := jsonObj.GetValue<TJSONObject>('error',nil);
            if jsonErr = nil then
              FErro := 'Falha ao pegar erro'
            else
              FErro := jsonErr.GetValue<string>('description','Falha ao pegar erro');
            Result        := False;
        end;

end;

function TBling.ListarFormasPagamento: Boolean;
var
    Resp    : IResponse;
    jsonObj : TJSONObject;
    jsonData: TJsonArray;
    jsonErr : TJSONObject;
    F       : TFormasPagamento;
    x       : Integer;
begin

    Result  := False;
    FErro    := '';

    // Verifica se o Token nao é Valido
    if TokenValido = false then
        begin

            // tenta renovr token
            if RenovarAccessToken = false then
                begin

                    // Tenta gerar o primeiro Token
                    if GerarAccessToken = false then
                        exit;

                end;

        end;


    // Verifica se tem AcessToken
    Resp    :=   TRequest.New.BaseURL( url )
                .Resource('/formas-pagamentos')
                .TokenBearer(AccessToken)
                .ContentType('application/json')
                .Timeout(10000)
                .Get;

    // Json
    jsonObj := TJSONObject.Create;
    jsonObj := TJSONObject.ParseJSONValue(Resp.Content) as TJSONObject;

    // Verifica se teve alguma retorno
    if Resp.StatusCode = 200 then
        begin

            // Converte o Array
            jsonData := jsonObj.GetValue<TJsonArray>('data',nil);

            // Limpa Modulos
            Modulos.Clear;

            // Varre os Registros
            for x := 0 to jsonData.Count -1 do
              begin

                  // Nova Forma Pagamento
                  F     := TFormasPagamento.Create;
                  F.id            := (TJSONObject.ParseJSONValue(jsonData.Items[x].ToString) as TJSONObject).GetValue<integer>('id',0);
                  F.descricao     := (TJSONObject.ParseJSONValue(jsonData.Items[x].ToString) as TJSONObject).GetValue<string>('descricao','');
                  F.tipopagamento := (TJSONObject.ParseJSONValue(jsonData.Items[x].ToString) as TJSONObject).GetValue<integer>('situacao',0);

                  // Adiciona
                  FFormasPagamento.Add(F);

              end;

            // Finaliza
            Result  := True;

        end
    else
        begin
            jsonErr := jsonObj.GetValue<TJSONObject>('error',nil);
            if jsonErr = nil then
              FErro := 'Falha ao pegar erro'
            else
              FErro := jsonErr.GetValue<string>('description','Falha ao pegar erro');
            Result        := False;
        end;

end;


function TBling.ListarModulo: Boolean;
var
    Resp    : IResponse;
    jsonObj : TJSONObject;
    jsonData: TJsonArray;
    jsonErr : TJSONObject;
    M       : TModulosBling;
    x       : Integer;
begin

    Result  := False;
    FErro    := '';

    // Verifica se o Token nao é Valido
    if TokenValido = false then
        begin

            // tenta renovr token
            if RenovarAccessToken = false then
                begin

                    // Tenta gerar o primeiro Token
                    if GerarAccessToken = false then
                        exit;

                end;

        end;


    // Verifica se tem AcessToken
    Resp    :=   TRequest.New.BaseURL( url )
                .Resource('/situacoes/modulos')
                .TokenBearer(AccessToken)
                .ContentType('application/json')
                .Timeout(10000)
                .Get;

    // Json
    jsonObj := TJSONObject.Create;
    jsonObj := TJSONObject.ParseJSONValue(Resp.Content) as TJSONObject;

    // Verifica se teve alguma retorno
    if Resp.StatusCode = 200 then
        begin

            // Converte o Array
            jsonData := jsonObj.GetValue<TJsonArray>('data',nil);

            // Limpa Modulos
            Modulos.Clear;

            // Varre os Registros
            for x := 0 to jsonData.Count -1 do
              begin

                  // Novo Modulo
                  m     := TModulosBling.Create;
                  m.id  := (TJSONObject.ParseJSONValue(jsonData.Items[x].ToString) as TJSONObject).GetValue<integer>('id',0);
                  m.nome:= (TJSONObject.ParseJSONValue(jsonData.Items[x].ToString) as TJSONObject).GetValue<string>('nome','');
                  m.descricao := (TJSONObject.ParseJSONValue(jsonData.Items[x].ToString) as TJSONObject).GetValue<string>('descricao','');

                  // Adiciona
                  Modulos.Add(m);

              end;

            // Finaliza
            Result  := True;

        end
    else
        begin
            jsonErr := jsonObj.GetValue<TJSONObject>('error',nil);
            if jsonErr = nil then
              FErro := 'Falha ao pegar erro'
            else
              FErro := jsonErr.GetValue<string>('description','Falha ao pegar erro');
            Result        := False;
        end;

end;


function TBling.ListarSituacao( M: TModulosBling ): Boolean;
var
    Resp    : IResponse;
    jsonObj : TJSONObject;
    jsonData: TJsonArray;
    jsonErr : TJSONObject;
    S       : TSituacoesBling;
    x       : Integer;
begin

    Result  := False;
    FErro    := '';

    // Verifica se o Token nao é Valido
    if TokenValido = false then
        begin

            // tenta renovr token
            if RenovarAccessToken = false then
                begin

                    // Tenta gerar o primeiro Token
                    if GerarAccessToken = false then
                        exit;

                end;

        end;


    // Verifica se tem AcessToken
    Resp    :=   TRequest.New.BaseURL( url )
                .Resource('situacoes/modulos/' + M.id.ToString )
                .TokenBearer(AccessToken)
                .ContentType('application/json')
                .Timeout(10000)
                .Get;

    // Json
    jsonObj := TJSONObject.Create;
    jsonObj := TJSONObject.ParseJSONValue(Resp.Content) as TJSONObject;

    // Verifica se teve alguma retorno
    if Resp.StatusCode = 200 then
        begin

            // Converte o Array
            jsonData := jsonObj.GetValue<TJsonArray>('data',nil);

            // Limpa Situacoes
            M.situacoes.Clear;

            // Varre os Registros
            for x := 0 to jsonData.Count -1 do
              begin

                  // Nova Situacao
                  S     := TSituacoesBling.Create;
                  S.id  := (TJSONObject.ParseJSONValue(jsonData.Items[x].ToString) as TJSONObject).GetValue<integer>('id',0);
                  S.nome:= (TJSONObject.ParseJSONValue(jsonData.Items[x].ToString) as TJSONObject).GetValue<string>('nome','');

                  // Adiciona
                  M.situacoes.Add(S);

              end;

            // Finaliza
            Result  := True;

        end
    else
        begin
            jsonErr := jsonObj.GetValue<TJSONObject>('error',nil);
            if jsonErr = nil then
              FErro := 'Falha ao pegar erro'
            else
              FErro := jsonErr.GetValue<string>('description','Falha ao pegar erro');
            Result        := False;
        end;

end;


function TBling.RemoverCaracteresEspeciais(Value: String): string;
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

function TBling.RenovarAccessToken: Boolean;
var
    Resp    : IResponse;
    jsonObj : TJSONObject;
    jsonErr : TJSONObject;
begin

    Result  := False;
    FErro    := '';
    Sleep(1000);    // Aguarda para não dar erro 429

    // Verifica se tem AcessToken
    Resp    :=   TRequest.New.BaseURL( url )
                .Resource('/oauth/token')
                .ContentType('application/x-www-form-urlencoded')
                .BasicAuthentication( FClientId , FSecretKey )
                .AddBody('grant_type=refresh_token')
                .AddBody('&')
                .AddBody('refresh_token=' + RefreshToken )
                .Timeout(10000)
                .Post;

    // Json
    jsonObj := TJSONObject.Create;
    jsonObj := TJSONObject.ParseJSONValue(Resp.Content) as TJSONObject;

    // Verifica se teve alguma retorno
    if Resp.StatusCode = 200 then
        begin
            RefreshToken  := jsonObj.GetValue<string>('refresh_token','');
            AccessToken   := jsonObj.GetValue<string>('access_token' ,'');
            ValidadeToken := IncMinute( Now , jsonObj.GetValue<integer>('expires_in' ,3600) div 60 );
            Result        := True;
        end
    else
        begin
            jsonErr := jsonObj.GetValue<TJSONObject>('error',nil);
            RefreshToken  := '';
            AccessToken   := '';
            if jsonErr = nil then
              FErro := 'Falha ao pegar erro'
            else
              FErro := jsonErr.GetValue<string>('description','Falha ao pegar erro');
            Result        := False;
        end;

end;


function TBling.ValidarToken: Boolean;
begin
    Result  := FValidadeToken > now ;
end;


{ TModulosBling }

procedure TModulosBling.AddSituacao(S: TSituacoesBling);
begin
    Fsituacoes.Add(S);
end;


constructor TModulosBling.Create;
begin

    // Criar Lista de Sifutacoes
    Fsituacoes := TObjectList<TSituacoesBling>.Create;

end;


procedure TModulosBling.DelSituacao(Index: Integer);
begin
  Fsituacoes.Delete(index);
end;


destructor TModulosBling.Destroy;
begin

    // Destru Lista de Situacoes
    FreeAndNil(Fsituacoes);

    inherited;
end;


{ TPedidoBling }

procedure TPedidoBling.AddItem(I: TPedidoItemBling);
begin
    FItens.Add(I);
end;


procedure TPedidoBling.AddParcela(P: TPedidoParcelaBling);
begin
    FParcelas.Add(P);
end;


constructor TPedidoBling.Create;
begin
    FItens      := TObjectList<TPedidoItemBling>.Create;
    FParcelas   := TObjectList<TPedidoParcelaBling>.Create;
    FTransporte := TPedidoTransporteBling.Create;
end;


procedure TPedidoBling.DelItem(Index: Integer);
begin
    FItens.Delete(Index);
end;


procedure TPedidoBling.DelParcela(Index: Integer);
begin
    FParcelas.Delete(Index);
end;


destructor TPedidoBling.Destroy;
begin
  FreeAndNil(FItens);
  FreeAndNil(FParcelas);
  FreeAndNil(FTransporte);
  inherited;
end;

end.
