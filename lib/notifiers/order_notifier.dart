import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/order.dart';

class OrderState {
  final List<OrderModel> allOrders;
  final List<OrderModel> filteredOrders;
  final OrderStatus? filterStatus;
  final DateTimeRange? filterDateRange;

  OrderState({
    required this.allOrders,
    required this.filteredOrders,
    this.filterStatus,
    this.filterDateRange,
  });

  OrderState copyWith({
    List<OrderModel>? allOrders,
    List<OrderModel>? filteredOrders,
    OrderStatus? filterStatus,
    DateTimeRange? filterDateRange,
  }) {
    return OrderState(
      allOrders: allOrders ?? this.allOrders,
      filteredOrders: filteredOrders ?? this.filteredOrders,
      filterStatus: filterStatus,
      filterDateRange: filterDateRange,
    );
  }
}

class OrderNotifier extends StateNotifier<OrderState> {
  OrderNotifier() : super(OrderState(allOrders: [], filteredOrders: []));

  void addOrder(OrderModel order) {
    final newList = [...state.allOrders, order];
    state = state.copyWith(allOrders: newList);
    _applyFilters();
  }

  void removeOrder(String id) {
    final newList = state.allOrders.where((o) => o.id != id).toList();
    state = state.copyWith(allOrders: newList);
    _applyFilters();
  }

  void setFilterStatus(OrderStatus? status) {
    state = state.copyWith(filterStatus: status);
    _applyFilters();
  }

  void setFilterDateRange(DateTimeRange? range) {
    state = state.copyWith(filterDateRange: range);
    _applyFilters();
  }

  void _applyFilters() {
    var filtered = state.allOrders;

    if (state.filterStatus != null) {
      filtered = filtered.where((o) => o.status == state.filterStatus).toList();
    }

    if (state.filterDateRange != null) {
      filtered = filtered.where((o) {
        return o.orderDate.isAfter(
              state.filterDateRange!.start.subtract(const Duration(days: 1)),
            ) &&
            o.orderDate.isBefore(
              state.filterDateRange!.end.add(const Duration(days: 1)),
            );
      }).toList();
    }

    state = state.copyWith(filteredOrders: filtered);
  }
}

final orderNotifierProvider = StateNotifierProvider<OrderNotifier, OrderState>((
  ref,
) {
  return OrderNotifier();
});
