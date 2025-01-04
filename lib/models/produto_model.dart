class ProdutoModel {
  int? id;
  String? descricao;
  String? descricaoTipo;
  double? peso;
  double? preco;
  double? freteValor;
  bool? desconto;
  double? precoPromocao;
  double? precoTotal;

  ProdutoModel({
    this.id,
    this.descricao,
    this.descricaoTipo,
    this.peso,
    this.preco,
    this.freteValor,
    this.desconto,
    this.precoPromocao,
    this.precoTotal,
  });

  factory ProdutoModel.empty() {
    return ProdutoModel(
      id: 0,
      descricao: "",
      descricaoTipo: "",
      peso: 0,
      preco: 0,
      freteValor: 0,
      desconto: false,
      precoPromocao: 0,
      precoTotal: 0,
    );
  }

  ProdutoModel.fromJson(Map<String, dynamic> json) {
    id = json['id_produto'];
    descricao = json['descricao_produto'];
    descricaoTipo = json['descricao_tipo_produto'];
    peso = json['peso_produto'];
    preco = json['preco_produto'];
    freteValor = json['frete_valor_produto'];
    desconto = json['desconto'];
    precoPromocao = json['preco_promocao_produto'];
    precoTotal = json['preco_total_produto'];
  }

  Map<String, dynamic> toJsonPut() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_produto'] = id;
    data['descricao_produto'] = descricao;
    data['id_tipo_produto'] = descricaoTipo == "Fisico" ? 1 : 2;
    data['peso_produto'] = peso;
    data['preco_produto'] = preco;
    data['frete_valor_produto'] = freteValor;
    data['desconto'] = desconto;
    data['preco_promocao_produto'] = precoPromocao;
    data['preco_total_produto'] = precoTotal;

    return data;
  }

  Map<String, dynamic> toJsonPost() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['descricao_produto'] = descricao;
    data['id_tipo_produto'] = descricaoTipo == "Fisico" ? 1 : 2;
    data['peso_produto'] = peso;
    data['preco_produto'] = preco;
    data['desconto'] = desconto;

    return data;
  }
}
