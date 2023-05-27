import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../remote/entity/user_entity.dart';

class NotificationApi {
  String key = 'key=AAAAg4lulGk:APA91bE5yXKokZ4Jh6h5DSRdfbc7XJUZrhFeOYycPwnOErPtuV2BNtiQDs-SDKgw49rw7yaCJKR1nSamZK8Yex9GaQ7qrNXtAWJQPlDP9PNpq1fxufhkvJGKH3WaRUH0HJ-PhvbOaxYA';

  List<dynamic> _userListKey = [];

  List<dynamic> get userListKey => _userListKey;

  List<UserEntity> _userList = [];

  List<UserEntity> get userList => _userList;

  Future<void> filterKeyAdmin() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("user")
        .where('role', isEqualTo: 'admin')
        .get();
    List<UserEntity> users = querySnapshot.docs.map((docSnapshot) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      return UserEntity.fromJson(data);
    }).toList();
    _userList = users;
    _userListKey = userList
        .map((user) => user.tokenDevice)
        .toList()
        .expand((tokens) => tokens)
        .toList();
  }

  Future<void> createNotification(String title) async{
    filterKeyAdmin();
    final response =  await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': key,
      },
      body: jsonEncode({
        "registration_ids": userListKey,
        "notification": {
          // "body": "Bạn có đơn hàng mới",
          "title": title,
          "sound": true,
          // "image": "https://images.pexels.com/photos/14679216/pexels-photo-14679216.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
        },
        "data": {
          "content_type": "notification",
          "value": 2
        },
        "content_available": true,
        "priority": "high"
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print("Thành công");
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create notification.');
    }
  }
}