import 'dart:async';
import 'package:ecom_seller_1512/bloc/app_bloc.dart';
import 'package:ecom_seller_1512/bottom_sheet/addingProduct_bottom_sheet/detail_modal_bottom.dart';
import 'package:ecom_seller_1512/bottom_sheet/approve_bottom_sheet.dart';
import 'package:ecom_seller_1512/bottom_sheet/filter_bottom_sheet.dart';
import 'package:ecom_seller_1512/controllers/bottomsheet_controller.dart';
import 'package:ecom_seller_1512/model/product_model.dart';
import 'package:flutter/material.dart';

enum BottomSheetType {
  approve,
  adjust,
  adding,
  filter,
  sorting,
}

class BottomSheetCustom {
  BottomSheetCustom._sharedInstance();
  static final BottomSheetCustom _shared = BottomSheetCustom._sharedInstance();
  factory BottomSheetCustom.instance() => _shared;

  BottomSheetController? controller;

  void show({
    required BuildContext context,
    required AppBloc appBloc,
    required BottomSheetType bottomSheetType,
  }) {
    if (controller?.updateOptions(appBloc) ?? false) {
      return;
    } else {
      controller = showDetailBottomSheet(
        context: context,
        appBloc: appBloc,
        bottomSheetType: bottomSheetType,
      );
    }
  }

  void hide() {
    controller?.closeOptions();
    controller = null;
  }

  BottomSheetController showDetailBottomSheet({
    required BuildContext context,
    required AppBloc appBloc,
    required BottomSheetType bottomSheetType,
  }) {
    final entryStream = StreamController<Product>();
    // entryStream.add(entry);

    switch (bottomSheetType) {
      case BottomSheetType.adding:
        detailModalBottom(context, appBloc, entryStream);

      case BottomSheetType.filter:
        filterBottomSheet(context, appBloc, entryStream, true);

      case BottomSheetType.approve:
        approveBottomSheet(context, appBloc, entryStream);

      case BottomSheetType.sorting:
        filterBottomSheet(context, appBloc, entryStream, false);

      default:
        detailModalBottom(context, appBloc, entryStream);
    }

    return BottomSheetController(
      closeOptions: () {
        entryStream.close();
        return true;
      },
      updateOptions: (text) {
        entryStream.add(text);
        return true;
      },
    );
  }
}
