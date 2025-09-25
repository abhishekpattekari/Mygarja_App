import 'package:flutter/material.dart';
import 'package:mygarja/core/asset_constants.dart' as asset;

class CartProductCard extends StatelessWidget {
  final int productQuantity;
  final String productId;
  final String cartImageUrl;
  final String title;
  final bool isDelete;
  final String price;
  
  const CartProductCard(
    this.isDelete, {
    Key? key,
    required this.productQuantity,
    required this.productId,
    required this.cartImageUrl,
    required this.title,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      padding: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(1, 1.1))
          ],
          color: Colors.white),
      child: Row(
        children: [
          Container(
            height: double.infinity,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(cartImageUrl), fit: BoxFit.cover)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 160,
                        child: Text(
                          title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: asset.introStyles(22),
                        ),
                      ),
                      if (isDelete)
                        InkWell(
                          onTap: () {
                            // Show simple confirmation dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Remove Item'),
                                  content: Text('Are you sure you want to remove $title from your cart?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Show success message
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('$title removed from cart'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Remove', style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 24,
                          ),
                        )
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.circle, size: 16),
                      Text(
                        '   Color',
                        style: asset.introStyles(16, color: Colors.black54),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₹" + price,
                        style: asset.introStyles(24),
                      ),
                      Container(
                          width: isDelete ? 90 : 30,
                          padding:
                              const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (isDelete) const Icon(Icons.remove),
                              Text(
                                productQuantity.toString(),
                                style: asset.introStyles(20),
                              ),
                              if (isDelete) const Icon(Icons.add)
                            ],
                          ))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
