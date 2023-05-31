import 'package:sahami_app/data/remote/entity/user_entity.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';

class OrderEntity {
  String orderId;
  UserEntity userEntity;
  double orderAmount;
  String orderStatus;
  String paymentStatus;
  String? orderNote;
  String? createAt;
  String? createAtTime;
  String? createAtMonth;
  String? createAtYear;
  DateTime? updateAt;
  double? deliveryCharge;
  List<dynamic> items;
  String address;

  OrderEntity(
      {this.orderId = '',
      required this.userEntity,
      this.orderAmount = 0,
      this.orderStatus = UIStrings.pending,
      this.paymentStatus = UIStrings.pendingPayment,
      this.orderNote,
      this.createAt,
      this.createAtTime,
      this.createAtMonth,
      this.createAtYear,
      this.updateAt,
      this.deliveryCharge,
      required this.items,
      required this.address});

  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'userEntity': userEntity.toJson(),
        'orderAmount': orderAmount,
        'orderStatus': orderStatus,
        'paymentStatus': paymentStatus,
        'orderNote': orderNote,
        'note': orderNote,
        'createAt': createAt,
        'createAtTime': createAtTime,
        'createAtMonth': createAtMonth,
        'createAtYear': createAtYear,
        'updateAt': updateAt,
        'deliveryCharge': deliveryCharge,
        'items': items,
        'address': address
      };

  factory OrderEntity.fromJson(Map<String, dynamic> json) {
    return OrderEntity(
        orderId: json['orderId'],
        userEntity: UserEntity.fromJson(json['userEntity']),
        orderAmount: json['orderAmount'].toDouble(),
        orderStatus: json['orderStatus'],
        paymentStatus: json['paymentStatus'],
        orderNote: json['orderNote'],
        createAt: json["createAt"],
        createAtMonth: json["createAtMonth"],
        createAtYear: json["createAtYear"],
        createAtTime: json["createAtTime"],
        updateAt: json['updateAt'],
        deliveryCharge: json['deliveryCharge'],
        items: List<dynamic>.from(json['items']),
        address: json['address']);
  }

  @override
  String toString() {
    return 'OrderEntity{orderId: $orderId, orderAmount: $orderAmount}';
  }
}
