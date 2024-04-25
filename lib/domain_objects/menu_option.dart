import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

abstract interface class MenuOption extends Equatable {
  abstract final String description;

  abstract final Decimal price;

  abstract final String id;
}

final class MenuOptionImpl implements MenuOption {
  @override
  final String description;

  @override
  final Decimal price;

  @override
  final String id;

  const MenuOptionImpl({
    required this.description,
    required this.price,
    required this.id,
  });

  @override
  List<Object> get props => [
        description,
        price,
        id,
      ];

  @override
  bool? get stringify => false;

  @override
  String toString() => "$description- Price: $price Won : $id";
}
