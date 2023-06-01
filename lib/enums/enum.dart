import '../views/constants/ui_strings.dart';

enum ViewState {
  success,
  busy,
  idle
}

enum OrderStatus {
  pending,
  confirmed,
  pendingDelivery,
  finish,
  cancel
}

extension OrderStatusExt on OrderStatus {
  String get name {
    const names = [UIStrings.pending, UIStrings.confirmed, UIStrings.delivery, UIStrings.finish, UIStrings.cancelOrder];
    return names[index];
  }
}