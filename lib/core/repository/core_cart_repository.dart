import 'package:flavr/core/data_provider/core_storage_provider.dart';
import 'package:flavr/features/cart/bloc/cart_bloc.dart';
import 'package:flavr/features/outlet_menu/bloc/outlet_menu_bloc.dart';
import 'package:flavr/features/outlet_menu/data/models/ProductVariantData.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/cart/data/models/Cart.dart';
import '../../features/cart/data/models/CartVariantData.dart';
import '../../features/outlet_menu/data/models/Product.dart';
import '../data_provider/core_api_provider.dart';

class CoreCartRepository {

  final CoreStorageProvider _coreStorageProvider;
  final CoreApiProvider _coreApiProvider;

  CoreCartRepository(this._coreStorageProvider, this._coreApiProvider);

  Future<String> getToken()async{
    return await _coreStorageProvider.getToken();
  }

  Future<void> updateQuantity(String productId, String variant, int quantity) async{
    final token = await _coreStorageProvider.getToken();
    await _coreApiProvider.updateQuantity(productId, variant, quantity, token);
  }

  Future<Cart> incrementAmount(
    Cart cart,
    Product product,
    ProductVariantData variantData,
  ) async {
    final newCart = Cart.fromParams(
      cart.outletId,
      cart.items,
      // cart.amount + variantData.price,
      // cart.cartTotalItems+1
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
        updateQuantity(
          product.id,
          variantData.variantName,
          1,
        );
      } else {
        cartVariant.first.quantity++;
        updateQuantity(
          product.id,
          variantData.variantName,
          cartVariant.first.quantity,
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
      updateQuantity(
        product.id,
        variantData.variantName,
        1,
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
      final newCart = Cart.fromParams(
        cart.outletId,
        cart.items,
        // cart.amount - variantData.price,
        // cart.cartTotalItems-1,
      );
      final cartVariant = newCart.items[product]?.firstWhere(
        (element) => element.variantName == variantData.variantName,
      );
      if (cartVariant?.quantity == null || cartVariant!.quantity <= 0) {
        throw Exception("This Item is not added");
      }
      cartVariant.quantity--;
      updateQuantity(
        product.id,
        variantData.variantName,
        cartVariant.quantity,
      );
      // newCart.items[product.id]?.totalItems--;
      return newCart;
    } else {
      throw Exception("This Item is not added");
    }
  }
}
