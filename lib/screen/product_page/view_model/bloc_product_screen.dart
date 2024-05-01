import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:stdd_ex/domain_objects/menu_option.dart';
import 'package:stdd_ex/domain_objects/store.dart';
import 'package:stdd_ex/repositroy/store_repo.dart';
import 'package:stdd_ex/screen/product_page/view_model/product_screen_event.dart';
import 'package:stdd_ex/screen/product_page/view_model/product_screen_state.dart';

final class ProductScreenBloc
    extends Bloc<ProductScreenEvent, ProductScreenState> {
  static final instance = ProductScreenBloc();

  late final StoreRepository _storeRepository;
  @visibleForTesting
  late final void Function(SelectingMenuOptionState state) onSubmit;

  ProductScreenBloc({
    final ProductScreenState? initialState,
  }) : super(initialState ?? const Initial()) {
    on((
      final ProductScreenEvent event,
      final Emitter<ProductScreenState> emit,
    ) async {
      switch (event) {
        case InitializeProductScreen():
          await _onInitializeProductScreen(event, emit);
        case SelectStore():
          await _onSelectStore(event, emit);
        case SelectMenu():
          await _onSelectMenu(event, emit);
        case SelectOption():
          await _onSelectOption(event, emit);
        case CancelSelection():
          await _onCancelSelection(event, emit);
        case ConfirmSelection():
          await _onConfirmSelection(event, emit);
      }
    });
  }

  Future<void> _onInitializeProductScreen(
    final InitializeProductScreen event,
    final Emitter<ProductScreenState> emit,
  ) async {
    _storeRepository = event.storeRepository;
    onSubmit = event.onSubmit;
    final List<Store> storeList = await _storeRepository.getStores();
    emit(SelectingStoreState(storeList));
  }

  Future<void> _onSelectStore(
    final SelectStore event,
    final Emitter<ProductScreenState> emit,
  ) async {
    final ProductScreenState currentState = state;
    switch (currentState) {
      case Initial():
      case SelectingMenuState():
      case SelectingMenuOptionState():
        break;
      case SelectingStoreState():
        emit(SelectingMenuState(
          selectedStore: event.store,
          stores: currentState.stores,
        ));
    }
  }

  Future<void> _onSelectMenu(
    final SelectMenu event,
    final Emitter<ProductScreenState> emit,
  ) async {
    final ProductScreenState currentState = state;
    switch (currentState) {
      case Initial():
      case SelectingStoreState():
      case SelectingMenuOptionState():
        break;
      case SelectingMenuState():
        emit(SelectingMenuOptionState(
          selectedStore: currentState.selectedStore,
          stores: currentState.stores,
          selectedMenu: event.menu,
        ));
    }
  }

  Future<void> _onSelectOption(
    final SelectOption event,
    final Emitter<ProductScreenState> emit,
  ) async {
    final ProductScreenState currentState = state;
    switch (currentState) {
      case Initial():
      case SelectingStoreState():
      case SelectingMenuState():
        break;
      case SelectingMenuOptionState():
        if (currentState.selectedOptions.containsKey(event.optionGroup) &&
            currentState.selectedOptions[event.optionGroup]!
                .contains(event.option)) {
          emit(SelectingMenuOptionState(
            selectedStore: currentState.selectedStore,
            stores: currentState.stores,
            selectedMenu: currentState.selectedMenu,
            selectedOptions: {
              ...currentState.selectedOptions,
            }..update(
                event.optionGroup,
                (final List<MenuOption> options) => options
                    .where((final MenuOption option) => option != event.option)
                    .toList(),
              ),
          ));
          return;
        }
        emit(SelectingMenuOptionState(
          selectedStore: currentState.selectedStore,
          stores: currentState.stores,
          selectedMenu: currentState.selectedMenu,
          selectedOptions: {
            ...currentState.selectedOptions,
          }..update(
              event.optionGroup,
              (final List<MenuOption> options) => [...options, event.option],
              ifAbsent: () => [event.option],
            ),
        ));
    }
  }

  Future<void> _onCancelSelection(
    final CancelSelection event,
    final Emitter<ProductScreenState> emit,
  ) async {
    final ProductScreenState currentState = state;

    switch (currentState) {
      case Initial():
      case SelectingStoreState():
        break;
      case SelectingMenuOptionState():
        emit(SelectingMenuState(
          selectedStore: currentState.selectedStore,
          stores: currentState.stores,
        ));
      case SelectingMenuState():
        emit(SelectingStoreState(currentState.stores));
    }
  }

  Future<void> _onConfirmSelection(
    final ConfirmSelection event,
    final Emitter<ProductScreenState> emit,
  ) async {
    final ProductScreenState currentState = state;

    switch (currentState) {
      case Initial():
      case SelectingStoreState():
      case SelectingMenuState():
        break;
      case SelectingMenuOptionState():
        onSubmit(currentState);
        emit(SelectingStoreState(currentState.stores));
    }
  }
}
