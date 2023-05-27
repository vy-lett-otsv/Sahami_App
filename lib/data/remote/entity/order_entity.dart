import 'package:sahami_app/data/remote/entity/user_entity.dart';

class OrderEntity {
  String orderId;
  UserEntity userEntity;
  double orderAmount;
  String? orderStatus;
  String? paymentStatus;
  String? orderNote;
  String? createAt;
  String? createAtTime;
  DateTime? updateAt;
  double? deliveryCharge;
  List<dynamic> items;
  String address;

  OrderEntity(
      {this.orderId = '',
      required this.userEntity,
      this.orderAmount = 0,
      this.orderStatus = 'Chờ xác nhận',
      this.paymentStatus = "",
      this.orderNote,
      this.createAt,
      this.createAtTime,
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
        'updateAt': updateAt,
        'deliveryCharge': deliveryCharge,
        'items': items,
        'address': address
      };

  factory OrderEntity.fromJson(Map<String, dynamic> json) {
    return OrderEntity(
        orderId: json['orderId'],
        userEntity: UserEntity.fromJson(json['userEntity']),
        orderAmount: json['orderAmount'],
        orderStatus: json['orderStatus'],
        paymentStatus: json['paymentStatus'],
        orderNote: json['orderNote'],
        createAt: json["createAt"],
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
