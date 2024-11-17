import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gomate/backend/account.dart';
import 'package:gomate/misc/journey.dart';

void toDatabaseSync(AccountData account) async {
  print("Sync up");
  var db = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();
  final accountMap = await account.toMap();
  var profileImageRef = storageRef.child("profileImages/${account.uid}");
  try {
    if ((accountMap["profileImage"] as String).isNotEmpty) {
      if (!(accountMap["profileImage"] as String).startsWith("https://")) {
        var profileImageFile = File(accountMap["profileImage"] as String);
        await profileImageRef.putFile(profileImageFile);
        final downloadURL = await profileImageRef.getDownloadURL();
        accountMap["profileImage"] = downloadURL;
      }
    } else {
      accountMap["profileImage"] = "";
    }
    db.collection("users").doc(account.uid).set(accountMap).onError(
        (error, stacktrace) =>
            print("Failed to set accountMap: $error \n $stacktrace"));
  } on FirebaseException catch (error) {
    print("Could not upload profileImage to Firebase Storage: $error");
  }
}

void addJourney(String journeyId, Journey journey) async {
  print("Add journey");
  var db = FirebaseFirestore.instance;
  final journeyMap = journey.toMap();
  db
      .collection("journeys")
      .doc("journeyList")
      .update({journeyId: journeyMap}).onError((error, stacktrace) =>
          print("Failed to update journeyId $journeyId: $error \n $stacktrace"));
}
