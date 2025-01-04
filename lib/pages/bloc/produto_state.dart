import 'package:app_milli/models/produto_model.dart';
import 'package:muller_package/models/error_model.dart';

abstract class ProdutoState {
  ErrorModel errorModel;
  List<ProdutoModel> produtos;
  ProdutoModel produtoMaiorPreco;
  double media;

  ProdutoState({
    required this.produtos,
    required this.errorModel,
    required this.media,
    required this.produtoMaiorPreco,
  });
}

class ProdutoInitialState extends ProdutoState {
  ProdutoInitialState()
      : super(
          produtoMaiorPreco: ProdutoModel.empty(),
          produtos: [],
          errorModel: ErrorModel.empty(),
          media: 0,
        );
}

class ProdutoLoadingState extends ProdutoState {
  ProdutoLoadingState()
      : super(
          produtoMaiorPreco: ProdutoModel.empty(),
          produtos: [],
          errorModel: ErrorModel.empty(),
          media: 0,
        );
}

class ProdutoSuccessState extends ProdutoState {
  ProdutoSuccessState({
    required super.produtos,
    required super.media,
    required super.produtoMaiorPreco,
  }) : super(errorModel: ErrorModel.empty());
}

class ProdutoErrorState extends ProdutoState {
  ProdutoErrorState({required super.errorModel})
      : super(
          produtoMaiorPreco: ProdutoModel.empty(),
          produtos: [],
          media: 0,
        );
}
