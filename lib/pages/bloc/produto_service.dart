import 'dart:convert';

import 'package:app_milli/models/produto_model.dart';
import 'package:muller_package/muller_package.dart';

String endpoint = "http://localhost:5000/v1/milli/produtos";

Future<List<ProdutoModel>> sendRequestGetProdutos() async {
  AppResponse response = await getHTTP(endpoint: "$endpoint/todos");
  List<dynamic> jsonResponse = jsonDecode(response.body);
  List<ProdutoModel> produtos = jsonResponse.map((item) => ProdutoModel.fromJson(item)).toList();

  return produtos;
}

Future<ProdutoModel> sendRequestGetMaiorValor() async {
  try {
    AppResponse response = await getHTTP(endpoint: "$endpoint/maior-valor");
    dynamic jsonResponse = jsonDecode(response.body);
    ProdutoModel produto = ProdutoModel.fromJson(jsonResponse);
    return produto;
  } catch (e) {
    return ProdutoModel.empty();
  }
}

Future<double> sendRequestGetMedia() async {
  AppResponse response = await getHTTP(endpoint: "$endpoint/media-precos");
  double media = double.parse(response.body);
  return media;
}

Future<void> sendRequestPostProduto(ProdutoModel produto) async {
  if (produto.id == null) {
    await postHTTP(endpoint: endpoint, body: produto.toJsonPost());
    return;
  }

  await postHTTP(endpoint: endpoint, body: produto.toJsonPut());
}

Future<void> sendRequestDeleteProduto(int id) async {
  await deleteHTTP(endpoint: endpoint, parameters: {'id_produto': id.toString()});
}
