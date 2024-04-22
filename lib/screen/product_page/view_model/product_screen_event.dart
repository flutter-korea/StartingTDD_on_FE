import 'package:equatable/equatable.dart';
import 'package:stdd_ex/domain_objects/menu.dart';
import 'package:stdd_ex/domain_objects/menu_option.dart';
import 'package:stdd_ex/domain_objects/option_groups.dart';
import 'package:stdd_ex/domain_objects/store.dart';

sealed class ProductScreenEvent extends Equatable {
  const ProductScreenEvent();
}

/// 가게 조회 페이지 진입 이벤트
final class InitializeProductScreen extends ProductScreenEvent {
  const InitializeProductScreen();

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
}

/// 메뉴 선택 이벤트
final class SelectMenu extends ProductScreenEvent {
  final Menu menu;

  const SelectMenu(this.menu);

  @override
  List<Object> get props => [menu];
}

/// 옵션 선택 이벤트
final class SelectOption extends ProductScreenEvent {
  final Menu menu;
  final OptionGroups optionGroup;
  final MenuOption option;

  const SelectOption(this.menu, this.optionGroup, this.option);

  @override
  List<Object> get props => [menu, optionGroup, option];
}

/// 선택 취소 이벤트
final class CancelSelection extends ProductScreenEvent {
  const CancelSelection();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}
