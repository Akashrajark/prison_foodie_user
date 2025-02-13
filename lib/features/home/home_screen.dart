import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/web.dart';
import '../../common_widget/custom_alert_dialog.dart';
import '../../theme/app_theme.dart';
import '../../util/check_login.dart';
import '../catogery/catogery_card.dart';
import '../catogery/catogey_screen.dart';
import 'menu_item_card.dart';
import 'menus_bloc/menus_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MenusBloc _menuItemsBloc = MenusBloc();

  Map<String, dynamic> params = {
    'query': null,
    'category_id': null,
  };

  List<Map> _menus = [], _categorie = [];

  @override
  void initState() {
    checkLogin(context);
    getMenus();
    super.initState();
  }

  void getMenus() {
    _menuItemsBloc.add(GetAllMenusEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
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
            _categorie = state.categories;
            Logger().w(_menus);
            Logger().w(_categorie);
            setState(() {});
          } else if (state is MenusSuccessState) {
            getMenus();
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 5,
                ),
                child: Text(
                  'Categories',
                  style: GoogleFonts.poppins(
                    color: onTertiaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              if (state is MenusLoadingState)
                Center(
                  child: CircularProgressIndicator(),
                ),
              if (state is MenusGetSuccessState && _menus.isEmpty)
                Center(
                  child: Text(
                    'No Category Found!',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.black),
                  ),
                ),
              if (state is MenusGetSuccessState && _menus.isNotEmpty)
                SizedBox(
                  height: 160,
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => CatogeryCard(
                      label: _categorie[index]['name'],
                      image: _categorie[index]['image_url'],
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CatogeyScreen(
                                categoryid: _categorie[index]['id'],
                              ),
                            ));
                      },
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                    itemCount: _categorie.length,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, top: 20, bottom: 10, right: 16),
                child: Text(
                  'Today’s Menu',
                  style: GoogleFonts.poppins(
                    color: onTertiaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              if (state is MenusLoadingState)
                Center(
                  child: CircularProgressIndicator(),
                ),
              if (state is MenusGetSuccessState && _menus.isEmpty)
                Center(
                  child: Text(
                    'No Menu Found!',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.black),
                  ),
                ),
              if (state is MenusGetSuccessState && _menus.isNotEmpty)
                Expanded(
                  child: GridView.builder(
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
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
