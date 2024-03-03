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
      // final newCart = Cart.fromParams(
      //   event.cart.outletId,
      //   event.cart.items,
      //   // event.cart.amount + event.variantData.price,
      //   // event.cart.cartTotalItems+1
      // );
      // if (newCart.items[event.product] != null) {
      //   final cartVariant = newCart.items[event.product]!.where(
      //     (element) => element.variantName == event.variantData.variantName,
      //   );
      //   if (cartVariant.isEmpty) {
      //     newCart.items[event.product]?.add(
      //       CartVariantData(
      //         event.variantData.variantName,
      //         1,
      //         event.variantData.price,
      //       ),
      //     );
      //     _updateQuantityOnServer(
      //       event.product.id,
      //       event.variantData.variantName,
      //       1,
      //     );
      //   } else {
      //     cartVariant.first.quantity++;
      //     _updateQuantityOnServer(
      //       event.product.id,
      //       event.variantData.variantName,
      //       cartVariant.first.quantity,
      //     );
      //   }
      // }
      // else {
      //   final items = [
      //     CartVariantData(
      //       event.variantData.variantName,
      //       1,
      //       event.variantData.price,
      //     )
      //   ];
      //   newCart.items[event.product] = items;
      //   _updateQuantityOnServer(
      //     event.product.id,
      //     event.variantData.variantName,
      //     1,
      //   );
      // }
      //
      // // newCart.items[event.product.id]?.totalItems++;
      final newCart = await _coreCartRepository.incrementAmount(
        event.cart,
        event.product,
        event.variantData,
      );
      emit(UpdatedCartState(newCart));
    } catch (e) {
      emit(ShowSnackBar(e.toString()));
    }
  }

  _decrementAmount(
    DecrementAmount event,
    Emitter<OutletMenuState> emit,
  ) async {
    try {
      // if (event.cart.items[event.product] != null) {
      //   final newCart = Cart.fromParams(
      //     event.cart.outletId,
      //     event.cart.items,
      //     // event.cart.amount - event.variantData.price,
      //     // event.cart.cartTotalItems-1,
      //   );
      //   final cartVariant = newCart.items[event.product]?.firstWhere(
      //     (element) => element.variantName == event.variantData.variantName,
      //   );
      //   if (cartVariant?.quantity == null || cartVariant!.quantity <= 0) {
      //     throw Exception("This Item is not added");
      //   }
      //   cartVariant.quantity--;
      //   _updateQuantityOnServer(
      //     event.product.id,
      //     event.variantData.variantName,
      //     cartVariant.quantity,
      //   );
      //   // newCart.items[event.product.id]?.totalItems--;
      //
      //   emit(UpdatedCartState(newCart));
      // }
      // else {
      //   throw Exception("This Item is not added");
      // }
      final newCart = await _coreCartRepository.decrementAmount(
        event.cart,
        event.product,
        event.variantData,
      );
      emit(UpdatedCartState(newCart));
    } catch (e) {
      emit(ShowSnackBar(e.toString()));
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
    // } catch (e) {
    //   log(e.toString());
    //   if (e.toString() == "Exception: No Saved Outlet Found") {
    //     emit(NavigateToOutletList());
    //   } else {
    //     emit(ShowSnackBar(e.toString()));
    //   }
    // }
  }

  _outletListClicked(
    OutletListClicked event,
    Emitter<OutletMenuState> emit,
  ) {
    emit(OutletMenuLoading());
    emit(NavigateToOutletList());
  }
}
