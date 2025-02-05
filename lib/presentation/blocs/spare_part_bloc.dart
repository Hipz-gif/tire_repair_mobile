import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tire_repair_mobile/data/models/spare_part_model.dart';
import 'package:tire_repair_mobile/domain/repositories/spare_part_repository.dart';

// Các sự kiện
abstract class SparePartEvent {}

class FetchSpareParts extends SparePartEvent {}

// Các trạng thái
abstract class SparePartState {}

class SparePartInitial extends SparePartState {}

class SparePartLoading extends SparePartState {}

class SparePartLoaded extends SparePartState {
  final List<SparePartModel> spareParts;

  SparePartLoaded(this.spareParts);
}

class SparePartError extends SparePartState {
  final String message;

  SparePartError(this.message);
}

class SparePartBloc extends Bloc<SparePartEvent, SparePartState> {
  final SparePartRepository sparePartRepository;

  SparePartBloc({required this.sparePartRepository})
      : super(SparePartInitial()) {
    on<FetchSpareParts>((event, emit) async {
      emit(SparePartLoading());
      try {
        final spareParts = await sparePartRepository.fetchSpareParts();
        emit(SparePartLoaded(
            spareParts)); // Khi có dữ liệu, phát sự kiện SparePartLoaded
      } catch (e) {
        emit(SparePartError(
            e.toString())); // Nếu có lỗi, phát sự kiện SparePartError
      }
    });
  }
}
