part of 'variant_bloc.dart';

abstract class VariantState extends Equatable {
  const VariantState();
}

class VariantInitial extends VariantState {
  @override
  List<Object> get props => [];
}

class VariantUpdate extends VariantState{
  final ProductVariantData selectedVariant;

  const VariantUpdate(this.selectedVariant);

  @override
  List<Object?> get props => [selectedVariant];

}

class VariantAmountUpdate extends VariantState{
  final int amount;

  const VariantAmountUpdate(this.amount);

  @override
  List<Object?> get props => [amount];

}
