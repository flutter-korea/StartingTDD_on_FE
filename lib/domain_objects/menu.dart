import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:stdd_ex/domain_objects/option_groups.dart';

abstract interface class Menu extends Equatable {
  /// 이름
  abstract final String description;

  /// 썸네일 이미지
  abstract final String thumbnail;

  /// 최대 선택가능 개수
  abstract final int? maxQuantity;

  /// 선택 가능한 옵션 목록
  abstract final List<OptionGroups> optionsGroups;

  /// 기본가격
  abstract final Decimal defaultPrice;

  /// 메뉴 식별자
  abstract final String id;
}

final class MenuImpl implements Menu {
  @override
  final String description;

  @override
  final String thumbnail;

  @override
  final int? maxQuantity;

  @override
  final List<OptionGroups> optionsGroups;

  @override
  final Decimal defaultPrice;

  @override
  final String id;

  const MenuImpl({
    required this.description,
    required this.thumbnail,
    required this.maxQuantity,
    required this.optionsGroups,
    required this.defaultPrice,
    required this.id,
  });

  @override
  List<Object?> get props => [
        description,
        thumbnail,
        maxQuantity,
        optionsGroups,
        defaultPrice,
        id,
      ];

  @override
  bool get stringify => false;

  @override
  String toString() => """$description {
  maxQuantity: $maxQuantity,
  optionsGroups: ${optionsGroups.fold("", (prev, e) => '$prev$e\n')}},
  defaultPrice: $defaultPrice,
  id: $id,
}""";
}
