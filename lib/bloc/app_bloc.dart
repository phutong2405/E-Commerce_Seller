import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ecom_seller_1512/bloc/app_bloc_event.dart';
import 'package:ecom_seller_1512/bloc/app_bloc_state.dart';
import 'package:ecom_seller_1512/model/product_model.dart';
import 'package:ecom_seller_1512/repo/data_handler.dart';
import 'package:ecom_seller_1512/repo/fetch_product_data.dart';
import 'package:ecom_seller_1512/repo/local_data.dart';

const String url2 = 'https://dummyjson.com/products?limit=100';
const String url = 'http://127.0.0.1:5500/lib/json/product_data.json';

class AppBloc extends Bloc<AppEvent, AppState> {
  late Iterable<Product> dataInBloc;
  late Map<String, List<Product>> dataInBlocFiltered;
  late Map<DashboardType, List<Product>> dataInBlocTyped;
  late Map<DashboardType, int> dataInBlocTypedCounting;
  late List<String> items;
  late String filterName;
  AppBloc() : super(const InitialState()) {
    on<InitialEvent>(initialEvent);

    on<DashboardDetailTappedEvent>(dashboardDetailTappedEvent);
    on<FilterDataTappedEvent>(filterDataTappedEvent);

    on<ControlProductTappedEvent>(controlProductTappedEvent);

    on<TapToItemEvent>(tapToItemEvent);

    on<SearchingEvent>(searchingEvent);

    on<LoadMoreProductsEvent>(loadMoreProductsEvent);
    on<RefreshPageEvent>(refreshPageEvent);
  }

  void initialLocalData() async {
    filterName = "everything";
    LocalData.instance().initial();
    favList =
        LocalData.instance().getData(dataType: LocalDataType.favoritedProducts);
    saveList =
        LocalData.instance().getData(dataType: LocalDataType.savedProducts);
    items = List.generate(
      3,
      (index) => '',
    );
  }

  void initialDataHandler() {
    var dataHandler = DataHandler.instance();
    dataInBlocFiltered = dataHandler.filterProduct(
      productData: dataInBloc.toList(),
    );
    dataInBlocTyped = dataHandler.typedProduct(
      productData: dataInBloc.toList(),
    );
    dataInBlocTypedCounting = dataHandler.countingTypeProduct(
      typedProductList: dataInBlocTyped,
    );
  }

  FutureOr<void> initialEvent(
      InitialEvent event, Emitter<AppState> emit) async {
    emit(const LoadingState());
    dataInBloc = await FetchProduct.instance().initialFetchProduct(url2);

    initialLocalData();
    initialDataHandler();

    print(dataInBlocTypedCounting);

    await Future.delayed(
      const Duration(seconds: 0),
      () {
        emit(LoadedState(data: dataInBloc));
      },
    );
  }

  FutureOr<void> tapToItemEvent(TapToItemEvent event, Emitter<AppState> emit) {
    bool isFavorited = favList.contains(
      event.product,
    );
    bool isSaved = saveList.contains(
      event.product,
    );
    emit(
      TapToItemState(
        product: event.product,
        isFavorited: isFavorited,
        isSaved: isSaved,
      ),
    );
    emit(const OutState());
  }

  FutureOr<void> loadMoreProductsEvent(
      LoadMoreProductsEvent event, Emitter<AppState> emit) {}

  FutureOr<void> refreshPageEvent(
      RefreshPageEvent event, Emitter<AppState> emit) {}

  FutureOr<void> dashboardDetailTappedEvent(
      DashboardDetailTappedEvent event, Emitter<AppState> emit) {
    emit(
      DashboardDetailTappedState(
        dashboardType: event.dashboardType,
        data: event.data,
        typeSub: event.typeSub,
      ),
    );
    emit(const OutState());
  }

  FutureOr<void> filterDataTappedEvent(
      FilterDataTappedEvent event, Emitter<AppState> emit) {
    emit(
      FilterDataTappedState(
        event.data,
        event.title,
        event.number,
        event.dashboardType,
      ),
    );
    emit(const OutState());
  }

  FutureOr<void> controlProductTappedEvent(
      ControlProductTappedEvent event, Emitter<AppState> emit) {
    emit(ControlProductTappedState(event.bottomSheetType));
    emit(const OutState());
  }

  FutureOr<void> searchingEvent(SearchingEvent event, Emitter<AppState> emit) {
    emit(
      const SearchingState(),
    );
    emit(const OutState());
  }
}
