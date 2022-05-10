import 'package:firebase_data/constant.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? image;

  String? name;

  String? email;

  getData() async {
    final user =
        await collectionReference.doc(firebaseAuth.currentUser!.uid).get();
    Map<String, dynamic>? getUserData = user.data();
    setState(() {
      image = getUserData!['image'];
      email = getUserData['email'];
      name = getUserData['name'];
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('$image'),
            SizedBox(
              height: 20,
            ),
            Text('$name'),
            SizedBox(
              height: 20,
            ),
            Text('$email'),
          ],
        ),
      ),
    );
  }
}
