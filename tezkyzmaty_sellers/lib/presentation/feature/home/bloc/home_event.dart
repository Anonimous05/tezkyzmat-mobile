part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class FetchApplicationNextPageEvent extends HomeEvent {
  const FetchApplicationNextPageEvent({this.isNewSearch = false});
  final bool? isNewSearch;
}

final class RefreshHomePageEvent extends HomeEvent {
  const RefreshHomePageEvent();
}
