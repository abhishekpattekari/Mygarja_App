import 'package:flutter/material.dart';
import 'package:mygarja/core/asset_constants.dart' as asset;
import 'package:mygarja/controllers/order_controller.dart';
import 'package:mygarja/models/api/api_order.dart';
import 'package:provider/provider.dart';

class CompletedOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderController>(
      builder: (context, orderController, child) {
        // Filter orders by status - completed orders are those that are delivered or cancelled
        final completedOrders = orderController.orders.where((order) => 
          order.status == 'DELIVERED' || order.status == 'CANCELLED').toList();
        
        if (orderController.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        
        if (completedOrders.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(asset.empty_cart_error, width: 300),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'No Completed Orders Yet',
                  textAlign: TextAlign.center,
                  style: asset.introStyles(22, color: Colors.black54),
                )
              ]),
            )
          );
        }
        
        return ListView.builder(
          itemCount: completedOrders.length,
          itemBuilder: (context, index) {
            final order = completedOrders[index];
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
      case 'DELIVERED':
        return Colors.green;
      case 'CANCELLED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}