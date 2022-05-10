import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
CollectionReference collectionReference = firebaseFirestore.collection('User');

double screenHeight = Get.height;

double height10 = screenHeight / 94.1;
