import 'package:app_milli/app_config/const/app_colors.dart';
import 'package:app_milli/models/produto_model.dart';
import 'package:app_milli/pages/bloc/produto_bloc.dart';
import 'package:app_milli/pages/bloc/produto_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:muller_package/app_components/app_dropdown.dart';
import 'package:muller_package/app_components/form_field/app_form_field_currency.dart';
import 'package:muller_package/muller_package.dart';

class ProdutoCadastroPage extends StatefulWidget {
  final ProdutoBloc bloc;
  final ProdutoModel model;

  const ProdutoCadastroPage({super.key, required this.bloc, required this.model});

  @override
  State<ProdutoCadastroPage> createState() => _ProdutoCadastroPageState();
}

class _ProdutoCadastroPageState extends State<ProdutoCadastroPage> {
  late AppFormField _descricaoProdutoForm;
  late AppDropdown<String> _tipoProdutoForm;
  late AppFormField _pesoProdutoForm;
  late AppCurrencyFormField _precoProdutoForm;

  String formatarParaReal(double valor) {
    final NumberFormat formatoReal = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
    );
    return formatoReal.format(valor);
  }

  String getJustNumbers(String texto) {
    return texto.replaceAll(RegExp(r'[^\d.]'), '');
  }

  void _editar() {
    if (widget.model.id != null) {
      _descricaoProdutoForm.controller.text = widget.model.descricao!;
      _tipoProdutoForm.selectedValue = widget.model.descricaoTipo;
      _pesoProdutoForm.controller.text = getJustNumbers(widget.model.peso!.toString());
      _precoProdutoForm.controller.text = formatarParaReal(widget.model.preco!);
    }
  }

  void _save() {
    widget.model.descricao = _descricaoProdutoForm.value;
    widget.model.descricaoTipo = _tipoProdutoForm.value;
    widget.model.peso = double.parse(getJustNumbers(_pesoProdutoForm.value.replaceAll(",", ".")));
    widget.model.preco = double.parse(_precoProdutoForm.value.trim().replaceAll(".", "").replaceAll(",", ".").replaceAll("\$", "").replaceAll("R", ""));

    widget.bloc.add(ProdutoCadastrarEvent(widget.model));
    Navigator.pop(context);
  }

  @override
  void initState() {
    _descricaoProdutoForm = AppFormField(
      context: context,
      hint: 'Nome do produto',
      icon: const Icon(Icons.shopping_cart),
      width: 300,
      radius: AppRadius.small,
    );

    _tipoProdutoForm = AppDropdown<String>(
      hint: 'Selecione o tipo',
      items: ["Fisico", "Digital"],
      width: 300,
      defaultValue: "Fisico",
      radius: AppRadius.small,
      icon: const Icon(Icons.type_specimen),
    );

    _pesoProdutoForm = AppFormField(
      context: context,
      hint: 'Peso do produto (kg ou MB)',
      icon: const Icon(Icons.monitor_weight),
      width: 300,
      textInputFormatter: FilteringTextInputFormatter.allow(RegExp(r'\d{1,3}(\.\d{0,1})?')),
      radius: AppRadius.small,
    );

    _precoProdutoForm = AppCurrencyFormField(
      context: context,
      width: 300,
      hint: 'Preço do produto (R\$)',
      radius: AppRadius.small,
      icon: const Icon(Icons.price_change),
    );

    _editar();

    super.initState();
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _descricaoProdutoForm.formulario,
          _tipoProdutoForm.dropdown,
          _pesoProdutoForm.formulario,
          _precoProdutoForm.formulario,
          appSizedBox(height: AppSpacing.normal),
          SizedBox(
            width: 300,
            child: CheckboxListTile(
              activeColor: MiliColors.primary,
              title: appText("Desconto (10%)"),
              value: widget.model.desconto ?? false,
              onChanged: (value) => setState(() => widget.model.desconto = value),
            ),
          ),
          appSizedBox(height: AppSpacing.normal),
          appElevatedButtonText(
            "Cadastrar".toUpperCase(),
            function: () => _save(),
            width: 300,
            color: MiliColors.primary,
            textColor: AppColors.white,
            borderRadius: AppRadius.small,
          ),
        ],
      ),
    );
  }

  Widget _bodyBuilder() {
    return _body();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: _bodyBuilder(),
    );
  }
}
