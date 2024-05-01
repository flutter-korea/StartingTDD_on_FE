import 'package:dart_scope_functions/dart_scope_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stdd_ex/domain_objects/menu.dart';
import 'package:stdd_ex/domain_objects/store.dart';
import 'package:stdd_ex/screen/product_page/view_model/bloc_product_screen.dart';
import 'package:stdd_ex/screen/product_page/view_model/product_screen_event.dart';
import 'package:stdd_ex/screen/product_page/view_model/product_screen_state.dart';

class SelectMenuScreen extends StatelessWidget {
  final ProductScreenState state;

  const SelectMenuScreen({
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductScreenBloc, ProductScreenState>(
        bloc: ProductScreenBloc.instance,
        listener: (BuildContext context, state) {
          if (state is SelectingMenuOptionState &&
              (ModalRoute.of(context)?.isCurrent ?? false)) {
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (_) => const Text("SelectingMenuOptionState")))
                .then((value) =>
                    ProductScreenBloc.instance.add(const CancelSelection()));
          }
        },
        builder: (BuildContext context, state) {
          return state
              .let<Widget>((final ProductScreenState it) => switch (it) {
                    Initial() => const Placeholder(),
                    SelectingStoreState() => const Placeholder(),
                    SelectingMenuState() => SelectMenuScreenBody(
                        store: it.selectedStore,
                        menuList: it.selectedStore.menus,
                        onMenuTap: (final Menu menu) {
                          ProductScreenBloc.instance.add(SelectMenu(menu));
                        },
                      ),
                    SelectingMenuOptionState() => SelectMenuScreenBody(
                        store: it.selectedStore,
                        menuList: it.selectedStore.menus,
                        onMenuTap: (final Menu menu) {
                          ProductScreenBloc.instance.add(SelectMenu(menu));
                        },
                      ),
                  });
        });
  }
}

class SelectMenuScreenBody extends StatelessWidget {
  final Store store;
  final List<Menu> menuList;
  final void Function(Menu menu) onMenuTap;

  const SelectMenuScreenBody({
    required this.store,
    required this.menuList,
    required this.onMenuTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 150,
            automaticallyImplyLeading: false,
            title: Image.network(store.thumbnail),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        store.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      RatinIndicator(rating: store.rating),
                      Text(store.description),
                    ],
                  ),
                )
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  onTap: () => onMenuTap(menuList[index]),
                  title: Text(
                    menuList[index].description,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${menuList[index].description}\n',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "${menuList[index].defaultPrice.toString()}원",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  trailing: Image.network(menuList[index].thumbnail),
                );
              },
              childCount: menuList.length,
            ),
          ),
        ],
      ),
    );
  }
}

class RatinIndicator extends StatelessWidget {
  const RatinIndicator({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: switch (rating) {
        < 1 => [
            emptyStar,
            emptyStar,
            emptyStar,
            emptyStar,
            emptyStar,
          ],
        < 2 => [
            filledStar,
            emptyStar,
            emptyStar,
            emptyStar,
            emptyStar,
          ],
        < 3 => [
            filledStar,
            filledStar,
            emptyStar,
            emptyStar,
            emptyStar,
          ],
        < 4 => [
            filledStar,
            filledStar,
            filledStar,
            emptyStar,
            emptyStar,
          ],
        < 5 => [
            filledStar,
            filledStar,
            filledStar,
            filledStar,
            emptyStar,
          ],
        < 6 => [
            filledStar,
            filledStar,
            filledStar,
            filledStar,
            filledStar,
          ],
        double() => throw UnimplementedError(),
      }
        ..add(
          Text(
            rating.toString(),
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
    );
  }
}

const Icon filledStar = Icon(
  Icons.star,
  color: Colors.yellow,
);
const Icon emptyStar = Icon(
  Icons.star_border,
);
