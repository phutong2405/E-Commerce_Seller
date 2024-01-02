import 'package:ecom_seller_1512/bloc/app_bloc.dart';
import 'package:ecom_seller_1512/bottom_sheet/addingProduct_bottom_sheet/adding_product_bSheet.dart';
import 'package:ecom_seller_1512/model/product_model.dart';
import 'package:ecom_seller_1512/repo/data_handler.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AppEvent {
  const AppEvent();
}

class InitialEvent implements AppEvent {
  const InitialEvent();
}

class TapToItemEvent implements AppEvent {
  final Product product;

  const TapToItemEvent({
    required this.product,
  });
}

class FilterTappedEvent implements AppEvent {
  final String filterName;
  const FilterTappedEvent({
    required this.filterName,
  });
}

class LoadMoreProductsEvent implements AppEvent {
  final int lengthToSkip;
  final String filterName;

  const LoadMoreProductsEvent(
      {required this.lengthToSkip, required this.filterName});
}

class RefreshPageEvent implements AppEvent {
  const RefreshPageEvent();
}

class DashboardDetailTappedEvent implements AppEvent {
  final List<Product> data;
  final DashboardType dashboardType;
  final TypeName typeSub;
  const DashboardDetailTappedEvent(this.data, this.dashboardType, this.typeSub);
}

class FilterDataTappedEvent implements AppEvent {
  final String title;
  final int number;
  final DashboardType dashboardType;
  final List<Product> data;
  const FilterDataTappedEvent(
      this.data, this.title, this.number, this.dashboardType);
}

class ControlProductTappedEvent implements AppEvent {
  final BottomSheetType bottomSheetType;

  const ControlProductTappedEvent(this.bottomSheetType);
}

class SearchingEvent implements AppEvent {
  const SearchingEvent();
}


// class TranslateTappedEvent implements AppEvent {
//   const TranslateTappedEvent();
// }

// class SettingsTappedEvent implements AppEvent {
//   const SettingsTappedEvent();
// }

// class ChatTappedEvent implements AppEvent {
//   const ChatTappedEvent();
// }

// @immutable
// abstract class DetailItemEvent implements AppEvent {
//   const DetailItemEvent();
// }

// class FavoriteButtonTappedEvent implements DetailItemEvent {
//   final ModalType type;
//   final DictionaryEntry entry;
//   const FavoriteButtonTappedEvent({
//     required this.entry,
//     required this.type,
//   });
// }

// class CopyButtonTappedEvent implements DetailItemEvent {
//   final DictionaryEntry entry;
//   const CopyButtonTappedEvent({
//     required this.entry,
//   });
// }

// class ShareButtonTappedEvent implements DetailItemEvent {
//   final DictionaryEntry entry;
//   const ShareButtonTappedEvent({
//     required this.entry,
//   });
// }

// class AskButtonTappedEvent implements DetailItemEvent {
//   final DictionaryEntry entry;
//   const AskButtonTappedEvent({
//     required this.entry,
//   });
// }

// class DeleteAllEvent implements DetailItemEvent {
//   const DeleteAllEvent();
// }

// enum SwitchType { darkMode, simpleMode, autoLookup, languages }

// class SettingsChangesEvent implements AppEvent {
//   final dynamic data;
//   final SwitchType type;
//   const SettingsChangesEvent({required this.type, required this.data});
// }

// class LanguageChoicesChangesEvent implements AppEvent {
//   final String id;
//   LanguageChoicesChangesEvent({required this.id});
// }

// class SearchingEvent implements AppEvent {
//   final String value;
//   const SearchingEvent({required this.value});
// }

// class LogInEvent implements AppEvent {
//   const LogInEvent();
// }

// class LogInButtonEvent implements AppEvent {
//   final String email;
//   final String password;
//   const LogInButtonEvent({required this.email, required this.password});
// }
