part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    // this.ads = const [],
    this.hasReachedEnd = false,
    this.pages = 1,
    this.total = 1,
    this.currentPage = 1,
  });

  final HomeStatus status;
  // final List<AdEntity> ads;
  // final AdsFilter adsFilter;
  final bool hasReachedEnd;
  final int pages;
  final int total;
  final int currentPage;

  HomeState copyWith({
    HomeStatus? status,
    // List<AdEntity>? ads,
    // AdsFilter? adsFilter,
    bool? hasReachedEnd,
    int? currentPage,
    int? pages,
    int? total,
  }) {
    return HomeState(
      status: status ?? this.status,
      // ads: ads ?? this.ads,
      // adsFilter: adsFilter ?? this.adsFilter,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      currentPage: currentPage ?? this.currentPage,
      pages: pages ?? this.pages,
      total: total ?? this.total,
    );
  }

  @override
  List<Object> get props => [status, hasReachedEnd, currentPage];
}
