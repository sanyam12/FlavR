import 'dart:developer';
import 'package:flavr/core/repository/core_cart_repository.dart';
import 'package:flavr/features/cart/data/models/CartVariantData.dart';
import 'package:flavr/features/outlet_menu/data/models/ProductVariantData.dart';
import 'package:flavr/pages/profile_page/data/models/OrderData.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../cart/data/models/Cart.dart';
import '../../data/models/Categories.dart';
import '../../data/models/Product.dart';
import '../../data/repository/outlet_menu_repository.dart';

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
    on<AddClicked>(_onAddClicked);
    on<RemoveClicked>(_onRemoveClicked);
    on<AddToExistingCart>(_addToExistingCart);
  }

  _onRemoveClicked(
      RemoveClicked event,
      Emitter<OutletMenuState> emit,
  ) async {
    if (event.product.variantList.isEmpty) {
      final newCart = await _coreCartRepository.decrementAmount(
        event.cart,
        event.product,
        ProductVariantData(
          "default",
          event.product.price,
        ),
      );
      emit(UpdatedCartState(newCart));
    } else {
        emit(ShowCustomizationList(event.product, event.cart, false));
        emit(NeutralOutletMenu());
    }
  }

  _onAddClicked(
    AddClicked event,
    Emitter<OutletMenuState> emit,
  ) async {
    if (event.product.variantList.isEmpty) {
      final newCart = await _coreCartRepository.incrementAmount(
        event.cart,
        event.product,
        ProductVariantData(
          "default",
          event.product.price,
        ),
      );
      emit(UpdatedCartState(newCart));
    } else {
      final ordersList = event.cart.items[event.product];
      if (ordersList == null || ordersList.isEmpty) {
        emit(ShowAllVariantsList(event.product));
        emit(NeutralOutletMenu());
      } else {
        log("show customisation modal");
        emit(ShowCustomizationList(event.product, event.cart, true));
        emit(NeutralOutletMenu());
      }
    }
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
      emit(NeutralOutletMenu());
    }
  }

  _onUpdateCart(
    UpdateCart event,
    Emitter<OutletMenuState> emit,
  ) {
    emit(FetchCart());
    emit(NeutralOutletMenu());
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
      emit(NeutralOutletMenu());
    }
  }

  _onUpdateAmount(
    UpdateAmount event,
    Emitter<OutletMenuState> emit,
  ) async {
    try {
      final newCart = await _coreCartRepository.updateQuantity(
        event.cart,
        event.product,
        event.variantData,
        event.newAmount,
      );
      emit(UpdatedCartState(newCart));
    } catch (e) {
      emit(ShowSnackBar(e.toString()));
      emit(NeutralOutletMenu());
    }
  }

  _addToExistingCart(
    AddToExistingCart event,
    Emitter<OutletMenuState> emit,
  ) async {
    try {
      int count = 0;
      if (event.cart.items[event.product] != null) {
        final variant = event.cart.items[event.product]?.firstWhere(
            (element) => element.variantName == event.variantData.variantName,
            orElse: () => CartVariantData("default", 0, 0));
        if (variant != null) {
          count = variant.quantity;
        }
      }
      final newCart = await _coreCartRepository.updateQuantity(
        event.cart,
        event.product,
        event.variantData,
        event.newAmount + count,
      );
      emit(UpdatedCartState(newCart));
    } on Exception catch (e) {
      emit(ShowSnackBar(e.toString()));
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
      emit(NeutralOutletMenu());
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
    emit(NeutralOutletMenu());
  }
}
