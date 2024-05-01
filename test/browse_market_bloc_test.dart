import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:stdd_ex/domain_objects/menu.dart';
import 'package:stdd_ex/domain_objects/menu_option.dart';
import 'package:stdd_ex/domain_objects/option_groups.dart';
import 'package:stdd_ex/domain_objects/store.dart';
import 'package:stdd_ex/screen/product_page/view_model/bloc_product_screen.dart';
import 'package:stdd_ex/screen/product_page/view_model/product_screen_event.dart';
import 'package:stdd_ex/screen/product_page/view_model/product_screen_state.dart';

import '@mock/gen_mock_store_repo.mocks.dart';
import 'test_support.dart';

void main() {
  late MockStoreRepository mockStoreRepository;
  setUp(() => mockStoreRepository = MockStoreRepository());
  tearDown(() => resetMockitoState());
  group("유저는 가게 조회 페이를 탐색하며,", () {
    group("초기 진입시에는,", () {
      test("매장 정보를 불러 올 수 있어야한다.", () async {
        // given: sut (system under test) 와 mockRepository 의 예상 결과값을 준비한다.
        final List<Store> expectedStores = genRandomStores();
        when(mockStoreRepository.getStores())
            .thenAnswer((_) async => expectedStores);
        final ProductScreenBloc sut = ProductScreenBloc();

        // when: 유저가 페이지에 진입해, 초기화 이벤트를 발생시킨면.
        sut.add(InitializeProductScreen(
            storeRepository: mockStoreRepository,
            onSubmit: (SelectingMenuOptionState state) {}));

        // then: sut 의 상태가 변경되고,
        final ProductScreenState state = await sut.stream.first;

        // expect: 이는 매장 선택단계로 변경되며, 기대하는 매장 정보를 포함하고 있어야한다.
        expect(state, isA<SelectingStoreState>());
        expect((state as SelectingStoreState).stores, equals(expectedStores));
      });
    });

    group("매장 선택단계에서는,", () {
      test(
        "매장을 선택하면 메뉴 선택단계로 진입하며, 매장의 상품정보를 확인 할 수 있어야한다.",
        () async {
          // given: sut (system under test) 와 mockRepository 의 예상 결과값을 준비한다.
          final SelectingStoreState beforeState =
              SelectingStoreState(genRandomStores());
          final Store testingTarget =
              ([...beforeState.stores]..shuffle()).first;

          final ProductScreenBloc sut = ProductScreenBloc(
            initialState: beforeState,
          );

          // when: 유저가 매장을 선택하면,
          sut.add(SelectStore(testingTarget));

          // then: sut 의 상태가 변경되고,
          final ProductScreenState state = await sut.stream.first;

          // expect: 이는 메뉴 선택단계로 변경되며, 선택한 매장 정보를 포함하고 있어야한다.
          expect(state, isA<SelectingMenuState>());
          expect(
              state,
              equals(SelectingMenuState(
                  selectedStore: testingTarget, stores: beforeState.stores)));
        },
      );
    });

    group("메뉴 선택단계에서는,", () {
      test(
        "특정 상품을 선택하면, 옵션 선택단계로 진입하며, 상품의 자세한 옵션정보를 확인 할 수 있어야한다.",
        () async {
          // given: sut (system under test) 와 mockRepository 의 예상 결과값을 준비한다.
          final SelectingMenuState beforeState = SelectingMenuState(
            selectedStore: genRandomStore(),
            stores: genRandomStores(),
          );

          final Menu testingTarget =
              ([...beforeState.selectedStore.menus]..shuffle()).first;

          final ProductScreenBloc sut = ProductScreenBloc(
            initialState: beforeState,
          );

          // when: 유저가 메뉴를 선택하면,
          sut.add(SelectMenu(testingTarget));

          // then: sut 의 상태가 변경되고,
          final ProductScreenState state = await sut.stream.first;

          // expect: 이는 옵션 선택단계로 변경되며, 선택한 상품 정보를 포함하고 있어야한다.
          expect(state, isA<SelectingMenuOptionState>());
          expect(
              state,
              equals(SelectingMenuOptionState(
                selectedStore: beforeState.selectedStore,
                stores: beforeState.stores,
                selectedMenu: testingTarget,
              )));
        },
      );

      test(
        "매장 선택단계로 되돌아 갈 수 있어야한다.",
        () async {
          // given: sut (system under test) 와 mockRepository 의 예상 결과값을 준비한다.
          final SelectingMenuState beforeState = SelectingMenuState(
            selectedStore: genRandomStore(),
            stores: genRandomStores(),
          );

          final ProductScreenBloc sut = ProductScreenBloc(
            initialState: beforeState,
          );

          // when: 유저가 메뉴를 선택하면,
          sut.add(const CancelSelection());

          // then: sut 의 상태가 변경되고,
          final ProductScreenState state = await sut.stream.first;

          // expect: 이는 매장 선택단계로 변경되며, 이전 매장 정보를 포함하고 있어야한다.
          expect(state, isA<SelectingStoreState>());
          expect(state, equals(SelectingStoreState(beforeState.stores)));
        },
      );
    });

    group("옵션 선택단계에서는,", () {
      test(
        "상품의 여러 옵션을 선택 할 수 있어야한다.",
        () async {
          // given: sut (system under test) 와 mockRepository 의 예상 결과값을 준비한다.
          final SelectingMenuOptionState beforeState = SelectingMenuOptionState(
            selectedStore: genRandomStore(),
            stores: genRandomStores(),
            selectedMenu: genRandomMenu(),
          );

          final OptionGroups targetOptionGroup =
              (beforeState.selectedMenu.optionsGroups..shuffle()).first;
          final MenuOption testingOption =
              (targetOptionGroup.options..shuffle()).first;

          final ProductScreenBloc sut = ProductScreenBloc(
            initialState: beforeState,
          );

          // when: 유저가 옵션을 선택하면,
          sut.add(SelectOption(
            menu: beforeState.selectedMenu,
            optionGroup: targetOptionGroup,
            option: testingOption,
          ));

          // then: sut 의 상태가 변경되고,
          final ProductScreenState state = await sut.stream.first;

          // expect: 이는 옵션 선택단계로 변경되며, 선택한 옵션 정보를 포함하고 있어야한다.
          expect(state, isA<SelectingMenuOptionState>());
          expect(
            state,
            equals(
              SelectingMenuOptionState(
                selectedStore: beforeState.selectedStore,
                stores: beforeState.stores,
                selectedMenu: beforeState.selectedMenu,
                selectedOptions: {
                  ...beforeState.selectedOptions,
                }..update(
                    targetOptionGroup,
                    (final List<MenuOption> options) =>
                        [...options, testingOption],
                    ifAbsent: () => [testingOption],
                  ),
              ),
            ),
          );
        },
      );

      test(
        "상품의 여러 옵션을 해제 할 수 있어야한다.",
        () async {
          // given: sut (system under test) 와 mockRepository 의 예상 결과값을 준비한다.
          final Menu randomMenu = genRandomMenu();
          final OptionGroups targetOptionGroup =
              (randomMenu.optionsGroups..shuffle()).first;
          final MenuOption testingOption =
              (targetOptionGroup.options..shuffle()).first;
          final SelectingMenuOptionState beforeState = SelectingMenuOptionState(
              selectedStore: genRandomStore(),
              stores: genRandomStores(),
              selectedMenu: randomMenu,
              selectedOptions: {
                targetOptionGroup: [testingOption],
              });

          final ProductScreenBloc sut = ProductScreenBloc(
            initialState: beforeState,
          );

          // when: 유저가 옵션을 선택하면,
          sut.add(SelectOption(
            menu: beforeState.selectedMenu,
            optionGroup: targetOptionGroup,
            option: testingOption,
          ));

          // then: sut 의 상태가 변경되고,
          final ProductScreenState state = await sut.stream.first;

          // expect: 이는 옵션 선택단계로 변경되며, 선택한 옵션 정보를 포함하지 않고 있어야한다.
          expect(state, isA<SelectingMenuOptionState>());
          expect(
            (state as SelectingMenuOptionState)
                    .selectedOptions[targetOptionGroup]
                    ?.contains(testingOption) ??
                true,
            equals(false),
          );
        },
      );

      test(
        "선택한 상품을 확정하고 장바구니에 담을 수 있어야한다.",
        () async {
          // given: sut (system under test) 와 mockRepository 의 예상 결과값을 준비한다.
          final SelectingMenuOptionState beforeState = SelectingMenuOptionState(
            selectedStore: genRandomStore(),
            stores: genRandomStores(),
            selectedMenu: genRandomMenu(),
          );
          bool isSubmitted = false;
          void onSubmit(final SelectingMenuOptionState state) {
            isSubmitted = true;
          }

          final ProductScreenBloc sut = ProductScreenBloc(
            initialState: beforeState,
          );
          sut.onSubmit = onSubmit;

          // when: 유저가 상품을 확정하면,
          sut.add(const ConfirmSelection());

          // then: sut 의 상태가 변경되고,
          final ProductScreenState state = await sut.stream.first;

          // expect: 이는 상점 선택 상태로 변경되어야한다.
          expect(state, isA<SelectingStoreState>());
          // expect: onSubmit 콜백이 호출됨을 알 수 있다.
          expect(isSubmitted, equals(true));
        },
      );

      test(
        "상품 선택단계로 돌아갈 수 있어야한다.",
        () async {
          // given: sut (system under test) 와 mockRepository 의 예상 결과값을 준비한다.
          final SelectingMenuOptionState beforeState = SelectingMenuOptionState(
            selectedStore: genRandomStore(),
            stores: genRandomStores(),
            selectedMenu: genRandomMenu(),
          );

          final ProductScreenBloc sut = ProductScreenBloc(
            initialState: beforeState,
          );

          // when: 유저가 상품 선택단계로 돌아가면,
          sut.add(const CancelSelection());

          // then: sut 의 상태가 변경되고,
          final ProductScreenState state = await sut.stream.first;

          // expect: 이는 상품 선택 상태로 변경되며, 이전 상품 정보를 포함하고 있어야한다.
          expect(state, isA<SelectingMenuState>());
          expect(
            state,
            equals(
              SelectingMenuState(
                selectedStore: beforeState.selectedStore,
                stores: beforeState.stores,
              ),
            ),
          );
        },
      );
    });
  });
}
