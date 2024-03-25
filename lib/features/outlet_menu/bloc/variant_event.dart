part of 'variant_bloc.dart';

abstract class VariantEvent extends Equatable {
  const VariantEvent();
}

class SelectedVariantUpdated extends VariantEvent{
  final ProductVariantData selectedVariant;

  const SelectedVariantUpdated(this.selectedVariant);

  @override
  List<Object?> get props => [selectedVariant];

}

class AmountUpdated extends VariantEvent{
  final int amount;

  const AmountUpdated(this.amount);
  @override
  List<Object?> get props => [];

}