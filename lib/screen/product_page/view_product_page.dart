import 'package:dart_scope_functions/dart_scope_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stdd_ex/domain_objects/store.dart';
import 'package:stdd_ex/repositroy/store_repo.dart';
import 'package:stdd_ex/screen/product_page/view/select_menu_screen.dart';
import 'package:stdd_ex/screen/product_page/view/select_store_body.dart';
import 'package:stdd_ex/screen/product_page/view_model/bloc_product_screen.dart';
import 'package:stdd_ex/screen/product_page/view_model/product_screen_state.dart';
import 'package:stdd_ex/screen/product_page/view_model/product_screen_event.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    ProductScreenBloc.instance.add(InitializeProductScreen(
        storeRepository: StoreRepositoryImpl(),
        onSubmit: (_) => showDialog(
              context: context,
              builder: (BuildContext context) => const Text('장바구니 담기 완료'),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductScreenBloc, ProductScreenState>(
      bloc: ProductScreenBloc.instance,
      listener: (BuildContext context, ProductScreenState state) {
        state.also((final ProductScreenState it) {
          if (it is SelectingMenuState &&
              (ModalRoute.of(context)?.isCurrent ?? false)) {
            Navigator.of(context)
                .push(MaterialPageRoute(
                  builder: (_) => SelectMenuScreen(state: state),
                ))
                .then((value) =>
                    ProductScreenBloc.instance.add(const CancelSelection()));
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
            SelectStoreBody(
              state: state,
              onCardTap: (Store store) {
                ProductScreenBloc.instance.add(SelectStore(store));
              },
            ),
        },
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
