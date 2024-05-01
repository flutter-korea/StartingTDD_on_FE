import 'package:equatable/equatable.dart';
import 'package:stdd_ex/domain_objects/menu.dart';
import 'package:stdd_ex/domain_objects/menu_option.dart';
import 'package:stdd_ex/domain_objects/option_groups.dart';
import 'package:stdd_ex/domain_objects/store.dart';

sealed class ProductScreenState extends Equatable {
  const ProductScreenState();
}

final class Initial extends ProductScreenState {
  const Initial();

  @override
  List<Object?> get props => [];

  @override
  bool get stringify => true;
}

final class SelectingStoreState extends ProductScreenState {
  final List<Store> stores;

  const SelectingStoreState(this.stores);

  @override
  List<Object> get props => [stores];

  @override
  String toString() =>
      'SelectingStoreState(stores: ${stores.map((e) => e.id)})';
}

final class SelectingMenuState extends ProductScreenState {
  final Store selectedStore;
  final List<Store> stores;

  const SelectingMenuState({
    required this.selectedStore,
    required this.stores,
  });

  @override
  List<Object> get props => [
        selectedStore,
        stores,
      ];

  @override
  String toString() =>
      'SelectingMenuState(selectedStore: ${selectedStore.id}, stores: ${stores.map((e) => e.id)})';
}

final class SelectingMenuOptionState extends ProductScreenState {
  final Store selectedStore;
  final List<Store> stores;
  final Menu selectedMenu;

  final Map<OptionGroups, List<MenuOption>> _selectedOptions;

  // depensive copy
  Map<OptionGroups, List<MenuOption>> get selectedOptions =>
      {..._selectedOptions};

  const SelectingMenuOptionState({
    required this.selectedStore,
    required this.stores,
    required this.selectedMenu,
    final Map<OptionGroups, List<MenuOption>>? selectedOptions,
  }) : _selectedOptions = selectedOptions ?? const {};

  @override
  List<Object> get props => [
        selectedStore,
        stores,
        selectedMenu,
      ];

  @override
  String toString() =>
      'SelectingMenuOptionState(selectedStore: ${selectedStore.id}, stores: ${stores.map((e) => e.id)}, selectedMenu: ${selectedMenu.id})';
}
