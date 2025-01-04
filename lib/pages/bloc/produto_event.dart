import 'package:app_milli/models/produto_model.dart';

abstract class ProdutoEvent {}

class ProdutoLoadEvent extends ProdutoEvent {}

class ProdutoCadastrarEvent extends ProdutoEvent {
  ProdutoModel produtoModel;
  ProdutoCadastrarEvent(this.produtoModel);
}

class ProdutoDeleteEvent extends ProdutoEvent {
  int idProduto;
  ProdutoDeleteEvent(this.idProduto);
}