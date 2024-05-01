import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:faker/faker.dart';
import 'package:stdd_ex/domain_objects/menu.dart';
import 'package:stdd_ex/domain_objects/menu_option.dart';
import 'package:stdd_ex/domain_objects/option_groups.dart';
import 'package:stdd_ex/domain_objects/store.dart';
import 'package:uuid/v4.dart';

MenuOption genRandomMenuOption() {
  return MenuOptionImpl(
    description: Faker().lorem.sentence(),
    price: Decimal.parse(Random().nextInt(1000).toString()),
    id: const UuidV4().generate(),
  );
}

OptionGroups genRandomOptionGroups({final int? optionsLength}) {
  return OptionGroupsImpl(
    description: Faker().lorem.sentence(),
    maxQuantity: Random().nextInt(10),
    minQuantity: Random().nextInt(10),
    options: List.generate(optionsLength ?? Random().nextInt(10) + 5,
        (index) => genRandomMenuOption()),
    id: const UuidV4().generate(),
  );
}

Menu genRandomMenu({final int? optionGroupsLength}) {
  return MenuImpl(
    description: Faker().lorem.sentence(),
    thumbnail: Faker().image.image(),
    optionsGroups: List.generate(optionGroupsLength ?? Random().nextInt(5) + 1,
        (index) => genRandomOptionGroups()),
    defaultPrice: Decimal.parse(Random().nextInt(1000).toString()),
    id: const UuidV4().generate(),
  );
}

Store genRandomStore({final int? menusLength}) {
  return StoreImpl(
    description: Faker().lorem.sentence(),
    menus: List.generate(
        menusLength ?? Random().nextInt(5) + 1, (index) => genRandomMenu()),
    name: Faker().lorem.sentence(),
    thumbnail: Faker().image.image(),
    id: const UuidV4().generate(),
    minOrderPrice: Decimal.parse(Random().nextInt(1000).toString()),
    rating: Random().nextDouble() * 5,
    reviewCount: Random().nextInt(1000),
  );
}

List<Store> genRandomStores({final int? storesLength}) {
  return List.generate(
      storesLength ?? Random().nextInt(5) + 1, (index) => genRandomStore());
}
