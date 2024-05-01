import 'package:equatable/equatable.dart';
import 'package:stdd_ex/domain_objects/menu.dart';
import 'package:stdd_ex/domain_objects/menu_option.dart';
import 'package:stdd_ex/domain_objects/option_groups.dart';
import 'package:stdd_ex/domain_objects/store.dart';
import 'package:stdd_ex/repositroy/store_repo.dart';
import 'package:stdd_ex/screen/product_page/view_model/product_screen_state.dart';

sealed class ProductScreenEvent extends Equatable {
  const ProductScreenEvent();
}

/// 가게 조회 페이지 진입 이벤트
final class InitializeProductScreen extends ProductScreenEvent {
  final StoreRepository storeRepository;
  final void Function(SelectingMenuOptionState state) onSubmit;

  const InitializeProductScreen({
    required this.storeRepository,
    required this.onSubmit,
  });

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

/// 가게 선택 이벤트
final class SelectStore extends ProductScreenEvent {
  final Store store;

  const SelectStore(this.store);

  @override
  List<Object> get props => [store];

  @override
  String toString() => 'SelectStore(store: ${store.id})';
}

/// 메뉴 선택 이벤트
final class SelectMenu extends ProductScreenEvent {
  final Menu menu;

  const SelectMenu(this.menu);

  @override
  List<Object> get props => [menu];

  @override
  String toString() => 'SelectMenu(menu: ${menu.id})';
}

/// 옵션 선택 이벤트
final class SelectOption extends ProductScreenEvent {
  final Menu menu;
  final OptionGroups optionGroup;
  final MenuOption option;

  const SelectOption({
    required this.menu,
    required this.optionGroup,
    required this.option,
  });

  @override
  List<Object> get props => [menu, optionGroup, option];

  @override
  String toString() =>
      'SelectOption(menu: ${menu.id}, optionGroup: $optionGroup, option: ${option.id})';
}

/// 장바구니에 담기
final class ConfirmSelection extends ProductScreenEvent {
  const ConfirmSelection();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

/// 선택 취소 이벤트
final class CancelSelection extends ProductScreenEvent {
  const CancelSelection();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}
