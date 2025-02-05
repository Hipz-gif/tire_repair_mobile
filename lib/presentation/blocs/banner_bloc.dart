import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tire_repair_mobile/data/models/banner_model.dart';
import 'package:tire_repair_mobile/domain/repositories/banner_repository.dart';

// Các sự kiện
abstract class BannerEvent {}

class FetchBanners extends BannerEvent {}

// Các trạng thái
abstract class BannerState {}

class BannerInitial extends BannerState {}

class BannerLoading extends BannerState {}

class BannerLoaded extends BannerState {
  final List<BannerModel> banners;

  BannerLoaded(this.banners);
}

class BannerError extends BannerState {
  final String message;

  BannerError(this.message);
}

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final BannerRepository bannerRepository;

  BannerBloc({required this.bannerRepository}) : super(BannerInitial()) {
    on<FetchBanners>((event, emit) async {
      emit(BannerLoading());
      try {
        final banners = await bannerRepository.fetchBanners();
        emit(BannerLoaded(banners));
      } catch (e) {
        emit(BannerError(e.toString()));
      }
    });
  }
}
