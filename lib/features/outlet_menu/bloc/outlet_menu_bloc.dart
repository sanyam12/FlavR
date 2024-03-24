import 'dart:developer';

import 'package:flavr/core/repository/core_cart_repository.dart';
import 'package:flavr/features/outlet_menu/data/models/ProductVariantData.dart';
import 'package:flavr/pages/profile_page/OrderData.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../cart/data/models/Cart.dart';
import '../data/models/Categories.dart';
import '../data/models/Product.dart';
import '../data/repository/outlet_menu_repository.dart';

part 'outlet_menu_event.dart';

part 'outlet_menu_filters.dart';

part 'outlet_menu_state.dart';

class OutletMenuBloc extends Bloc<OutletMenuEvent, OutletMenuState> {
  final OutletMenuRepository _repository;
  final CoreCartRepository _coreCartRepository;

  OutletMenuBloc(this._repository, this._coreCartRepository)
      : super(OutletMenuInitial()) {
    on<RefreshMenuEvent>(_refreshMenu);
    on<IncrementAmount>(_incrementAmount);
    on<DecrementAmount>(_decrementAmount);
    on<OutletListClicked>(_outletListClicked);
    on<UpdateCart>(_onUpdateCart);
    on<SearchQueryEvent>(_onSearchEvent);
    on<OnVegClicked>(_onVegClicked);
    on<OnNonVegClicked>(_onNonVegClicked);
    on<UpdateAmount>(_onUpdateAmount);
  }

  _onNonVegClicked(
    OnNonVegClicked event,
    Emitter<OutletMenuState> emit,
  ) {
    String newVegSelection = "non-veg";
    if (event.vegSelection == "non-veg") {
      newVegSelection = "normal";
    }

    emit(
      NonVegFilterTriggered(
        _filter(
          event.menuList,
          newVegSelection,
          event.query,
        ),
        newVegSelection,
      ),
    );
  }

  _onVegClicked(
    OnVegClicked event,
    Emitter<OutletMenuState> emit,
  ) {
    String newVegSelection = "veg";
    if (event.vegSelection == "veg") {
      newVegSelection = "normal";
    }

    emit(
      VegFilterTriggered(
        _filter(
          event.menuList,
          newVegSelection,
          event.query,
        ),
        newVegSelection,
      ),
    );
  }

  _onSearchEvent(
    SearchQueryEvent event,
    Emitter<OutletMenuState> emit,
  ) {
    try {
      emit(
        SearchResultState(
          _filter(
            event.categoriesList,
            event.vegSelection,
            event.query,
          ),
        ),
      );
    } catch (e) {
      emit(ShowSnackBar(e.toString()));
      emit(PostShowSnackBar());
    }
  }

  _onUpdateCart(
    UpdateCart event,
    Emitter<OutletMenuState> emit,
  ) {
    emit(FetchCart());
  }

  _incrementAmount(
    IncrementAmount event,
    Emitter<OutletMenuState> emit,
  ) async {
    try {
      final newCart = await _coreCartRepository.incrementAmount(
        event.cart,
        event.product,
        event.variantData,
      );
      emit(UpdatedCartState(newCart));
    } catch (e) {
      emit(ShowSnackBar(e.toString()));
      emit(PostShowSnackBar());
    }
  }

  _onUpdateAmount(
      UpdateAmount event,
      Emitter<OutletMenuState> emit,
  )async {
    try{
      final newCart = await _coreCartRepository.updateQuantity(
        event.cart,
        event.product,
        event.variantData,
        event.newAmount,
      );
      emit(UpdatedCartState(newCart));
    } catch(e){
      log("here is the error");
      emit(ShowSnackBar(e.toString()));
      emit(PostShowSnackBar());

    }
  }

  _decrementAmount(
    DecrementAmount event,
    Emitter<OutletMenuState> emit,
  ) async {
    try {
      final newCart = await _coreCartRepository.decrementAmount(
        event.cart,
        event.product,
        event.variantData,
      );
      emit(UpdatedCartState(newCart));
    } catch (e) {
      emit(ShowSnackBar(e.toString()));
      emit(PostShowSnackBar());
    }
  }

  _refreshMenu(
    RefreshMenuEvent event,
    Emitter<OutletMenuState> emit,
  ) async {
    emit(OutletMenuLoading());
    final token = await _coreCartRepository.getToken();
    final outlet = await _repository.getOutlet(token);
    final menu = await _repository.getOutletMenu(outlet.id);
    final cart = await _repository.getCart(token, menu, outlet.id);
    final incompleteOrders = await _repository.getIncompleteOrders(token);
    emit(RefreshedOutletData(
      outlet.outletName,
      menu,
      cart,
      incompleteOrders,
    ));
  }

  _outletListClicked(
    OutletListClicked event,
    Emitter<OutletMenuState> emit,
  ) {
    emit(OutletMenuLoading());
    emit(NavigateToOutletList());
  }
}
