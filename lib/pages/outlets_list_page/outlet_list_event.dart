part of 'outlet_list_bloc.dart';

abstract class OutletListEvent extends Equatable {
  const OutletListEvent();
}


class OnSearchButtonClicked extends OutletListEvent{
  final String query;
  const OnSearchButtonClicked({required this.query});

  @override
  List<Object?> get props => [query];

}

class OnProfileButtonClicked extends OutletListEvent{
  const OnProfileButtonClicked();

  @override
  List<Object?> get props => [];
}