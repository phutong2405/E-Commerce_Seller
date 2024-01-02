import 'package:ecom_seller_1512/bottom_sheet/addingProduct_bottom_sheet/adding_product_bSheet.dart';
import 'package:ecom_seller_1512/model/product_model.dart';
import 'package:ecom_seller_1512/repo/data_handler.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AppState {
  const AppState();
}

class MainActionState implements AppState {
  const MainActionState();
}

class InitialState implements AppState {
  const InitialState();
}

class LoadingState implements AppState {
  const LoadingState();
}

class LoadedState implements AppState {
  final Iterable<Product> data;

  const LoadedState({required this.data});
}

class ErrorState implements AppState {
  const ErrorState();
}

class OutState implements MainActionState {
  const OutState();
}

class TapToItemState implements MainActionState {
  final Product product;
  final bool isFavorited;
  final bool isSaved;
  const TapToItemState({
    required this.isFavorited,
    required this.isSaved,
    required this.product,
  });
}

class DashboardDetailTappedState implements MainActionState {
  final List<Product> data;
  final DashboardType dashboardType;
  final TypeName typeSub;
  const DashboardDetailTappedState({
    required this.data,
    required this.dashboardType,
    required this.typeSub,
  });
}

class FilterDataTappedState implements MainActionState {
  final String title;
  final int number;
  final DashboardType dashboardType;
  final List<Product> data;
  const FilterDataTappedState(
      this.data, this.title, this.number, this.dashboardType);
}

class ControlProductTappedState implements MainActionState {
  final BottomSheetType bottomSheetType;
  const ControlProductTappedState(this.bottomSheetType);
}

class SearchingState implements MainActionState {
  const SearchingState();
}

// class LoginState implements MainActionState {
//   const LoginState();
// }

// class LoggedState implements MainActionState {
//   final bool isLogged;
//   const LoggedState({required this.isLogged});
// }
