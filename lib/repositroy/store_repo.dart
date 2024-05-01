import 'package:decimal/decimal.dart';
import 'package:stdd_ex/domain_objects/menu.dart';
import 'package:stdd_ex/domain_objects/menu_option.dart';
import 'package:stdd_ex/domain_objects/option_groups.dart';
import 'package:stdd_ex/domain_objects/store.dart';
import 'package:uuid/v4.dart';

abstract interface class StoreRepository {
  Future<List<Store>> getStores();
}

final class StoreRepositoryImpl implements StoreRepository {
  @override
  Future<List<Store>> getStores() async {
    return [
      StoreImpl(
        description: "피자헛 매장입니다. 맛있는 피자를 만나보세요.",
        menus: [
          MenuImpl(
            description: '팬 반반피자 (L)',
            thumbnail:
                "https://cdn.pixabay.com/photo/2017/12/09/08/18/pizza-3007395_960_720.jpg",
            optionsGroups: [
              OptionGroupsImpl(
                  description: "기본품목 (핫소스&피클)",
                  maxQuantity: 1,
                  minQuantity: 1,
                  options: [
                    MenuOptionImpl(
                      description: "핫소스, 피클 모두 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                    MenuOptionImpl(
                      description: "핫소스만 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                    MenuOptionImpl(
                      description: "피클만 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                  ],
                  id: "OptionGroupsImpl0"),
              OptionGroupsImpl(
                description: "팬 반반피자 선택(L)",
                maxQuantity: 2,
                minQuantity: 2,
                options: [
                  MenuOptionImpl(
                    description: "(팬) 콤비네이션 피자",
                    price: Decimal.fromInt(1750),
                    id: const UuidV4().generate(),
                  ),
                  MenuOptionImpl(
                    description: "(팬) 슈퍼슈프림 피자",
                    price: Decimal.fromInt(1750),
                    id: const UuidV4().generate(),
                  ),
                  MenuOptionImpl(
                    description: "(팬) 치즈킹 피자",
                    price: Decimal.fromInt(1750),
                    id: const UuidV4().generate(),
                  ),
                  MenuOptionImpl(
                    description: "(팬) 더블크러스트 피자",
                    price: Decimal.fromInt(1750),
                    id: const UuidV4().generate(),
                  ),
                ],
                id: const UuidV4().generate(),
              ),
            ],
            defaultPrice: Decimal.fromInt(26000),
            id: const UuidV4().generate(),
          ),
          MenuImpl(
            description: "오리지널 반반피자(L)",
            thumbnail:
                "https://cdn.pixabay.com/photo/2017/12/09/08/18/pizza-3007395_960_720.jpg",
            optionsGroups: [
              OptionGroupsImpl(
                  description: "기본품목 (핫소스&피클)",
                  maxQuantity: 1,
                  minQuantity: 1,
                  options: [
                    MenuOptionImpl(
                      description: "핫소스, 피클 모두 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                    MenuOptionImpl(
                      description: "핫소스만 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                    MenuOptionImpl(
                      description: "피클만 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                  ],
                  id: "OptionGroupsImpl0"),
              OptionGroupsImpl(
                description: "오리지널 반반피자 선택(L)",
                maxQuantity: 2,
                minQuantity: 2,
                options: [
                  MenuOptionImpl(
                    description: "(오리지널) 콤비네이션 피자",
                    price: Decimal.fromInt(1750),
                    id: const UuidV4().generate(),
                  ),
                  MenuOptionImpl(
                    description: "(오리지널) 슈퍼슈프림 피자",
                    price: Decimal.fromInt(1750),
                    id: const UuidV4().generate(),
                  ),
                  MenuOptionImpl(
                    description: "(오리지널) 치즈킹 피자",
                    price: Decimal.fromInt(1750),
                    id: const UuidV4().generate(),
                  ),
                  MenuOptionImpl(
                    description: "(오리지널) 더블크러스트 피자",
                    price: Decimal.fromInt(1750),
                    id: const UuidV4().generate(),
                  ),
                ],
                id: const UuidV4().generate(),
              ),
            ],
            defaultPrice: Decimal.fromInt(26000),
            id: const UuidV4().generate(),
          ),
          MenuImpl(
            description: "수퍼슈프림",
            thumbnail:
                "https://cdn.pixabay.com/photo/2017/12/09/08/18/pizza-3007395_960_720.jpg",
            optionsGroups: [
              OptionGroupsImpl(
                  description: "기본품목 (핫소스&피클)",
                  maxQuantity: 1,
                  minQuantity: 1,
                  options: [
                    MenuOptionImpl(
                      description: "핫소스, 피클 모두 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                    MenuOptionImpl(
                      description: "핫소스만 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                    MenuOptionImpl(
                      description: "피클만 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                  ],
                  id: "OptionGroupsImpl0"),
            ],
            defaultPrice: Decimal.fromInt(33900),
            id: const UuidV4().generate(),
          ),
        ],
        name: "피자헛",
        thumbnail:
            "https://cdn.pixabay.com/photo/2017/12/09/08/18/pizza-3007395_960_720.jpg",
        id: const UuidV4().generate(),
        minOrderPrice: Decimal.fromInt(6000),
        rating: 4.9,
        reviewCount: 700,
      ),
      StoreImpl(
        description: "피자헛 매장입니다. 맛있는 피자를 만나보세요.",
        menus: [
          MenuImpl(
            description: '팬 반반피자 (L)',
            thumbnail:
                "https://cdn.pixabay.com/photo/2017/12/09/08/18/pizza-3007395_960_720.jpg",
            optionsGroups: [
              OptionGroupsImpl(
                  description: "기본품목 (핫소스&피클)",
                  maxQuantity: 1,
                  minQuantity: 1,
                  options: [
                    MenuOptionImpl(
                      description: "핫소스, 피클 모두 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                    MenuOptionImpl(
                      description: "핫소스만 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                    MenuOptionImpl(
                      description: "피클만 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                  ],
                  id: "OptionGroupsImpl0"),
              OptionGroupsImpl(
                description: "팬 반반피자 선택(L)",
                maxQuantity: 2,
                minQuantity: 2,
                options: [
                  MenuOptionImpl(
                    description: "(팬) 콤비네이션 피자",
                    price: Decimal.fromInt(1750),
                    id: const UuidV4().generate(),
                  ),
                  MenuOptionImpl(
                    description: "(팬) 슈퍼슈프림 피자",
                    price: Decimal.fromInt(1750),
                    id: const UuidV4().generate(),
                  ),
                  MenuOptionImpl(
                    description: "(팬) 치즈킹 피자",
                    price: Decimal.fromInt(1750),
                    id: const UuidV4().generate(),
                  ),
                  MenuOptionImpl(
                    description: "(팬) 더블크러스트 피자",
                    price: Decimal.fromInt(1750),
                    id: const UuidV4().generate(),
                  ),
                ],
                id: const UuidV4().generate(),
              ),
            ],
            defaultPrice: Decimal.fromInt(26000),
            id: const UuidV4().generate(),
          ),
          MenuImpl(
            description: "오리지널 반반피자(L)",
            thumbnail:
                "https://cdn.pixabay.com/photo/2017/12/09/08/18/pizza-3007395_960_720.jpg",
            optionsGroups: [
              OptionGroupsImpl(
                  description: "기본품목 (핫소스&피클)",
                  maxQuantity: 1,
                  minQuantity: 1,
                  options: [
                    MenuOptionImpl(
                      description: "핫소스, 피클 모두 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                    MenuOptionImpl(
                      description: "핫소스만 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                    MenuOptionImpl(
                      description: "피클만 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                  ],
                  id: "OptionGroupsImpl0"),
              OptionGroupsImpl(
                description: "오리지널 반반피자 선택(L)",
                maxQuantity: 2,
                minQuantity: 2,
                options: [
                  MenuOptionImpl(
                    description: "(오리지널) 콤비네이션 피자",
                    price: Decimal.fromInt(1750),
                    id: const UuidV4().generate(),
                  ),
                  MenuOptionImpl(
                    description: "(오리지널) 슈퍼슈프림 피자",
                    price: Decimal.fromInt(1750),
                    id: const UuidV4().generate(),
                  ),
                  MenuOptionImpl(
                    description: "(오리지널) 치즈킹 피자",
                    price: Decimal.fromInt(1750),
                    id: const UuidV4().generate(),
                  ),
                  MenuOptionImpl(
                    description: "(오리지널) 더블크러스트 피자",
                    price: Decimal.fromInt(1750),
                    id: const UuidV4().generate(),
                  ),
                ],
                id: const UuidV4().generate(),
              ),
            ],
            defaultPrice: Decimal.fromInt(26000),
            id: const UuidV4().generate(),
          ),
          MenuImpl(
            description: "수퍼슈프림",
            thumbnail:
                "https://cdn.pixabay.com/photo/2017/12/09/08/18/pizza-3007395_960_720.jpg",
            optionsGroups: [
              OptionGroupsImpl(
                  description: "기본품목 (핫소스&피클)",
                  maxQuantity: 1,
                  minQuantity: 1,
                  options: [
                    MenuOptionImpl(
                      description: "핫소스, 피클 모두 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                    MenuOptionImpl(
                      description: "핫소스만 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                    MenuOptionImpl(
                      description: "피클만 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                  ],
                  id: "OptionGroupsImpl0"),
            ],
            defaultPrice: Decimal.fromInt(33900),
            id: const UuidV4().generate(),
          ),
        ],
        name: "피자헛",
        thumbnail:
            "https://cdn.pixabay.com/photo/2017/12/09/08/18/pizza-3007395_960_720.jpg",
        id: const UuidV4().generate(),
        minOrderPrice: Decimal.fromInt(6000),
        rating: 4.9,
        reviewCount: 700,
      ),
      StoreImpl(
        description: "피자헛 매장입니다. 맛있는 피자를 만나보세요.",
        menus: [
          MenuImpl(
            description: '팬 반반피자 (L)',
            thumbnail:
                "https://cdn.pixabay.com/photo/2017/12/09/08/18/pizza-3007395_960_720.jpg",
            optionsGroups: [
              OptionGroupsImpl(
                  description: "기본품목 (핫소스&피클)",
                  maxQuantity: 1,
                  minQuantity: 1,
                  options: [
                    MenuOptionImpl(
                      description: "핫소스, 피클 모두 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                    MenuOptionImpl(
                      description: "핫소스만 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                    MenuOptionImpl(
                      description: "피클만 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                  ],
                  id: "OptionGroupsImpl0"),
              OptionGroupsImpl(
                description: "팬 반반피자 선택(L)",
                maxQuantity: 2,
                minQuantity: 2,
                options: [
                  MenuOptionImpl(
                    description: "(팬) 콤비네이션 피자",
                    price: Decimal.fromInt(1750),
                    id: const UuidV4().generate(),
                  ),
                  MenuOptionImpl(
                    description: "(팬) 슈퍼슈프림 피자",
                    price: Decimal.fromInt(1750),
                    id: const UuidV4().generate(),
                  ),
                  MenuOptionImpl(
                    description: "(팬) 치즈킹 피자",
                    price: Decimal.fromInt(1750),
                    id: const UuidV4().generate(),
                  ),
                  MenuOptionImpl(
                    description: "(팬) 더블크러스트 피자",
                    price: Decimal.fromInt(1750),
                    id: const UuidV4().generate(),
                  ),
                ],
                id: const UuidV4().generate(),
              ),
            ],
            defaultPrice: Decimal.fromInt(26000),
            id: const UuidV4().generate(),
          ),
          MenuImpl(
            description: "오리지널 반반피자(L)",
            thumbnail:
                "https://cdn.pixabay.com/photo/2017/12/09/08/18/pizza-3007395_960_720.jpg",
            optionsGroups: [
              OptionGroupsImpl(
                  description: "기본품목 (핫소스&피클)",
                  maxQuantity: 1,
                  minQuantity: 1,
                  options: [
                    MenuOptionImpl(
                      description: "핫소스, 피클 모두 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                    MenuOptionImpl(
                      description: "핫소스만 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                    MenuOptionImpl(
                      description: "피클만 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                  ],
                  id: "OptionGroupsImpl0"),
              OptionGroupsImpl(
                description: "오리지널 반반피자 선택(L)",
                maxQuantity: 2,
                minQuantity: 2,
                options: [
                  MenuOptionImpl(
                    description: "(오리지널) 콤비네이션 피자",
                    price: Decimal.fromInt(1750),
                    id: const UuidV4().generate(),
                  ),
                  MenuOptionImpl(
                    description: "(오리지널) 슈퍼슈프림 피자",
                    price: Decimal.fromInt(1750),
                    id: const UuidV4().generate(),
                  ),
                  MenuOptionImpl(
                    description: "(오리지널) 치즈킹 피자",
                    price: Decimal.fromInt(1750),
                    id: const UuidV4().generate(),
                  ),
                  MenuOptionImpl(
                    description: "(오리지널) 더블크러스트 피자",
                    price: Decimal.fromInt(1750),
                    id: const UuidV4().generate(),
                  ),
                ],
                id: const UuidV4().generate(),
              ),
            ],
            defaultPrice: Decimal.fromInt(26000),
            id: const UuidV4().generate(),
          ),
          MenuImpl(
            description: "수퍼슈프림",
            thumbnail:
                "https://cdn.pixabay.com/photo/2017/12/09/08/18/pizza-3007395_960_720.jpg",
            optionsGroups: [
              OptionGroupsImpl(
                  description: "기본품목 (핫소스&피클)",
                  maxQuantity: 1,
                  minQuantity: 1,
                  options: [
                    MenuOptionImpl(
                      description: "핫소스, 피클 모두 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                    MenuOptionImpl(
                      description: "핫소스만 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                    MenuOptionImpl(
                      description: "피클만 제외",
                      price: Decimal.zero,
                      id: const UuidV4().generate(),
                    ),
                  ],
                  id: "OptionGroupsImpl0"),
            ],
            defaultPrice: Decimal.fromInt(33900),
            id: const UuidV4().generate(),
          ),
        ],
        name: "피자헛",
        thumbnail:
            "https://cdn.pixabay.com/photo/2017/12/09/08/18/pizza-3007395_960_720.jpg",
        id: const UuidV4().generate(),
        minOrderPrice: Decimal.fromInt(6000),
        rating: 4.9,
        reviewCount: 700,
      ),
    ];
  }
}
