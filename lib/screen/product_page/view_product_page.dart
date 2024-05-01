import 'package:dart_scope_functions/dart_scope_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stdd_ex/domain_objects/store.dart';
import 'package:stdd_ex/repositroy/store_repo.dart';
import 'package:stdd_ex/screen/product_page/store_list_card.dart';
import 'package:stdd_ex/screen/product_page/view_model/bloc_product_screen.dart';
import 'package:stdd_ex/screen/product_page/view_model/product_screen_state.dart';
import 'package:stdd_ex/screen/product_page/view_model/product_screen_event.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (final BuildContext context) => ProductScreenBloc(
        storeRepository: StoreRepositoryImpl(),
        onSubmit: (_) => showDialog(
          context: context,
          builder: (BuildContext context) => const Text('장바구니 담기 완료'),
        ),
      )..add(const InitializeProductScreen()),
      child: BlocConsumer<ProductScreenBloc, ProductScreenState>(
        listener: (BuildContext context, ProductScreenState state) {
          state.also((final ProductScreenState it) {
            switch (it) {
              case Initial():
                break;
              case SelectingStoreState():
                break;
              case SelectingMenuState():
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (final BuildContext context) =>
                            const Text('메뉴 선택 페이지'),
                      ),
                    )
                    .then((value) => BlocProvider.of<ProductScreenBloc>(context)
                        .add(const CancelSelection()));
              case SelectingMenuOptionState():
              // TODO: Handle this case.
            }
          });
        },
        builder: (
          final BuildContext context,
          final ProductScreenState state,
        ) =>
            Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            title: Row(
              children: [
                const Text(
                  '피자',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Expanded(child: SizedBox.shrink()),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.home_outlined),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_cart_outlined),
                ),
              ],
            ),
            centerTitle: false,
          ),
          body: switch (state) {
            Initial() => const ProductScreenLoadingBody(),
            SelectingStoreState() ||
            SelectingMenuState() ||
            SelectingMenuOptionState() =>
              ProductScreenLoadedBody(
                state: state,
                onCardTap: (Store store) {
                  BlocProvider.of<ProductScreenBloc>(context)
                      .add(SelectStore(store));
                },
              ),
          },
        ),
      ),
    );
  }
}

class ProductScreenLoadingBody extends StatelessWidget {
  const ProductScreenLoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class ProductScreenLoadedBody extends StatelessWidget {
  final ProductScreenState state;
  final void Function(Store store) onCardTap;

  const ProductScreenLoadedBody({
    required this.state,
    required this.onCardTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.let(
        (final ProductScreenState it) => switch (it) {
          Initial() => 0,
          SelectingStoreState() => it.stores.length,
          SelectingMenuState() => it.stores.length,
          SelectingMenuOptionState() => it.stores.length,
        },
      ),
      itemBuilder: (
        final BuildContext context,
        final int idx,
      ) =>
          StoreListCard(
        store: state.let((it) => switch (it) {
              Initial() => StoreImpl.empty(),
              SelectingStoreState() =>
                it.stores.elementAtOrNull(idx) ?? StoreImpl.empty(),
              SelectingMenuState() =>
                it.stores.elementAtOrNull(idx) ?? StoreImpl.empty(),
              SelectingMenuOptionState() =>
                it.stores.elementAtOrNull(idx) ?? StoreImpl.empty(),
            }),
        onTap: onCardTap,
      ),
    );
  }
}
