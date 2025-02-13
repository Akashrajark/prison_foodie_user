import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/web.dart';
import 'package:prison_foodie_user/theme/app_theme.dart';

import '../../common_widget/custom_alert_dialog.dart';
import '../home/menu_item_card.dart';
import '../home/menus_bloc/menus_bloc.dart';

class CatogeyScreen extends StatefulWidget {
  final int categoryid;
  const CatogeyScreen({super.key, required this.categoryid});

  @override
  State<CatogeyScreen> createState() => _CatogeyScreenState();
}

class _CatogeyScreenState extends State<CatogeyScreen> {
  final MenusBloc _menuItemsBloc = MenusBloc();

  Map<String, dynamic> params = {
    'query': null,
    'category_id': null,
  };

  List<Map> _menus = [];

  @override
  void initState() {
    params['category_id'] = widget.categoryid;
    getMenus();
    super.initState();
  }

  void getMenus() {
    _menuItemsBloc.add(GetAllMenusEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Catogery type',
          style: GoogleFonts.poppins(
            color: onTertiaryColor,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: BlocProvider.value(
        value: _menuItemsBloc,
        child: BlocConsumer<MenusBloc, MenusState>(
          listener: (context, state) {
            if (state is MenusFailureState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Failure',
                  description: state.message,
                  primaryButton: 'Try Again',
                  onPrimaryPressed: () {
                    getMenus();
                    Navigator.pop(context);
                  },
                ),
              );
            } else if (state is MenusGetSuccessState) {
              _menus = state.menus;

              Logger().w(_menus);

              setState(() {});
            } else if (state is MenusSuccessState) {
              getMenus();
            }
          },
          builder: (context, state) {
            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: .7,
              ),
              itemBuilder: (context, index) => MenuItemCard(
                menuDetails: _menus[index],
              ),
              itemCount: _menus.length,
            );
          },
        ),
      ),
    );
  }
}
