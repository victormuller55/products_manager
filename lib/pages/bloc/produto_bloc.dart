import 'package:app_milli/models/produto_model.dart';
import 'package:app_milli/pages/bloc/produto_event.dart';
import 'package:app_milli/pages/bloc/produto_service.dart';
import 'package:app_milli/pages/bloc/produto_state.dart';
import 'package:muller_package/muller_package.dart';
import 'package:bloc/bloc.dart';

class ProdutoBloc extends Bloc<ProdutoEvent, ProdutoState> {
  ProdutoBloc() : super(ProdutoInitialState()) {
    on<ProdutoLoadEvent>((event, emit) async {
      emit(ProdutoLoadingState());
      try {

        List<ProdutoModel> produtos = await sendRequestGetProdutos();
        double media = await sendRequestGetMedia();
        ProdutoModel produtoMaiorPreco = await sendRequestGetMaiorValor();

        emit(ProdutoSuccessState(produtos: produtos, media: media, produtoMaiorPreco: produtoMaiorPreco));
      } catch (e) {
        emit(ProdutoErrorState(errorModel: ApiException.errorModel(e)));
        showSnackbarError(message: state.errorModel.mensagem);
      }
    });

    on<ProdutoCadastrarEvent>((event, emit) async {
      emit(ProdutoLoadingState());
      try {

        await sendRequestPostProduto(event.produtoModel);
        List<ProdutoModel> produtos = await sendRequestGetProdutos();
        ProdutoModel produtoMaiorPreco = await sendRequestGetMaiorValor();
        double media = await sendRequestGetMedia();

        emit(ProdutoSuccessState(produtos: produtos, media: media, produtoMaiorPreco: produtoMaiorPreco));

        showSnackbarSuccess(message: "Produto cadastrado com sucesso.");
      } catch (e) {
        emit(ProdutoErrorState(errorModel: ApiException.errorModel(e)));
        showSnackbarError(message: state.errorModel.mensagem);
      }
    });

    on<ProdutoDeleteEvent>((event, emit) async {
      emit(ProdutoLoadingState());
      try {

        await sendRequestDeleteProduto(event.idProduto);
        List<ProdutoModel> produtos = await sendRequestGetProdutos();
        ProdutoModel produtoMaiorPreco = await sendRequestGetMaiorValor();
        double media = await sendRequestGetMedia();

        emit(ProdutoSuccessState(produtos: produtos, media: media, produtoMaiorPreco: produtoMaiorPreco));

        showSnackbarSuccess(message: "Produto excluido com sucesso.");
      } catch (e) {
        emit(ProdutoErrorState(errorModel: ApiException.errorModel(e)));
        showSnackbarError(message: state.errorModel.mensagem);
      }
    });
  }
}
