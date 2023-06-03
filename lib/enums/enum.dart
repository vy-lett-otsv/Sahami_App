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
  String get nameOrder {
    const names = [UIStrings.pending, UIStrings.confirmed, UIStrings.delivering, UIStrings.finish, UIStrings.cancelOrder];
    return names[index];
  }
}

enum TimeOption {
  day,
  week,
  month,
  year
}

extension TimeOptionExt on TimeOption {
  String get nameTime {
    const names = ["Hôm nay", "Tuần", "Tháng", "Năm"];
    final index = this.index;
    return names[index];
  }
}