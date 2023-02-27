class UserModel {
  String? uid;
  String? name;
  String? email;
  String? photoUrl;
  String? roles;
  String? creationTime;
  String? lastSignInTime;
  String? updatedTime;

  UserModel(
      {this.uid,
      this.name,
      this.email,
      this.photoUrl,
      this.roles,
      this.creationTime,
      this.lastSignInTime,
      this.updatedTime});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        uid: json['uid'],
        name: json['name'],
        email: json['email'],
        photoUrl: json['photoUrl'],
        roles: json['roles'],
        creationTime: json['creationTime'],
        lastSignInTime: json['lastSignInTime'],
        updatedTime: json['updatedTime']);
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "photoUrl": photoUrl,
      "roles": roles,
      "creationTime": creationTime,
      "lastSignInTime": lastSignInTime,
      "updatedTime": updatedTime
    };
    // data['uid'] = uid;
    // data['name'] = name;
    // data['email'] = email;
    // data['photoUrl'] = photoUrl;
    // data['roles'] = roles;
    // data['creationTime'] = creationTime;
    // data['lastSignInTime'] = lastSignInTime;
    // data['updatedTime'] = updatedTime;
    // return data;
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';

// class UserModel {
//   final String? uid;
//   final String? name;
//   final String? email;
//   final String? photoUrl;
//   final String? roles;
//   final String? creationTime;
//   final String? lastSignInTime;
//   final String? updatedTime;

//   UserModel(
//       {this.uid,
//       this.name,
//       this.email,
//       this.photoUrl,
//       this.roles,
//       this.creationTime,
//       this.lastSignInTime,
//       this.updatedTime});

//   factory UserModel.fromFireStore(
//       DocumentSnapshot<Map<String, dynamic>> snapshot,
//       SnapshotOptions? options) {
//     final data = snapshot.data();
//     return UserModel(
//       uid: data?['uid'],
//       name: data?['name'],
//       email: data?['email'],
//       photoUrl: data?['photoUrl'],
//       roles: data?['roles'],
//       creationTime: data?['creationTime'],
//       lastSignInTime: data?['lastSignInTime'],
//       updatedTime: data?['updatedTime'],
//     );
//   }

//   Map<String, dynamic> toFirestore() {
//     return {
//       if (uid != null) "uid": uid,
//       if (name != null) "name": name,
//       if (email != null) "email": email,
//       if (photoUrl != null) "photoUrl": photoUrl,
//       if (roles != null) "roles": roles,
//       if (creationTime != null) "creationTime": creationTime,
//       if (lastSignInTime != null) "lastSignInTime": lastSignInTime,
//       if (updatedTime != null) "updatedTime": updatedTime,
//     };
//   }
// }

