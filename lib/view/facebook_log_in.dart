import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_data/constant.dart';
import 'package:firebase_data/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

class FacebookLogIn extends StatefulWidget {
  const FacebookLogIn({Key? key}) : super(key: key);

  @override
  State<FacebookLogIn> createState() => _FacebookLogInState();
}

class _FacebookLogInState extends State<FacebookLogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 70,
          width: 200,
          child: ElevatedButton(
            onPressed: () {
              faceBookLogIn();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(Icons.facebook),
                Text('FaceBook LogIn'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  faceBookLogIn() async {
    try {
      final result =
          await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.i.getUserData();
        final AuthCredential facebookCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);

        await firebaseAuth
            .signInWithCredential(facebookCredential)
            .whenComplete(
              () => collectionReference.doc(firebaseAuth.currentUser!.uid).set(
                {
                  'name': userData['name'],
                  'email': userData['email'],
                  'image': userData['picture']['data']['url'],
                },
              ),
            )
            .then(
              (value) => Get.to(
                () => const HomeScreen(),
              ),
            );
        print(userData);
        print(userData['name']);
        print(userData['email']);
        print(userData['url']);
      }
    } catch (e) {
      print(e);
    }
  }
}
