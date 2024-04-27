import 'package:bloc/bloc.dart';
import 'package:stdd_ex/domain_objects/store.dart';
import 'package:stdd_ex/repositroy/store_repo.dart';
import 'package:stdd_ex/screen/product_page/view_model/product_screen_event.dart';
import 'package:stdd_ex/screen/product_page/view_model/product_screen_state.dart';

final class ProductScreenBloc
    extends Bloc<ProductScreenEvent, ProductScreenState> {
  final StoreRepository _storeRepository;

  ProductScreenBloc({
    required final StoreRepository storeRepository,
  })  : _storeRepository = storeRepository,
        super(const Initial()) {
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
    final List<Store> storeList = await _storeRepository.getStores();
    emit(SelectingStoreState(storeList));
  }

  Future<void> _onSelectStore(
    final SelectStore event,
    final Emitter<ProductScreenState> emit,
  ) async {
    throw UnimplementedError();
  }

  Future<void> _onSelectMenu(
    final SelectMenu event,
    final Emitter<ProductScreenState> emit,
  ) async {
    throw UnimplementedError();
  }

  Future<void> _onSelectOption(
    final SelectOption event,
    final Emitter<ProductScreenState> emit,
  ) async {
    throw UnimplementedError();
  }

  Future<void> _onCancelSelection(
    final CancelSelection event,
    final Emitter<ProductScreenState> emit,
  ) async {
    throw UnimplementedError();
  }

  Future<void> _onConfirmSelection(
    final ConfirmSelection event,
    final Emitter<ProductScreenState> emit,
  ) async {
    throw UnimplementedError();
  }
}
