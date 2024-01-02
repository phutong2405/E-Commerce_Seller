import 'package:ecom_seller_1512/bloc/app_bloc.dart';
import 'package:ecom_seller_1512/bloc/app_bloc_event.dart';
import 'package:ecom_seller_1512/home_page.dart';
import 'package:ecom_seller_1512/product_page.dart';
import 'package:ecom_seller_1512/widgets/stuff_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageAlt extends StatefulWidget {
  final AppBloc appBloc;
  const HomePageAlt({super.key, required this.appBloc});

  @override
  State<HomePageAlt> createState() => _HomePageAltState();
}

class _HomePageAltState extends State<HomePageAlt> {
  var controller = PageController(viewportFraction: 0.75, initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      scrollDirection: Axis.vertical,
      padEnds: false,
      pageSnapping: true,
      children: [
        HomePage(appBloc: widget.appBloc),
        ProductPage(appBloc: widget.appBloc),
      ],
    );
  }
}

List<Widget> dashboardAppbar({
  required BuildContext context,
  required String pageName,
  required Color color,
  required AppBloc appBloc,
}) {
  return [
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
  ];
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
          Container(
            padding: const EdgeInsets.only(left: 15, top: 10),
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: numbers.toString(),
                    style: GoogleFonts.comfortaa(
                        fontSize: 37,
                        fontWeight: FontWeight.bold,
                        color: color),
                  ),
                  TextSpan(
                    text: ' $kind',
                    style: GoogleFonts.comfortaa(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              func();
            },
            icon: const Icon(CupertinoIcons.arrow_right),
          ),
          divineSpace(width: 47),
        ],
      ),
      divineSpace(height: 10),
    ],
  );
}
