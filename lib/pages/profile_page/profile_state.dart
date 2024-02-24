part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileDataState extends ProfileState {
  final String userName;
  final String email;
  final String profilePicUrl;
  final List<OrderData> list;

  const ProfileDataState(
    this.userName,
    this.list,
    this.email,
    this.profilePicUrl,
  );

  @override
  List<Object?> get props => [
        userName,
        list,
        email,
      ];
}

class ShowSnackbar extends ProfileState {
  final String messsage;

  const ShowSnackbar(this.messsage);

  @override
  List<Object?> get props => [messsage];
}
