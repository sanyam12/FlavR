
import 'package:equatable/equatable.dart';
import 'package:flavr/features/outlet_menu/data/models/ProductVariantData.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'variant_event.dart';
part 'variant_state.dart';

class VariantBloc extends Bloc<VariantEvent, VariantState> {
  VariantBloc() : super(VariantInitial()) {
    on<VariantEvent>((event, emit) {
      if(event is SelectedVariantUpdated){
        emit(VariantUpdate(event.selectedVariant));
      }
      if(event is AmountUpdated){
        emit(VariantAmountUpdate(event.amount));
      }
    });
  }
}
