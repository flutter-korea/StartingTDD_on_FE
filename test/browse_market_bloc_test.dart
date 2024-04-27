import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
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
        final ProductScreenBloc sut =
            ProductScreenBloc(storeRepository: mockStoreRepository);

        // when: 유저가 페이지에 진입해, 초기화 이벤트를 발생시킨면.
        sut.add(const InitializeProductScreen());

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
            storeRepository: mockStoreRepository,
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
      blocTest<ProductScreenBloc, ProductScreenState>(
        "특정 상품을 선택하면, 옵션 선택단계로 진입하며, 상품의 자세한 옵션정보를 확인 할 수 있어야한다.",
        // given
        build: () => ProductScreenBloc(storeRepository: mockStoreRepository),
        seed: () => SelectingMenuState(
          selectedStore: genRandomStore(),
          stores: genRandomStores(),
        ),
        // when
        act: (final ProductScreenBloc bloc) =>
            bloc.add(SelectMenu(genRandomMenu())),
        // expect : 실패를 예상하는 테스트케이스
        errors: () => [isA<UnimplementedError>()],
      );

      blocTest<ProductScreenBloc, ProductScreenState>(
        "매장 선택단계로 되돌아 갈 수 있어야한다.",
        // given
        build: () => ProductScreenBloc(storeRepository: mockStoreRepository),
        seed: () => SelectingStoreState(genRandomStores()),
        // when
        act: (final ProductScreenBloc bloc) =>
            bloc.add(const CancelSelection()),
        // expect : 실패를 예상하는 테스트케이스
        errors: () => [isA<UnimplementedError>()],
      );
    });

    group("옵션 선택단계에서는,", () {
      blocTest<ProductScreenBloc, ProductScreenState>(
        "상품의 여러 옵션을 선택/해제 할 수 있어야한다.",
        // given
        build: () => ProductScreenBloc(storeRepository: mockStoreRepository),
        seed: () => SelectingStoreState(genRandomStores()),
        // when
        act: (final ProductScreenBloc bloc) => bloc.add(SelectOption(
          menu: genRandomMenu(),
          optionGroup: genRandomOptionGroups(),
          option: genRandomMenuOption(),
        )),
        // expect : 실패를 예상하는 테스트케이스
        errors: () => [isA<UnimplementedError>()],
      );

      blocTest<ProductScreenBloc, ProductScreenState>(
        "선택한 상품을 확정하고 장바구니에 담을 수 있어야한다.",
        // given
        build: () => ProductScreenBloc(storeRepository: mockStoreRepository),
        seed: () => SelectingStoreState(genRandomStores()),
        // when
        act: (final ProductScreenBloc bloc) =>
            bloc.add(const ConfirmSelection()),
        // expect : 실패를 예상하는 테스트케이스
        errors: () => [isA<UnimplementedError>()],
      );

      blocTest<ProductScreenBloc, ProductScreenState>(
        "상품 선택단계로 돌아갈 수 있어야한다.",
        // given
        build: () => ProductScreenBloc(storeRepository: mockStoreRepository),
        seed: () => SelectingStoreState(genRandomStores()),
        // when
        act: (final ProductScreenBloc bloc) =>
            bloc.add(const CancelSelection()),
        // expect : 실패를 예상하는 테스트케이스
        errors: () => [isA<UnimplementedError>()],
      );
    });
  });
}
