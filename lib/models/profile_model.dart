// import 'dart:convert';

// import 'package:flutter/foundation.dart';

// class ProfileModel {
//   List profileList;
//   ProfileModel({
//     required this.profileList,
//   });

//   ProfileModel copyWith({
//     List? profileList,
//   }) {
//     return ProfileModel(
//       profileList: profileList ?? this.profileList,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'profileList': profileList,
//     };
//   }

//   factory ProfileModel.fromMap(Map<String, dynamic> map) {
//     return ProfileModel(
//       profileList: List.from(map['profileList']),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory ProfileModel.fromJson(String source) => ProfileModel.fromMap(json.decode(source));

//   @override
//   String toString() => 'ProfileModel(profileList: $profileList)';

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
  
//     return other is ProfileModel &&
//       listEquals(other.profileList, profileList);
//   }

//   @override
//   int get hashCode => profileList.hashCode;
// }
