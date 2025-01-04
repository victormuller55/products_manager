import 'package:app_milli/app_config/const/app_colors.dart';
import 'package:app_milli/models/produto_model.dart';
import 'package:app_milli/pages/bloc/produto_bloc.dart';
import 'package:app_milli/pages/bloc/produto_event.dart';
import 'package:app_milli/pages/bloc/produto_state.dart';
import 'package:app_milli/pages/produto_cadastro_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:muller_package/muller_package.dart';

class ProdutoListagemPage extends StatefulWidget {
  const ProdutoListagemPage({super.key});

  @override
  State<ProdutoListagemPage> createState() => _ProdutoListagemPageState();
}

class _ProdutoListagemPageState extends State<ProdutoListagemPage> {
  ProdutoBloc bloc = ProdutoBloc();

  void _loadData() {
    bloc.add(ProdutoLoadEvent());
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  DataColumn _cellDataText(String value) {
    return DataColumn(
      label: Center(
        child: appText(
          value.toUpperCase(),
          color: AppColors.white,
          bold: true,
          letterSpacing: 1,
        ),
      ),
    );
  }

  DataCell _cellDataOptions(ProdutoModel model) {
    return DataCell(
      Center(
        child: PopupMenuButton<String>(
          tooltip: "Mostrar Menu",
          child: appContainer(
            height: 35,
            width: 35,
            radius: BorderRadius.circular(AppRadius.small),
            backgroundColor: MiliColors.primary.withOpacity(0.3),
            child: Center(
              child: Icon(Icons.menu, color: MiliColors.primary),
            ),
          ),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              child: appText('Editar Produto'.toUpperCase()),
              onTap: () => _showCadastrar(model),
            ),
            PopupMenuItem<String>(
              child: appText('Excluir Produto'.toUpperCase()),
              onTap: () => bloc.add(ProdutoDeleteEvent(model.id!)),
            ),
          ],
        ),
      ),
    );
  }

  DataCell _appDataCellText(String? value, {bool? bold}) {
    return DataCell(appText(value ?? "", color: AppColors.grey700, bold: bold));
  }

  void _showCadastrar(ProdutoModel model) {
    showDialog(
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Dialog(
              backgroundColor: AppColors.transparent,
              child: appContainer(
                backgroundColor: AppColors.grey200,
                radius: BorderRadius.circular(5),
                child: ProdutoCadastroPage(bloc: bloc, model: model),
              ),
            ),
          ],
        );
      },
    );
  }

  String _doubleToReais(double value) {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(value);
  }

  Color _dataRowColor(int index) {
    if (index % 2 == 0) return Colors.grey.shade100;
    return Colors.grey.shade300;
  }

  String _formatDesconto(bool desconto) {
    if (desconto) return "10%";
    return "-";
  }

  String _formatPeso(double peso, String tipoProduto) {
    if (tipoProduto == "Fisico") return "$peso kg";
    return "$peso mb";
  }

  Widget _table(List<ProdutoModel> produtos) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(AppSpacing.normal),
      child: DataTable(
        headingRowHeight: 40,
        dividerThickness: 0,
        showBottomBorder: false,
        headingRowColor: WidgetStateColor.resolveWith((states) => AppColors.grey900),
        border: const TableBorder(
          horizontalInside: BorderSide.none,
          verticalInside: BorderSide.none,
          top: BorderSide.none,
          bottom: BorderSide.none,
          left: BorderSide.none,
          right: BorderSide.none,
        ),
        columns: [
          _cellDataText("Opções"),
          _cellDataText('Produto'),
          _cellDataText('Tipo'),
          _cellDataText('Peso'),
          _cellDataText('Preço'),
          _cellDataText('Desconto (%)'),
          _cellDataText('Preço com promoção'),
          _cellDataText('Valor do Frete'),
          _cellDataText('Preço total'),
        ],
        rows: List.generate(
          produtos.length,
          (index) {
            final ProdutoModel produto = produtos[index];

            return DataRow(
              color: WidgetStateProperty.resolveWith((states) => _dataRowColor(index)),
              cells: [
                _cellDataOptions(produto),
                _appDataCellText(produto.descricao),
                _appDataCellText(produto.descricaoTipo),
                _appDataCellText(_formatPeso(produto.peso!, produto.descricaoTipo!)),
                _appDataCellText(_doubleToReais(produto.preco!)),
                _appDataCellText(_formatDesconto(produto.desconto!)),
                _appDataCellText(_doubleToReais(produto.precoPromocao!)),
                _appDataCellText(_doubleToReais(produto.freteValor!)),
                _appDataCellText(_doubleToReais(produto.precoTotal!), bold: true),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _header(double media, ProdutoModel maisCaro) {
    String mediaString = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(media);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          appElevatedButtonText(
            "Cadastrar".toUpperCase(),
            function: () => _showCadastrar(ProdutoModel()),
            width: 200,
            color: MiliColors.primary,
            textColor: AppColors.white,
            borderRadius: AppRadius.small,
          ),
          appSizedBox(width: AppSpacing.normal),
          appContainer(
            height: 40,
            width: 250,
            backgroundColor: AppColors.grey300,
            child: Center(child: appText("Média dos valores: $mediaString")),
          ),
          appSizedBox(width: AppSpacing.normal),
          appContainer(
            height: 40,
            width: 250,
            backgroundColor: AppColors.grey300,
            child: Center(child: appText(maisCaro.descricao!.isEmpty ? "Nenhum produto" : "Produto mais caro: ${maisCaro.descricao.toString()}")),
          ),
        ],
      ),
    );
  }

  Widget _body(List<ProdutoModel> produtos, double media, ProdutoModel maisCaro) {
    if (produtos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _header(media, maisCaro),
            const Spacer(),
            Expanded(
              child: Column(
                children: [
                  Icon(Icons.search, size: 40, color: AppColors.grey700),
                  appSizedBox(height: AppSpacing.normal),
                  appText("Nenhum resultado encontrado", color: AppColors.grey),
                  appSizedBox(height: AppSpacing.normal),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(media, maisCaro),
        _table(produtos),
      ],
    );
  }

  Widget _bodyBuilder() {
    return BlocBuilder<ProdutoBloc, ProdutoState>(
      bloc: bloc,
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (ProdutoLoadingState):
            return appLoading(child: const CircularProgressIndicator());
          case const (ProdutoSuccessState):
            return _body(state.produtos, state.media, state.produtoMaiorPreco);
          case const (ProdutoErrorState):
            return appError(state.errorModel, function: () => _loadData());
          default:
            return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      title: "Produtos cadastrados",
      body: _bodyBuilder(),
      appBarColor: MiliColors.primaryDarker,
      hideBackIcon: true,
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
