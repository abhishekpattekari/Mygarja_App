import 'package:flutter/material.dart';
import 'package:mygarja/core/asset_constants.dart' as asset;
import 'package:mygarja/controllers/order_controller.dart';
import 'package:mygarja/models/api/api_order.dart';
import 'package:provider/provider.dart';

class OnGoingOrder extends StatelessWidget {
  const OnGoingOrder({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderController>(
      builder: (context, orderController, child) {
        // Filter orders by status - ongoing orders are those that are not completed
        final ongoingOrders = orderController.orders.where((order) => 
          order.status != 'DELIVERED' && order.status != 'CANCELLED').toList();
        
        if (orderController.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        
        if (ongoingOrders.isEmpty) {
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
        }
        
        return ListView.builder(
          itemCount: ongoingOrders.length,
          itemBuilder: (context, index) {
            final order = ongoingOrders[index];
            return OrderCard(order: order);
          },
        );
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  final ApiOrder order;
  
  const OrderCard({Key? key, required this.order}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order.id}',
                  style: asset.introStyles(18),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order.status),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    order.status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              order.productName,
              style: asset.introStyles(16),
            ),
            const SizedBox(height: 4),
            Text(
              'Quantity: ${order.quantity}',
              style: asset.introStyles(14, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              'Size: ${order.size}',
              style: asset.introStyles(14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${order.totalAmount.toStringAsFixed(2)}',
                  style: asset.introStyles(16),
                ),
                Text(
                  order.orderDate,
                  style: asset.introStyles(14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case 'PENDING':
        return Colors.orange;
      case 'CONFIRMED':
        return Colors.blue;
      case 'PROCESSING':
        return Colors.purple;
      case 'SHIPPED':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}