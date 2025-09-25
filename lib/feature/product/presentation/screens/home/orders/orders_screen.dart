import 'package:flutter/material.dart';
import 'package:mygarja/feature/product/presentation/widgets/default_app_bar.dart';
import 'package:mygarja/core/asset_constants.dart' as asset;
import 'package:mygarja/controllers/order_controller.dart';
import 'package:mygarja/models/api/api_order.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routename = '/orders-screen';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch orders when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderController>(context, listen: false).fetchOrderHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar('My Orders'),
      body: Consumer<OrderController>(
        builder: (context, orderController, child) {
          if (orderController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (orderController.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error loading orders',
                    style: asset.introStyles(18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    orderController.error!,
                    style: asset.introStyles(14, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      orderController.fetchOrderHistory();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final List<ApiOrder> orders = orderController.orders;

          if (orders.isEmpty) {
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
                    'No orders yet',
                    style: asset.introStyles(24, color: Colors.grey[600]!),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Your orders will appear here',
                    style: asset.introStyles(16, color: Colors.grey[500]!),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return _buildOrderCard(order);
            },
          );
        },
      ),
    );
  }

  Widget _buildOrderCard(ApiOrder order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order #${order.id}',
                      style: asset.introStyles(18),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDate(order.orderDate),
                      style: asset.introStyles(14, color: Colors.grey),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getOrderStatusColor(order.status),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    order.status,
                    style: asset.introStyles(12, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          // Order details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(order.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.productName,
                            style: asset.introStyles(16),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Amount',
                      style: asset.introStyles(16, color: Colors.grey),
                    ),
                    Text(
                      '₹${order.totalAmount.toStringAsFixed(2)}',
                      style: asset.introStyles(18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      // Assuming dateStr is in format "YYYY-MM-DD"
      final parts = dateStr.split('-');
      if (parts.length == 3) {
        final months = [
          'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
          'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
        ];
        final month = int.tryParse(parts[1]) ?? 1;
        final day = parts[2];
        return '${months[month - 1]} $day, ${parts[0]}';
      }
      return dateStr;
    } catch (e) {
      return dateStr;
    }
  }

  Color _getOrderStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return Colors.orange;
      case 'CONFIRMED':
        return Colors.blue;
      case 'SHIPPED':
        return Colors.purple;
      case 'DELIVERED':
        return Colors.green;
      case 'CANCELLED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}