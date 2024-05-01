import 'package:flutter/material.dart';
import 'package:stdd_ex/domain_objects/store.dart';

class StoreListCard extends StatelessWidget {
  final Store store;
  final void Function(Store store) onTap;

  const StoreListCard({
    required this.store,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(store),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                store.thumbnail,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store.name,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 150,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.yellow),
                        Text(
                          store.rating.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(switch (store.reviewCount) {
                          < 100 => "(${store.reviewCount})",
                          >= 100 => "(${(store.reviewCount ~/ 100)}00+)",
                          int() => "(${store.reviewCount})",
                        }),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            store.description,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "최소 주문 ",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      TextSpan(
                        text: "${store.minOrderPrice.toString()}원",
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ]),
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
