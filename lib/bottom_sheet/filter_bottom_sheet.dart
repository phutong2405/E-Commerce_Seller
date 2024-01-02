import 'dart:async';

import 'package:ecom_seller_1512/bloc/app_bloc.dart';
import 'package:ecom_seller_1512/detail_list.dart';
import 'package:ecom_seller_1512/model/product_model.dart';
import 'package:ecom_seller_1512/widgets/stuff_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future filterBottomSheet(BuildContext context, AppBloc appBloc,
    StreamController<Product> controller, bool showingFilter) {
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
                heightFactor: 0.5,
                widthFactor: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Text(
                                "Filters",
                                style: GoogleFonts.comfortaa(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 100,
                                child: genericTextButton(
                                    icon: CupertinoIcons.checkmark_alt,
                                    bgcolor: Colors.green,
                                    colorTapped: Colors.grey,
                                    text: "Done",
                                    sized: 40,
                                    func: () {},
                                    context: context),
                              ),
                            ],
                          ),
                        ),
                        !showingFilter
                            ? customToggle(
                                toggleTitle: "Filter by",
                                listTextWidget: toggleFiltersNameList,
                                toggleList: toggleFiltersBoolList,
                                appBloc: appBloc,
                              )
                            : const SizedBox(),
                        customToggle(
                          toggleTitle: "Sort by",
                          listTextWidget: toggleSortNameList,
                          toggleList: toggleSortBoolList,
                          appBloc: appBloc,
                        ),
                        customToggle(
                          toggleTitle: "Order by",
                          listTextWidget: toggleOrderNameList,
                          toggleList: toggleOrderBoolList,
                          appBloc: appBloc,
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

const List<Widget> toggleFiltersNameList = <Widget>[
  Text('Category'),
  Text('Brands'),
  Text('Users'),
];

const List<bool> toggleFiltersBoolList = [
  true,
  false,
  false,
];

const List<Widget> toggleSortNameList = <Widget>[
  Text('Name'),
  Text('Date'),
  Text('Status'),
];

const List<bool> toggleSortBoolList = [
  true,
  false,
  false,
];

const List<Widget> toggleOrderNameList = <Widget>[
  Text('Ascending'),
  Text('Descending'),
];

const List<bool> toggleOrderBoolList = [
  true,
  false,
];

Widget customToggle(
    {required List<Widget> listTextWidget,
    required List<bool> toggleList,
    required String toggleTitle,
    required AppBloc appBloc}) {
  return Padding(
    padding: const EdgeInsets.only(top: 15.0),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        toggleTitle,
        style: GoogleFonts.hind(
          fontSize: 16,
        ),
      ),
      divineSpace(height: 10),
      ToggleButtons(
        onPressed: (int index) {
          for (int i = 0; i < toggleList.length; i++) {
            toggleList[i] = i == index;
          }
          if (toggleList[0] == true) {
          } else {}
        },
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        selectedColor: Colors.white,
        fillColor: Colors.blue,
        color: Colors.grey.shade500,
        textStyle: GoogleFonts.hind(
          fontSize: 17,
        ),
        constraints: const BoxConstraints(
          minHeight: 50.0,
          minWidth: 100.0,
        ),
        isSelected: toggleList,
        children: listTextWidget,
      ),
    ]),
  );
}
