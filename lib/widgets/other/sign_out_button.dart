import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gomate/misc/values.dart';

class CustomSignOutButton extends StatelessWidget {
  const CustomSignOutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: spacious,
          child: FloatingActionButton.extended(
            backgroundColor: theme.colorScheme.error,
            foregroundColor: theme.colorScheme.onError,
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            label: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_circle_right_outlined),
                SizedBox(width: 5,),
                Padding(
                  padding: comfortableVertical,
                  child: Text("Sign out"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
