import 'package:ecom_seller_1512/bloc/app_bloc.dart';
import 'package:ecom_seller_1512/bloc/app_bloc_event.dart';
import 'package:ecom_seller_1512/repo/data_handler.dart';
import 'package:ecom_seller_1512/widgets/stuff_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final AppBloc appBloc;
  const HomePage({super.key, required this.appBloc});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dashboardAppbar(
              context: context,
              pageName: "Dashboard",
              color: Colors.green,
              appBloc: widget.appBloc),
          divineSpace(height: 20),
          typedStatus(
            color: Colors.black,
            context: context,
            dashboardType: DashboardType.remains,
            typeSub: TypeName.amount,
            func: () {
              widget.appBloc.add(
                DashboardDetailTappedEvent(
                  widget.appBloc.dataInBlocFiltered[DashboardType.remains] ??
                      [],
                  DashboardType.remains,
                  TypeName.amount,
                ),
              );
            },
            numbers:
                widget.appBloc.dataInBlocTypedCounting[DashboardType.remains]!,
          ),
          typedStatus(
            color: Colors.amber,
            context: context,
            dashboardType: DashboardType.orders,
            typeSub: TypeName.product,
            func: () {
              widget.appBloc.add(
                DashboardDetailTappedEvent(
                  widget.appBloc.dataInBlocFiltered[DashboardType.orders] ?? [],
                  DashboardType.orders,
                  TypeName.product,
                ),
              );
            },
            numbers:
                widget.appBloc.dataInBlocTypedCounting[DashboardType.orders]!,
          ),
          typedStatus(
            color: Colors.green,
            context: context,
            dashboardType: DashboardType.revenue,
            typeSub: TypeName.cash,
            func: () {
              widget.appBloc.add(
                DashboardDetailTappedEvent(
                  widget.appBloc.dataInBlocFiltered[DashboardType.revenue] ??
                      [],
                  DashboardType.revenue,
                  TypeName.cash,
                ),
              );
            },
            numbers:
                widget.appBloc.dataInBlocTypedCounting[DashboardType.revenue]!,
          ),
          typedStatus(
            color: Colors.pink,
            context: context,
            dashboardType: DashboardType.outOfStock,
            typeSub: TypeName.product,
            func: () {
              widget.appBloc.add(
                DashboardDetailTappedEvent(
                    widget.appBloc
                            .dataInBlocFiltered[DashboardType.outOfStock] ??
                        [],
                    DashboardType.outOfStock,
                    TypeName.product),
              );
            },
            numbers: widget
                .appBloc.dataInBlocTypedCounting[DashboardType.outOfStock]!,
          ),
        ],
      ),
    );
  }
}

Widget dashboardAppbar({
  required BuildContext context,
  required String pageName,
  required Color color,
  required AppBloc appBloc,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      divineSpace(height: 60),
      Row(
        children: [
          const Spacer(),
          IconButton(
              onPressed: () {
                appBloc.add(const SearchingEvent());
              },
              icon: const Icon(CupertinoIcons.search))
        ],
      ),
      divineSpace(height: 55),
      Text(
        "Logz Seller",
        style: GoogleFonts.spaceGrotesk(
          fontSize: 30,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      divineSpace(width: 10),
      Text(
        pageName,
        style: GoogleFonts.comfortaa(
            fontSize: 35, fontWeight: FontWeight.bold, color: color),
      ),
    ]),
  );
}

Widget typedStatus(
    {required BuildContext context,
    required int numbers,
    required DashboardType dashboardType,
    required TypeName typeSub,
    required Color color,
    required Function() func}) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child:
                  titleWithSub(dashboardType: dashboardType, typeSub: typeSub)),

          const Spacer(),
          Text(
            numbers.toString(),
            style: GoogleFonts.comfortaa(
                fontSize: 37, fontWeight: FontWeight.bold, color: color),
          ),
          divineSpace(width: 10),
          IconButton(
            onPressed: () {
              func();
            },
            icon: const Icon(CupertinoIcons.arrow_right),
          ),
          // divineSpace(width: 47),
        ],
      ),
      divineSpace(height: 10),
    ],
  );
}

Widget sellerStatus(
    {required BuildContext context,
    required int numbers,
    required String kind,
    required Color color,
    required Function() func}) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            ' $kind',
            style: GoogleFonts.comfortaa(
                fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Text(
            numbers.toString(),
            style: GoogleFonts.comfortaa(
                fontSize: 37, fontWeight: FontWeight.bold, color: color),
          ),
          divineSpace(width: 10),
          IconButton(
            onPressed: () {
              func();
            },
            icon: Icon(
              CupertinoIcons.arrow_right,
              color: Colors.grey.shade500,
            ),
          ),
          // divineSpace(width: 47),
        ],
      ),
      divineLine(colors: [
        Colors.transparent,
        Colors.grey,
        Colors.transparent,
      ], space: 5, size: 0.1, start: Alignment.centerLeft),
    ],
  );
}
