part of 'maintab_cubit.dart';

@immutable
sealed class MaintabState {}

final class MaintabInitial extends MaintabState {}

class MaintabSuccess extends MaintabState{

 final List<PropertytypeModel> response;

 MaintabSuccess(this.response);
}


class MaintabLoading extends MaintabState{}
class MaintabError extends MaintabState{

  final String error;

  MaintabError(this.error);
}


