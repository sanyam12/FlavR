part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileDataState extends ProfileState{
  final String userName;
  final Stream<List<OrderData>> list;
  const ProfileDataState(this.userName, this.list);
  @override
  List<Object?> get props => [userName, list];

}

class ShowSnackbar extends ProfileState{
  final String messsage;
  const ShowSnackbar(this.messsage);

  @override
  List<Object?> get props => [messsage];

}
