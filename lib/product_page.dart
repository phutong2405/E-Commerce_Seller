import 'package:ecom_seller_1512/bloc/app_bloc.dart';
import 'package:ecom_seller_1512/bloc/app_bloc_event.dart';
import 'package:ecom_seller_1512/bottom_sheet/addingProduct_bottom_sheet/adding_product_bSheet.dart';
import 'package:ecom_seller_1512/detail_list.dart';
import 'package:ecom_seller_1512/home_page.dart';
import 'package:ecom_seller_1512/model/dummy_data.dart';
import 'package:ecom_seller_1512/repo/data_handler.dart';
import 'package:ecom_seller_1512/widgets/stuff_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductPage extends StatefulWidget {
  final AppBloc appBloc;
  const ProductPage({super.key, required this.appBloc});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...centerPageAppbar(context: context, appBloc: widget.appBloc),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: filters.length,
              itemBuilder: (context, index) {
                return sellerStatus(
                  color: Colors.grey,
                  context: context,
                  kind: filters[index],
                  func: () {
                    widget.appBloc.add(FilterDataTappedEvent(
                        widget.appBloc.dataInBlocFiltered[filters[index]]!,
                        "Storage",
                        widget
                            .appBloc.dataInBlocFiltered[filters[index]]!.length,
                        DashboardType.remains));
                  },
                  numbers:
                      widget.appBloc.dataInBlocFiltered[filters[index]]!.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> centerPageAppbar({
  required BuildContext context,
  required AppBloc appBloc,
}) {
  return [
    divineSpace(height: 50),
    Row(
      children: [
        divineSpace(width: 10),
        Text(
          "Logz Seller",
          style: GoogleFonts.spaceGrotesk(
            fontSize: 26,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            appBloc
                .add(const ControlProductTappedEvent(BottomSheetType.filter));
          },
          icon: const Icon(CupertinoIcons.slider_horizontal_3),
        ),
        IconButton(
          onPressed: () {
            appBloc.add(
              const SearchingEvent(),
            );
          },
          icon: const Icon(CupertinoIcons.search),
        ),
      ],
    ),
    Row(
      children: [
        Text(
          " Control Center",
          style: GoogleFonts.comfortaa(
            fontSize: 26,
            fontWeight: FontWeight.w500,
            color: Colors.blue,
          ),
        ),
        const Spacer(),
        genericTextButton(
            icon: CupertinoIcons.cube_box_fill,
            bgcolor: Colors.green,
            colorTapped: Colors.blueGrey,
            sized: 50,
            func: () {
              if (appBloc.dataInBlocFiltered[DashboardType.orders] != null) {
                appBloc.add(
                  DashboardDetailTappedEvent(
                    appBloc.dataInBlocFiltered[DashboardType.orders]!,
                    DashboardType.orders,
                    TypeName.product,
                  ),
                );
              } else {
                appBloc.add(
                  const DashboardDetailTappedEvent(
                    [],
                    DashboardType.orders,
                    TypeName.product,
                  ),
                );
              }
            },
            context: context),
        divineSpace(width: 8),
        genericTextButton(
            icon: CupertinoIcons.add,
            bgcolor: Colors.blue,
            colorTapped: Colors.blueGrey,
            sized: 50,
            func: () {
              appBloc.add(
                const ControlProductTappedEvent(
                  BottomSheetType.adding,
                ),
              );
            },
            context: context),
        divineSpace(width: 5),
      ],
    ),
    divineLine(
      colors: [Colors.grey, Colors.grey],
      space: 0,
      spaceTop: 5,
      size: 0.1,
      start: Alignment.centerLeft,
    ),
  ];
}
