import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart'
    hide EmailVerifiedAction;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gomate/backend/account.dart';
import 'package:gomate/misc/values.dart';
import 'package:gomate/pages/edit_profile_page.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key, required this.child});

  final Widget child;

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // Not logged in
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
            ],
            headerBuilder: (context, constraints, shrinkOffset) => Padding(
              padding: spacious,
              child: SizedBox(
                  width: 100,
                  height: 100,
                  child: SvgPicture.asset("assets/logo_square.svg")),
            ),
            sideBuilder: (context, constraints) => Padding(
              padding: spacious,
              child: SizedBox(
                  width: 100,
                  height: 100,
                  child: SvgPicture.asset("assets/logo_square.svg")),
            ),
            showPasswordVisibilityToggle: true,
          );
        }

        var user = snapshot.data!;
        var uid = user.uid;
        var email = user.email ?? "";
        var db = FirebaseFirestore.instance;

        return StreamBuilder(
            stream: db.collection("users").doc(uid).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.hasError) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
              }
              final doc = snapshot.data!;
              if (!doc.exists) {
                return EditProfilePage(
                  account: AccountData(
                    uid: uid,
                    dateOfBirth: DateTime.now(),
                    email: email,
                  ),
                  hasBackButton: false,
                  onSave: update,
                );
              }
              return AuthInfo(
                  uid: uid,
                  email: email,
                  child: widget.child);
            });
      },
    );
  }
}

class AuthInfo extends InheritedWidget {
  final String uid;
  final String email;
  const AuthInfo(
      {super.key,
      this.uid = "",
      this.email = "",
      required super.child});
  static AuthInfo of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthInfo>()!;
  }

  AuthInfo copyWith(
      {String? uid,
      String? email,
      void Function()? updateAuthGate,
      Widget? child}) {
    return AuthInfo(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      child: child ?? this.child,
    );
  }

  @override
  bool updateShouldNotify(AuthInfo oldWidget) {
    return uid != oldWidget.uid || email != oldWidget.email;
  }
}
