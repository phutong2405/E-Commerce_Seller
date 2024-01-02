import 'dart:async';

import 'package:ecom_seller_1512/bloc/app_bloc.dart';
import 'package:ecom_seller_1512/detail_list.dart';
import 'package:ecom_seller_1512/model/product_model.dart';
import 'package:ecom_seller_1512/widgets/stuff_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future informationBottomSheet(BuildContext context, AppBloc appBloc,
    StreamController<Product> controller) {
  return showModalBottomSheet(
    enableDrag: true,
    showDragHandle: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35), topRight: Radius.circular(35))),
    context: context,
    builder: (context) {
      final TextEditingController textEditingController =
          TextEditingController();
      return StreamBuilder<Product>(
          stream: controller.stream,
          builder: (context, snapshot) {
            // if (snapshot.hasData) {
            return Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: FractionallySizedBox(
                heightFactor: 0.95,
                widthFactor: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Approval",
                                style: GoogleFonts.comfortaa(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 120,
                                child: genericTextButton(
                                    icon: CupertinoIcons.cube_box_fill,
                                    bgcolor: Colors.green,
                                    colorTapped: Colors.grey,
                                    text: "Confirm",
                                    sized: 40,
                                    func: () {},
                                    context: context),
                              ),
                            ],
                          ),
                        ),
                        divineSpace(height: 20),
                        Text(
                          "Delivered at 26/07/2023",
                          style: GoogleFonts.hind(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
            // } else {
            //   return Container();
            // }
          });
    },
  );
}
