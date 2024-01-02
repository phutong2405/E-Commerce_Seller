import 'dart:async';
import 'package:ecom_seller_1512/bloc/app_bloc.dart';
import 'package:ecom_seller_1512/detail_list.dart';
import 'package:ecom_seller_1512/model/product_model.dart';
import 'package:ecom_seller_1512/widgets/stuff_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future detailModalBottom(BuildContext context, AppBloc appBloc,
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
                heightFactor: 0.93,
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
                                "Adding Product",
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
                                    icon: CupertinoIcons.add,
                                    bgcolor: Colors.blue,
                                    colorTapped: Colors.grey,
                                    text: "Add",
                                    sized: 40,
                                    func: () {},
                                    context: context),
                              ),
                            ],
                          ),
                        ),
                        divineSpace(height: 10),
                        inputTextField(
                            textController: textEditingController,
                            hintText: "title"),
                        inputTextField(
                            textController: textEditingController,
                            hintText: "description"),
                        inputTextField(
                            textController: textEditingController,
                            hintText: "brand"),
                        inputTextField(
                            textController: textEditingController,
                            hintText: "seller"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              child: inputTextField(
                                  textController: textEditingController,
                                  hintText: "price"),
                            ),
                            SizedBox(
                              width: 150,
                              child: inputTextField(
                                  textController: textEditingController,
                                  hintText: "amount"),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              child: inputTextField(
                                  textController: textEditingController,
                                  hintText: "% off"),
                            ),
                            SizedBox(
                              width: 150,
                              child: inputTextField(
                                  textController: textEditingController,
                                  hintText: "code"),
                            ),
                          ],
                        ),
                        divineSpace(height: 20),
                        SizedBox(
                          width: 150,
                          child: genericTextButton(
                              icon: CupertinoIcons.photo_fill_on_rectangle_fill,
                              bgcolor: Colors.blueGrey,
                              colorTapped: Colors.grey,
                              text: "Add Photos",
                              sized: 40,
                              func: () {},
                              context: context),
                        ),
                        divineSpace(
                            height:
                                MediaQuery.of(context).viewInsets.bottom + 30),
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

Widget textFieldTitle({required String title, double? size}) {
  return Text(
    title,
    style: TextStyle(
        fontWeight: FontWeight.w400, color: Colors.grey, fontSize: size ?? 18),
  );
}

Widget inputTextField({
  required TextEditingController textController,
  required String hintText,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
        // controller: textController,
        textAlignVertical: TextAlignVertical.center,
        maxLines: null,
        maxLength: 500,
        decoration: InputDecoration(
          counterText: "",
          isDense: true,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.blueGrey),
          // prefixIcon: IconButton(
          //     onPressed: () {
          //       // textController.clear();
          //     },
          //     icon: const Icon(
          //       Icons.account_circle,
          //       size: 22,
          //       color: Colors.grey,
          //     )),
          suffixIcon: IconButton(
              splashColor: Colors.grey,
              onPressed: () {
                textController.clear();
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.grey,
                size: 18,
              )),
          fillColor: Colors.white,
          iconColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
        ),
        onChanged: (value) {
          // textController.text = value;
        }),
  );
}
