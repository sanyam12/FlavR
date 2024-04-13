import 'dart:convert';
import 'dart:developer';

import 'package:flavr/core/data_provider/core_storage_provider.dart';
import 'package:flavr/features/outlet_menu/data/models/ProductVariantData.dart';

import '../../features/cart/data/models/Cart.dart';
import '../../features/cart/data/models/CartVariantData.dart';
import '../../features/outlet_menu/data/models/Product.dart';
import '../data_provider/core_api_provider.dart';

class CoreCartRepository {
  final CoreStorageProvider _coreStorageProvider;
  final CoreApiProvider _coreApiProvider;

  CoreCartRepository(this._coreStorageProvider, this._coreApiProvider);

  Future<String> getToken() async {
    return await _coreStorageProvider.getToken();
  }

  Future<Cart> updateQuantityOnServer(
    String productId,
    String variant,
    int quantity,
    Cart cart,
  ) async {
    final token = await _coreStorageProvider.getToken();
    String response = await _coreApiProvider.updateQuantity(
      productId,
      variant,
      quantity,
      token,
      cart.outletId,
    );

    if (jsonDecode(response)["message"] ==
        "Cart items do not belong to this outlet") {
      response = await _coreApiProvider.clearCart(token);
      if (jsonDecode(response)["message"] == "Cleared cart") {
        response = await _coreApiProvider.updateQuantity(
          productId,
          variant,
          quantity,
          token,
          cart.outletId,
        );
        log("new added: $response");
      } else {
        throw Exception("Something Went Wrong While Resetting Cart");
      }
    }
    return cart;
  }

  Future<Cart> incrementAmount(
    Cart cart,
    Product product,
    ProductVariantData variantData,
  ) async {
    final newCart = Cart.fromParams(
      cart.outletId,
      cart.items,
    );
    if (newCart.items[product] != null) {
      final cartVariant = newCart.items[product]!.where(
        (element) => element.variantName == variantData.variantName,
      );
      if (cartVariant.isEmpty) {
        newCart.items[product]?.add(
          CartVariantData(
            variantData.variantName,
            1,
            variantData.price,
          ),
        );
        cart = await updateQuantityOnServer(
          product.id,
          variantData.variantName,
          1,
          cart,
        );
      } else {
        cartVariant.first.quantity++;
        cart = await updateQuantityOnServer(
          product.id,
          variantData.variantName,
          cartVariant.first.quantity,
          cart,
        );
      }
    } else {
      final items = [
        CartVariantData(
          variantData.variantName,
          1,
          variantData.price,
        )
      ];
      newCart.items[product] = items;
      cart = await updateQuantityOnServer(
        product.id,
        variantData.variantName,
        1,
        cart,
      );
    }

    return newCart;
    // newCart.items[product.id]?.totalItems++;
  }

  Future<Cart> decrementAmount(
    Cart cart,
    Product product,
    ProductVariantData variantData,
  ) async {
    if (cart.items[product] != null) {
      final cartVariant = cart.items[product]!.firstWhere(
        (element) => element.variantName == variantData.variantName,
        orElse: () =>
            CartVariantData(variantData.variantName, 0, variantData.price),
      );
      cartVariant.quantity--;
      if (cartVariant.quantity <= 0) {
        cart.items[product]?.remove(cartVariant);
      }
      cart = await updateQuantityOnServer(
        product.id,
        variantData.variantName,
        cartVariant.quantity,
        cart,
      );
      final newCart = Cart.fromParams(
        cart.outletId,
        cart.items,
      );
      return newCart;
    } else {
      throw Exception("This Item is not added");
    }
  }

  Future<Cart> updateQuantity(
    Cart cart,
    Product product,
    ProductVariantData variantData,
    int newAmount,
  ) async {
    if (newAmount <= 0 && cart.items[product] != null) {
      cart.items[product]!.removeWhere(
          (element) => element.variantName == variantData.variantName);
    } else {
      CartVariantData cartVariant = CartVariantData(
        variantData.variantName,
        newAmount,
        variantData.price,
      );
      if (cart.items[product] != null && cart.items[product]!.isNotEmpty) {
        cartVariant = cart.items[product]!.firstWhere(
            (element) => element.variantName == variantData.variantName,
            orElse: () {
          cart.items[product]!.add(cartVariant);
          return cartVariant;
        });
        cartVariant.quantity = newAmount;
      } else {
        cart.items[product] = [cartVariant];
      }
    }
    cart = await updateQuantityOnServer(
      product.id,
      variantData.variantName,
      newAmount,
      cart,
    );
    Cart newCart = Cart.fromParams(cart.outletId, cart.items);
    return newCart;
  }
}
