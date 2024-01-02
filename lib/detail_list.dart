import 'package:ecom_seller_1512/bloc/app_bloc.dart';
import 'package:ecom_seller_1512/bloc/app_bloc_event.dart';
import 'package:ecom_seller_1512/bottom_sheet/addingProduct_bottom_sheet/adding_product_bSheet.dart';
import 'package:ecom_seller_1512/dashboard_detail.dart';
import 'package:ecom_seller_1512/model/product_model.dart';
import 'package:ecom_seller_1512/repo/data_handler.dart';
import 'package:ecom_seller_1512/widgets/stuff_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailList extends StatelessWidget {
  final AppBloc appBloc;
  final String title;
  final int number;
  final DashboardType dashboardType;
  final List<Product> data;
  const DetailList({
    super.key,
    required this.appBloc,
    required this.data,
    required this.title,
    required this.number,
    required this.dashboardType,
  });

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
              numbers: number,
              inDetailList: true,
              appBloc: appBloc,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return itemTile(
                    context: context,
                    product: data[index],
                    dashboardType: dashboardType,
                    func: () {
                      if (dashboardType == DashboardType.orders) {
                        appBloc.add(const ControlProductTappedEvent(
                          BottomSheetType.approve,
                        ));
                      } else {
                        appBloc.add(const ControlProductTappedEvent(
                          BottomSheetType.adjust,
                        ));
                      }
                    },
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

Widget itemTile({
  required BuildContext context,
  required Product product,
  required DashboardType dashboardType,
  required Function() func,
}) {
  Widget trailingButton({
    required DashboardType dashboardType,
    required Function() func,
  }) {
    switch (dashboardType) {
      case DashboardType.orders:
        return genericTextButton(
          context: context,
          icon: CupertinoIcons.cube_box,
          bgcolor: Colors.green.withOpacity(0.9),
          colorTapped: Colors.grey,
          sized: 50,
          func: () {
            func();
          },
        );
      default:
        return genericTextButton(
          context: context,
          icon: CupertinoIcons.ellipsis,
          bgcolor: Colors.blueGrey,
          colorTapped: Colors.grey,
          sized: 50,
          func: () {
            func();
          },
        );
    }
  }

  Widget subtitle({
    required DashboardType dashboardType,
    required Product product,
  }) {
    switch (dashboardType) {
      case DashboardType.remains:
        return Text(product.stock);
      case DashboardType.revenue:
        return Text("${product.sellingPrice} \$");

      default:
        return Text(product.seller);
    }
  }

  return Padding(
    padding: const EdgeInsets.only(
      top: 8.0,
    ),
    child: ListTile(
      onTap: () {},
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
                image: NetworkImage(product.url), fit: BoxFit.cover)),
      ),
      title: Text(product.title),
      subtitle: subtitle(dashboardType: dashboardType, product: product),
      trailing: trailingButton(
        dashboardType: dashboardType,
        func: () {
          func();
        },
      ),
    ),
  );
}

Widget genericTextButton(
    {required IconData icon,
    required Color bgcolor,
    required Color colorTapped,
    required double sized,
    required Function() func,
    String? text,
    required BuildContext context}) {
  return Container(
    alignment: Alignment.center,
    height: sized,
    width: sized,
    child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateColor.resolveWith((states) => colorTapped),
          backgroundColor: MaterialStatePropertyAll(bgcolor),
          shape: const MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
        ),
        onPressed: () {
          func();
        },
        child: text == null
            ? Icon(
                icon,
                color: Colors.white,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: GoogleFonts.hind(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  divineSpace(width: 5),
                  Icon(
                    icon,
                    color: Colors.white,
                  )
                ],
              )),
  );
}
