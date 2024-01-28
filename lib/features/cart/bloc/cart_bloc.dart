import 'dart:developer';

import 'package:flavr/features/cart/data/repository/cart_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/repository/core_cart_repository.dart';
import '../../../features/outlet_menu/data/models/Categories.dart';
import '../../../features/outlet_menu/data/models/Product.dart';
import '../../../features/outlet_menu/data/models/ProductVariantData.dart';
import '../data/models/Cart.dart';
import '../data/models/CartVariantData.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CoreCartRepository _coreCartRepository;
  final CartRepository _cartRepository;

  CartBloc(this._coreCartRepository, this._cartRepository)
      : super(CartInitial()) {
    on<UpdateGrandTotal>(_updateGrandTotal);
    on<CartIncrementAmount>(_incrementAmount);
    on<CartDecrementAmount>(_decrementAmount);
    on<ProceedToPay>(_onProceedToPay);
  }

  _onProceedToPay(
    ProceedToPay event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(CartLoading());
      final response = await _cartRepository.placeOrder(
        event.cart.outletId,
      );
      emit(ShowSnackbar(response));
    } catch (e) {
      emit(ShowSnackbar("Something went wrong $e"));
    }
  }

  int _calculateGrandTotal(Cart cart) {
    int count = 0;
    for (var i in cart.items.entries) {
      for (var j in i.value) {
        count += (j.price * j.quantity);
      }
    }
    return count;
  }

  _updateGrandTotal(UpdateGrandTotal event, Emitter<CartState> emit) async {
    final count = _calculateGrandTotal(event.cart);
    emit(GrandTotalChanged(count));
  }

  _incrementAmount(
    CartIncrementAmount event,
    Emitter<CartState> emit,
  ) async {
    try {
      // log("recieved cart page increment on ${event.variantData.variantName}");
      // final newCart = Cart.fromParams(
      //   event.cart.outletId,
      //   event.cart.items,
      //   // event.cart.amount + event.variantData.price,
      //   // event.cart.cartTotalItems+1
      // );
      // if (newCart.items[event.product] != null) {
      //   final cartVariant = newCart.items[event.product]?.firstWhere((element) =>
      //   element.variantName == event.variantData.variantName);
      //   if (cartVariant == null) {
      //     newCart.items[event.product]?.add(
      //       CartVariantData(
      //         event.variantData.variantName,
      //         1,
      //         event.variantData.price,
      //       ),
      //     );
      //   } else {
      //     cartVariant.quantity++;
      //   }
      // }
      // else {
      //   final items = [CartVariantData(
      //     event.variantData.variantName,
      //     1,
      //     event.variantData.price,
      //   )];
      //   newCart.items[event.product] = items;
      // }
      // // newCart.items[event.product.id]?.totalItems++;
      final newCart = await _coreCartRepository.incrementAmount(
        event.cart,
        event.product,
        event.variantData,
      );
      emit(RefreshUI(newCart, _calculateGrandTotal(newCart)));
    } catch (e) {
      emit(ShowSnackbar(e.toString()));
    }
  }

  _decrementAmount(
    CartDecrementAmount event,
    Emitter<CartState> emit,
  ) async {
    try {
      // log("recieved cart page decrement on ${event.variantData.variantName}");
      // if (event.cart.items[event.product] != null) {
      //   final newCart = Cart.fromParams(
      //     event.cart.outletId,
      //     event.cart.items,
      //     // event.cart.amount - event.variantData.price,
      //     // event.cart.cartTotalItems-1,
      //   );
      //   final cartVariant = newCart.items[event.product]?.firstWhere(
      //       (element) => element.variantName == event.variantData.variantName);
      //   if (cartVariant?.quantity == null || cartVariant!.quantity <= 0) {
      //     throw Exception("This Item is not added");
      //   }
      //   cartVariant.quantity--;
      //   // newCart.items[event.product.id]?.totalItems--;
      //
      //   emit(RefreshUI(newCart, _calculateGrandTotal(newCart)));
      // }
      // else {
      //   throw Exception("This Item is not added");
      // }
      final newCart = await _coreCartRepository.decrementAmount(
        event.cart,
        event.product,
        event.variantData,
      );
      emit(RefreshUI(newCart, _calculateGrandTotal(newCart)));
    } catch (e) {
      emit(ShowSnackbar(e.toString()));
    }
  }
}
