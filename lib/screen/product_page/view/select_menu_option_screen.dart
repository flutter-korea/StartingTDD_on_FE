import 'package:dart_scope_functions/dart_scope_functions.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stdd_ex/domain_objects/menu_option.dart';
import 'package:stdd_ex/domain_objects/option_groups.dart';
import 'package:stdd_ex/screen/product_page/view_model/bloc_product_screen.dart';
import 'package:stdd_ex/screen/product_page/view_model/product_screen_event.dart';
import 'package:stdd_ex/screen/product_page/view_model/product_screen_state.dart';

class SelectMenuOptionScreen extends StatelessWidget {
  final ProductScreenState state;

  const SelectMenuOptionScreen({
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: ProductScreenBloc.instance,
      listener: (
        final BuildContext context,
        final ProductScreenState state,
      ) {},
      builder: (
        final BuildContext context,
        final ProductScreenState state,
      ) {
        return state.let((final ProductScreenState it) => switch (it) {
              Initial() => const Placeholder(),
              SelectingStoreState() => const Placeholder(),
              SelectingMenuState() => const Placeholder(),
              SelectingMenuOptionState() => SelectMenuOptionScreenBody(
                  state: it,
                ),
            });
      },
    );
  }
}

class SelectMenuOptionScreenBody extends StatelessWidget {
  final SelectingMenuOptionState state;

  const SelectMenuOptionScreenBody({
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 200,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                        state.selectedMenu.thumbnail,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 15),
                              child: Text(
                                state.selectedMenu.description,
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Divider(
                              thickness: 10,
                              color: Colors.black12,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 15,
                              ),
                              child: Text(
                                '가격: ${state.selectedMenu.defaultPrice.toString()}원',
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Divider(
                              thickness: 10,
                              color: Colors.black12,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 15,
                              ),
                              child: Text(
                                '옵션 선택',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Divider(
                              thickness: 10,
                              color: Colors.black12,
                            ),
                            ...state.selectedMenu.optionsGroups.map(
                              (final OptionGroups optionGroup) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    optionGroup.description,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  ...optionGroup.options.map(
                                    (final MenuOption option) =>
                                        CheckboxListTile(
                                      title: Text(option.description),
                                      secondary: option.price > Decimal.zero
                                          ? Text(
                                              '${option.price.toString()} 원',
                                            )
                                          : const Text('무료'),
                                      value: state.selectedOptions[optionGroup]
                                              ?.contains(option) ??
                                          false,
                                      onChanged: (final bool? value) {
                                        ProductScreenBloc.instance
                                            .add(SelectOption(
                                          menu: state.selectedMenu,
                                          optionGroup: optionGroup,
                                          option: option,
                                        ));
                                      },
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 10,
                                    color: Colors.black12,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      children: [
                        const Text(
                          '배달 최소금액',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '${state.selectedStore.minOrderPrice.toString()}원',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          ProductScreenBloc.instance
                              .add(const ConfirmSelection());
                        },
                        child: Text(
                            '${state.selectedMenu.defaultPrice + state.selectedOptions.values.fold<List<MenuOption>>([], (final List<MenuOption> prev, final List<MenuOption> element) => [
                                  ...prev,
                                  ...element
                                ]).fold(Decimal.zero, (prev, ele) => prev + ele.price)}원 담기'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
