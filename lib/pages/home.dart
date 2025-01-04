import 'package:app_milli/app_config/const/app_colors.dart';
import 'package:app_milli/pages/produto_listagem_page.dart';
import 'package:flutter/material.dart';
import 'package:muller_package/muller_package.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int index = 0;

  Widget _image() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        "assets/images/mili_fabrica.png",
        fit: BoxFit.cover,
      ),
    );
  }

  List<Widget> _telas = [];

  @override
  void initState() {

    _telas = [
      _image(),
      const ProdutoListagemPage(),
    ];

    super.initState();
  }

  Widget _menu({
    required String title,
    required IconData icon,
    required int indexMenu,
  }) {

    bool hover = false;

    return StatefulBuilder(
      builder: (context, setStateBuilder) {
        return MouseRegion(
          onEnter: (event) => setStateBuilder(() => hover = true),
          onExit: (event) => setStateBuilder(() => hover = false),
          child: GestureDetector(
            onTap: () => setState(() => index = indexMenu),
            child: appContainer(
              margin: const EdgeInsets.only(top: 1),
              backgroundColor: index != indexMenu ? hover ? MiliColors.primaryDarker : MiliColors.primary : MiliColors.primaryDarker,
              child: Row(
                children: [
                  appContainer(
                    height: 30,
                    width: 5,
                    backgroundColor: index != indexMenu ? hover ? MiliColors.secondary : AppColors.transparent: AppColors.white,
                  ),
                  Expanded(
                    child: ListTile(
                      dense: true,
                      leading: Icon(
                        icon,
                        color: Colors.white,
                        size: 20,
                      ),
                      title: appText(
                        title.toUpperCase(),
                        color: Colors.white,
                        letterSpacing: 1,
                        bold: index == indexMenu,
                        fontSize: 12.5,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _row() {
    return Row(
      children: [
        appContainer(
          width: 280,
          height: MediaQuery.of(context).size.height,
          backgroundColor: MiliColors.primary,
          child: Column(
            children: [
              appSizedBox(height: 40),
              Image.asset("assets/images/logo.png", height: 80),
              appSizedBox(height: 40),
              _menu(title: "Inicio", icon: Icons.home, indexMenu: 0),
              _menu(title: "Produtos", icon: Icons.shopping_cart, indexMenu: 1),
            ],
          ),
        ),
        Expanded(child: _telas[index]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      title: 'Home Page',
      showAppBar: false,
      appBarColor: MiliColors.primaryDarker,
      background: AppColors.grey200,
      body: _row(),
    );
  }
}
