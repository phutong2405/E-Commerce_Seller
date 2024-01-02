import 'package:ecom_seller_1512/bloc/app_bloc.dart';
import 'package:ecom_seller_1512/bloc/app_bloc_event.dart';
import 'package:ecom_seller_1512/bloc/app_bloc_state.dart';
import 'package:ecom_seller_1512/bottom_sheet/addingProduct_bottom_sheet/adding_product_bSheet.dart';
import 'package:ecom_seller_1512/dashboard_detail.dart';
import 'package:ecom_seller_1512/detail_list.dart';
import 'package:ecom_seller_1512/home_page.dart';
import 'package:ecom_seller_1512/home_page_alt.dart';
import 'package:ecom_seller_1512/model/product_model.dart';
import 'package:ecom_seller_1512/product_page.dart';
import 'package:ecom_seller_1512/repo/data_handler.dart';
import 'package:ecom_seller_1512/search_view.dart';
import 'package:ecom_seller_1512/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late AppBloc appBloc;
  late final Iterable<Product> data;
  @override
  void initState() {
    super.initState();
    appBloc = AppBloc();
    appBloc.add(const InitialEvent());
  }

  int _selectedPage = 0;

  _changeTab(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  Widget getPage({required Iterable<Product> data, required int index}) {
    List pages = [
      // HomePageAlt(appBloc: appBloc),
      HomePage(appBloc: appBloc),
      // const DashboardDetail(),
      // DetailList(appBloc: appBloc),
      ProductPage(appBloc: appBloc),
    ];
    return pages[index];
  }

  Widget mainView({required Iterable<Product> data, required Widget body}) {
    return Scaffold(
        body: body,
        bottomNavigationBar: bottomNavigationBar(
            context: context, selectedPage: _selectedPage, func: _changeTab));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: appBloc,
      listenWhen: (previous, current) => current is MainActionState,
      buildWhen: (previous, current) => current is! MainActionState,
      listener: (context, state) {
        if (state is DashboardDetailTappedState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DashboardDetail(
                        title: "",
                        dashboardType: state.dashboardType,
                        typeSub: state.typeSub,
                        data: state.data,
                        appBloc: appBloc,
                      )));
        }
        if (state is FilterDataTappedState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailList(
                        data: state.data,
                        appBloc: appBloc,
                        title: state.title,
                        number: state.number,
                        dashboardType: state.dashboardType,
                      )));
        }
        if (state is ControlProductTappedState) {
          BottomSheetCustom.instance().hide();
          BottomSheetCustom.instance().show(
            context: context,
            appBloc: appBloc,
            bottomSheetType: state.bottomSheetType,
          );
        }

        if (state is SearchingState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchPage(appBloc: appBloc),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case LoadedState:
            state as LoadedState;
            final data = state.data;
            return mainView(
              data: data,
              body: getPage(data: data, index: _selectedPage),
            );

          case LoadingState:
            return Material(
              child: Center(
                child: Lottie.asset("lib/assets/loadingtext.json"),
              ),
            );

          case ErrorState:
            return mainView(
                data: [],
                body: const Center(
                  child: Text("ERROR"),
                ));

          default:
            return mainView(
                data: [],
                body: const Center(
                  child: Text("Errorrrr"),
                ));
        }
      },
    );
  }
}
