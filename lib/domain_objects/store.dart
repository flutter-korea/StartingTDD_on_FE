import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:stdd_ex/domain_objects/menu.dart';

abstract interface class Store extends Equatable {
  /// 가게 이름
  abstract final String name;

  /// 가게 썸네일 이미지
  abstract final String thumbnail;

  /// 가게 평점
  abstract final double rating;

  /// 가게 리뷰 수
  abstract final int reviewCount;

  /// 가게 설명
  abstract final String description;

  /// 최소 주문 금액
  abstract final Decimal minOrderPrice;

  /// 가게 메뉴 목록
  abstract final List<Menu> menus;

  /// 가게 식별자
  abstract final String id;
}

final class StoreImpl implements Store {
  @override
  final String description;

  @override
  final List<Menu> menus;

  @override
  final String name;

  @override
  final String thumbnail;

  @override
  final String id;

  @override
  final Decimal minOrderPrice;

  @override
  final double rating;

  @override
  final int reviewCount;

  @override
  List<Object?> get props => [
        description,
        menus,
        name,
        thumbnail,
        id,
        minOrderPrice,
        rating,
        reviewCount,
      ];

  @override
  bool? get stringify => false;

  @override
  String toString() => """$name {
  description: $description,
  menus: $menus,
  id: $id,
}""";

  const StoreImpl({
    required this.description,
    required this.menus,
    required this.name,
    required this.thumbnail,
    required this.id,
    required this.minOrderPrice,
    required this.rating,
    required this.reviewCount,
  });

  static StoreImpl empty() => StoreImpl(
        description: '',
        menus: [],
        name: '',
        thumbnail: '',
        id: "-1",
        minOrderPrice: Decimal.zero,
        rating: -1,
        reviewCount: -1,
      );
}
