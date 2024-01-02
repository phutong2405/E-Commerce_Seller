import 'package:ecom_seller_1512/bloc/app_bloc.dart';
import 'package:ecom_seller_1512/bloc/app_bloc_event.dart';
import 'package:ecom_seller_1512/bottom_sheet/addingProduct_bottom_sheet/adding_product_bSheet.dart';
import 'package:ecom_seller_1512/home_page.dart';
import 'package:ecom_seller_1512/model/dummy_data.dart';
import 'package:ecom_seller_1512/model/product_model.dart';
import 'package:ecom_seller_1512/repo/data_handler.dart';
import 'package:ecom_seller_1512/widgets/stuff_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardDetail extends StatelessWidget {
  final AppBloc appBloc;
  final List<Product> data;
  final String title;
  final DashboardType dashboardType;
  final TypeName typeSub;
  const DashboardDetail({
    super.key,
    required this.data,
    required this.appBloc,
    required this.title,
    required this.dashboardType,
    required this.typeSub,
  });

  int getNumberDetail(
      {required DashboardType dashboardType, required int index}) {
    switch (dashboardType) {
      case DashboardType.remains:
        return appBloc.dataInBlocFiltered[filters[index]]!.fold(
          0,
          (previousValue, element) =>
              int.tryParse(element.stock)! + previousValue,
        );

      case DashboardType.outOfStock:
      case DashboardType.orders:
        return appBloc.dataInBlocFiltered[filters[index]]!.length;

      case DashboardType.revenue:
        return appBloc.dataInBlocFiltered[filters[index]]!.fold(
          0,
          (previousValue, element) =>
              int.tryParse(element.sellingPrice)! + previousValue,
        );
      default:
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...dashboardDetailAppbar(
              context: context,
              title: title,
              hasSubtitle:
                  titleWithSub(dashboardType: dashboardType, typeSub: typeSub),
              inDetailList: false,
              numbers: appBloc.dataInBlocTypedCounting[dashboardType]!,
              appBloc: appBloc,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  return sellerStatus(
                    color: Colors.grey,
                    context: context,
                    kind: filters[index],
                    func: () {
                      appBloc.add(
                        FilterDataTappedEvent(
                          appBloc.dataInBlocFiltered[filters[index]]!,
                          filters[index],
                          getNumberDetail(
                            dashboardType: dashboardType,
                            index: index,
                          ),
                          dashboardType,
                        ),
                      );
                    },
                    numbers: getNumberDetail(
                      dashboardType: dashboardType,
                      index: index,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> dashboardDetailAppbar({
  required BuildContext context,
  required String title,
  Widget? hasSubtitle,
  required int numbers,
  required bool inDetailList,
  required AppBloc appBloc,
}) {
  return [
    divineSpace(height: 50),
    Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.arrow_left),
        ),
        inDetailList
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                icon: const Icon(
                  Icons.keyboard_double_arrow_left,
                  color: Colors.grey,
                  size: 30,
                ),
              )
            : const SizedBox(),
        const Spacer(),
        IconButton(
          onPressed: () {
            if (!inDetailList) {
              appBloc.add(
                const ControlProductTappedEvent(
                  BottomSheetType.sorting,
                ),
              );
            } else {
              appBloc.add(
                const ControlProductTappedEvent(
                  BottomSheetType.filter,
                ),
              );
            }
          },
          icon: const Icon(CupertinoIcons.slider_horizontal_3),
        ),
        IconButton(
          onPressed: () {
            appBloc.add(const SearchingEvent());
          },
          icon: const Icon(CupertinoIcons.search),
        ),
      ],
    ),
    Row(
      children: [
        divineSpace(width: 15),
        hasSubtitle ??
            Text(
              title,
              style: GoogleFonts.comfortaa(
                  fontSize: 22, fontWeight: FontWeight.w500),
            ),
        // divineSpace(width: 20),
        const Spacer(),
        Text(
          numbers.toString(),
          style: GoogleFonts.comfortaa(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        divineSpace(width: 60),
      ],
    ),
    divineLine(
      colors: [Colors.grey, Colors.grey],
      space: 0,
      spaceTop: 0,
      size: 0.1,
      start: Alignment.centerLeft,
    ),
  ];
}
