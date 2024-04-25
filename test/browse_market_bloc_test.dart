import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stdd_ex/screen/product_page/view_model/bloc_product_screen.dart';
import 'package:stdd_ex/screen/product_page/view_model/product_screen_event.dart';
import 'package:stdd_ex/screen/product_page/view_model/product_screen_state.dart';

import 'test_support.dart';

void main() {
  group("유저는 가게 조회 페이를 탐색하며,", () {
    group("초기 진입시에는,", () {
      blocTest<ProductScreenBloc, ProductScreenState>(
        "매장 정보를 불러 올 수 있어야한다.",
        // given
        build: () => ProductScreenBloc(const Initial()),
        // when
        act: (final ProductScreenBloc bloc) =>
            bloc.add(const InitializeProductScreen()),
        // expect : 실패를 예상하는 테스트케이스
        errors: () => [isA<UnimplementedError>()],
      );
    });

    group("매장 선택단계에서는,", () {
      blocTest<ProductScreenBloc, ProductScreenState>(
        "매장을 선택하면 메뉴 선택단계로 진입하며, 매장의 상품정보를 확인 할 수 있어야한다.",
        // given
        build: () => ProductScreenBloc(const Initial()),
        seed: () => SelectingStoreState(genRandomStores()),
        // when
        act: (final ProductScreenBloc bloc) =>
            bloc.add(SelectStore(genRandomStore())),
        // expect : 실패를 예상하는 테스트케이스
        errors: () => [isA<UnimplementedError>()],
      );
    });

    group("메뉴 선택단계에서는,", () {
      blocTest<ProductScreenBloc, ProductScreenState>(
        "특정 상품을 선택하면, 옵션 선택단계로 진입하며, 상품의 자세한 옵션정보를 확인 할 수 있어야한다.",
        // given
        build: () => ProductScreenBloc(const Initial()),
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
        build: () => ProductScreenBloc(const Initial()),
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
        build: () => ProductScreenBloc(const Initial()),
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
        build: () => ProductScreenBloc(const Initial()),
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
        build: () => ProductScreenBloc(const Initial()),
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
