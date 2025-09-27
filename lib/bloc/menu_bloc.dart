import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../entities/menu_item.dart';
import '../../../repositories/restaurant_repository.dart';

part 'menu_event.dart';
part 'menu_state.dart';

@injectable
class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final RestaurantRepository repository;

  MenuBloc(this.repository) : super(MenuInitial()) {
    on<LoadMenuItems>(_onLoadMenuItems);
    on<ClearMenu>(_onClearMenu);
  }

  Future<void> _onLoadMenuItems(
    LoadMenuItems event,
    Emitter<MenuState> emit,
  ) async {
    emit(MenuLoading());

    final result = await repository.getMenuItems(event.restaurantId);

    result.fold(
      (failure) => emit(MenuError(failure.message)),
      (items) => emit(MenuLoaded(items)),
    );
  }

  void _onClearMenu(ClearMenu event, Emitter<MenuState> emit) {
    emit(MenuInitial());
  }
}
