import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tezkyzmaty_sellers/core/error/error_exception.dart';
import 'package:tezkyzmaty_sellers/domain/usecases/application_use_case.dart';
import 'package:tezkyzmaty_sellers/injectable.dart';
import 'package:tezkyzmaty_sellers/presentation/feature/authentication/bloc/authentication_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.applicationUseCase) : super(const HomeState()) {
    on<RefreshHomePageEvent>(_refreshPageAds);
    on<FetchApplicationNextPageEvent>(_fetchApplicationNextPage);
  }
  final ApplicationUseCase applicationUseCase;
  Future<void> _refreshPageAds(
    RefreshHomePageEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        status: HomeStatus.initial,
        hasReachedEnd: false,
        // ads: [],
        // adsFilter: event.adsFilter,
      ),
    );

    try {
      // final result = await applicationUseCase.getAds(
      //   page: 1,
      //   filter: state.adsFilter,
      // );

      // result.fold(
      //   (failure) {
      //     emit(state.copyWith(status: AdsStatus.failure));
      //   },
      //   (data) {
      //     final ads = data.results;
      //     final pages = data.pages ?? 0;
      //     final total = data.count;
      //     final hasReachedEnd = data.page == pages;

      //     emit(
      //       state.copyWith(
      //         status: AdsStatus.success,
      //         ads: ads,
      //         hasReachedEnd: hasReachedEnd,
      //         pages: pages,
      //         total: total,
      //         currentPage: 1,
      //       ),
      //     );
      //   },
      // );
    } catch (e) {
      if (e is UnauthorizedException) {
        getIt<AuthenticationBloc>().add(LoggedOut());
        return;
      }
      log(e.toString());

      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> _fetchApplicationNextPage(
    FetchApplicationNextPageEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.hasReachedEnd || state.status == HomeStatus.loading) {
      return;
    }

    emit(state.copyWith(status: HomeStatus.loading));

    try {
      // final result = await applicationUseCase.getAds(
      //   page: state.currentPage + 1,
      //   filter: state.adsFilter,
      // );

      // result.fold(
      //   (failure) {
      //     emit(state.copyWith(status: AdsStatus.failure));
      //   },
      //   (data) {
      //     final newAds = data.results;
      //     final pages = data.pages ?? 0;
      //     final total = data.count;
      //     final hasReachedEnd = data.page == pages;

      //     emit(
      //       state.copyWith(
      //         status: AdsStatus.success,
      //         ads: List.of(state.ads)..addAll(newAds),
      //         hasReachedEnd: hasReachedEnd,
      //         pages: pages,
      //         total: total,
      //         currentPage:
      //             hasReachedEnd ? state.currentPage : state.currentPage + 1,
      //       ),
      //     );
      //   },
      // );
    } catch (e) {
      if (e is UnauthorizedException) {
        getIt<AuthenticationBloc>().add(LoggedOut());
        return;
      }
      log(e.toString());

      emit(state.copyWith(status: HomeStatus.failure));
    }
  }
}
