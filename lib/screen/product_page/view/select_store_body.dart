import 'package:dart_scope_functions/dart_scope_functions.dart';
import 'package:flutter/material.dart';
import 'package:stdd_ex/domain_objects/store.dart';
import 'package:stdd_ex/screen/product_page/view/store_list_card.dart';
import 'package:stdd_ex/screen/product_page/view_model/product_screen_state.dart';

class SelectStoreBody extends StatelessWidget {
  final ProductScreenState state;
  final void Function(Store store) onCardTap;

  const SelectStoreBody({
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