import 'package:sahami_app/data/remote/entity/user_entity.dart';

class OrderEntity {
  String orderId;
  UserEntity userEntity;
  double? orderAmount;
  String? orderStatus;
  String? paymentStatus;
  String? orderNote;
  String? createAt;
  String? updateAt;
  double? deliveryCharge;
  List<dynamic> items;
  String address;

  OrderEntity({
    this.orderId = '',
    required this.userEntity,
    this.orderAmount,
    this.orderStatus = 'Đơn hàng mới',
    this.paymentStatus = "Chưa thanh toán",
    this.orderNote,
    this.createAt,
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
      createAt: json['createAt'],
      updateAt: json['updateAt'],
      deliveryCharge: json['deliveryCharge'],
      items: List<dynamic>.from(json['items']),
      address: json['address']
    );
  }
}