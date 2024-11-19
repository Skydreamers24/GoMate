import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gomate/backend/auth_gate.dart';
import 'package:gomate/misc/disability.dart';
import 'package:gomate/misc/gender.dart';
import 'package:gomate/misc/name.dart';

class Account extends StatelessWidget {
  const Account({
    super.key,
    this.child = const Scaffold(),
  });

  final Widget child;

  static AccountData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AccountData>()!;
  }

  @override
  Widget build(BuildContext context) {
    final authInfo = AuthInfo.of(context);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(authInfo.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.data() == null) {
            return AccountData(
              uid: authInfo.uid,
              child: const CircularProgressIndicator.adaptive(),
            );
          }

          final data = snapshot.data!.data()!;

          DateTime? dateOfBirth =
              ((data["dateOfBirth"] ?? Timestamp.now()) as Timestamp).toDate();
          if (dateOfBirth.year < 1900) {
            dateOfBirth = null;
          }

          Set<Disability> disabilities = ((data["disabilities"] ?? const [])
                  as List<dynamic>)
              .map((disability) => Disability.fromString(disability as String))
              .toSet();

          var newAccountData = AccountData(
            uid: authInfo.uid,
            name: Name((data["givenName"] ?? "") as String,
                (data["familyName"] ?? "") as String),
            dateOfBirth: dateOfBirth,
            email: (data["email"] ?? "") as String,
            gender: Gender.fromString((data["gender"] ?? "Male") as String),
            phoneNo: (data["phoneNo"] ?? "") as String,
            region: (data["region"] ?? "") as String,
            profileImage: (data["profileImage"] ?? "") as String,
            disabilities: disabilities,
            plannedJourneyIds:
                ((data["plannedJourneyIds"] ?? const []) as List<dynamic>)
                    .map((id) => id as String)
                    .toList(),
            child: child,
          );

          return newAccountData;
        });
  }
}

class AccountData extends InheritedWidget {
  final String uid;
  final String profileImage;
  final Name name;
  final Gender gender;
  final DateTime? dateOfBirth;
  final String email;
  final String phoneNo;
  final String region;
  final Set<Disability> disabilities;
  final List<String> plannedJourneyIds;

  int get age =>
      (DateTime.now().difference(dateOfBirth ?? DateTime.now()).inDays / 365.25)
          .floor();

  const AccountData(
      {super.key,
      this.uid = "",
      this.name = const Name("", ""),
      this.gender = Gender.male,
      this.dateOfBirth,
      this.email = "",
      this.phoneNo = "",
      this.region = "",
      this.profileImage = "",
      this.disabilities = const {},
      this.plannedJourneyIds = const [],
      super.child = const Placeholder()});

  AccountData copyWithEmpty() {
    return AccountData(
      name: const Name("", ""),
      dateOfBirth: DateTime.now(),
      gender: Gender.male,
      email: "",
      phoneNo: "",
      profileImage: "",
      uid: uid,
    );
  }

  AccountData copyWith(
      {String? uid,
      Name? name,
      Gender? gender,
      int? age,
      DateTime? dateOfBirth,
      String? email,
      String? phoneNo,
      String? region,
      String? profileImage,
      Widget? child,
      Set<Disability>? disabilities,
      List<String>? plannedJourneyIds}) {
    return AccountData(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      region: region ?? this.region,
      disabilities: disabilities ?? this.disabilities,
      profileImage: profileImage ?? this.profileImage,
      plannedJourneyIds: plannedJourneyIds ?? this.plannedJourneyIds,
      child: child ?? this.child,
    );
  }

  Future<Map<String, dynamic>> toMap() async {
    Timestamp dateOfBirthConverted =
        Timestamp.fromDate(dateOfBirth ?? DateTime.now());
    List<String> disabilitiesConverted =
        disabilities.map((disability) => disability.toString()).toList();
    return {
      "givenName": name.given,
      "familyName": name.family,
      "gender": gender.toString(),
      "dateOfBirth": dateOfBirthConverted,
      "email": email,
      "phoneNo": phoneNo,
      "region": region,
      "profileImage": profileImage,
      "disabilities": disabilitiesConverted,
      "plannedJourneyIds": plannedJourneyIds,
    };
  }

  @override
  bool updateShouldNotify(AccountData oldWidget) {
    return profileImage != oldWidget.profileImage ||
        name != oldWidget.name ||
        gender != oldWidget.gender ||
        dateOfBirth != oldWidget.dateOfBirth ||
        email != oldWidget.email ||
        phoneNo != oldWidget.phoneNo ||
        region != oldWidget.region ||
        disabilities != oldWidget.disabilities ||
        plannedJourneyIds != oldWidget.plannedJourneyIds ||
        uid != oldWidget.uid;
  }
}
