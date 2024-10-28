import 'package:balibo_station/feature/order/core/enum/order_status.dart';
import 'package:balibo_station/feature/order/model/order_item.dart';
import 'package:balibo_station/feature/order/presentation/bloc/get_active_orders/get_orders_bloc.dart';
import 'package:balibo_station/feature/order/presentation/bloc/make_order_ready/make_order_ready_bloc.dart';
import 'package:balibo_station/feature/order/presentation/widget/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersListWidget extends StatelessWidget {
  const OrdersListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        BlocBuilder<GetActiveOrdersBloc, GetOrdersState>(
          builder: (context, state) {
            if (state is GetOrdersSuccess) {
              final orders = state.orders;

              return _OrdersList(orders: orders);
            }
            if (state is GetOrdersFailure) {
              return SliverToBoxAdapter(
                child: Center(child: Text(state.message)),
              );
            }
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          },
        ),
        BlocBuilder<GetReadyOrdersBloc, GetOrdersState>(
          builder: (context, state) {
            if (state is GetOrdersSuccess) {
              final orders = state.orders;

              return _OrdersList(orders: orders);
            }
            if (state is GetOrdersFailure) {
              return SliverToBoxAdapter(
                child: Center(child: Text(state.message)),
              );
            }
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          },
        ),
      ],
    );
  }
}

class _OrdersList extends StatelessWidget {
  const _OrdersList({required this.orders});

  final List<OrderItem> orders;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16).w,
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final order = orders[index];
            return OrderTile(
              table: 'Masa ${order.tableNumber}',
              username: order.username,
              productName: order.name,
              productCount: order.quantity,
              isActive: order.status == OrderStatusEnum.active.value,
              onDismissed: (_) {
                if (order.id != null) {
                  context
                      .read<MakeOrderReadyBloc>()
                      .add(MakeOrderReady(orderId: order.id!));
                }
              },
            );
          },
          childCount: orders.length,
        ),
      ),
    );
  }
}
