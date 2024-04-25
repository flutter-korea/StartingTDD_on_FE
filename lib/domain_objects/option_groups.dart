import 'package:equatable/equatable.dart';
import 'package:stdd_ex/domain_objects/menu_option.dart';

abstract interface class OptionGroups extends Equatable {
  /// 옵션 그룹 이름
  abstract final String description;

  /// 최대 선택가능 개수
  abstract final int? maxQuantity;

  /// 최소 선택가능 개수
  abstract final int? minQuantity;

  /// 옵션 목록
  abstract final List<MenuOption> options;

  /// 옵션 그룹 식별자
  abstract final String id;
}

final class OptionGroupsImpl implements OptionGroups {
  @override
  final String description;

  @override
  final int? maxQuantity;

  @override
  final int? minQuantity;

  @override
  final List<MenuOption> options;

  @override
  final String id;

  const OptionGroupsImpl({
    required this.description,
    required this.maxQuantity,
    required this.minQuantity,
    required this.options,
    required this.id,
  });

  @override
  List<Object?> get props => [
        description,
        maxQuantity,
        minQuantity,
        options,
        id,
      ];

  @override
  bool get stringify => false;

  @override
  String toString() => """$description {
  maxQuantity: $maxQuantity,
  minQuantity: $minQuantity,
  options: ${options.fold("", (prev, element) => '$prev$element\n')}
  id: $id
}""";
}
