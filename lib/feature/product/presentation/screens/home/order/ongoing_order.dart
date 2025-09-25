import 'package:flutter/material.dart';
import 'package:mygarja/core/asset_constants.dart' as asset;

class OnGoingOrder extends StatelessWidget {
  const OnGoingOrder({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        // Show empty state for orders
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_bag_outlined,
                size: 100,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 20),
              Text(
                'No ongoing orders',
                style: asset.introStyles(24, color: Colors.grey[600]!),
              ),
              const SizedBox(height: 10),
              Text(
                'Your recent orders will appear here',
                style: asset.introStyles(16, color: Colors.grey[500]!),
              ),
            ],
          ),
        );
      },
    );
  }
}
