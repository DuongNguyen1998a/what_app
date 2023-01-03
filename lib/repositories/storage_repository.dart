import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageProvider = Provider(
  (ref) => StorageRepository(
    firebaseStorage: FirebaseStorage.instance,
  ),
);

class StorageRepository {
  final FirebaseStorage firebaseStorage;

  const StorageRepository({
    required this.firebaseStorage,
  });

  Future<String> uploadAvatarToStorage(String ref, File file) async {
    try {
      final uploadTask = firebaseStorage.ref().child(ref).putFile(file);

      final snapShot = await uploadTask;

      final imageUrl = await snapShot.ref.getDownloadURL();

      return imageUrl;
    }
    catch (e) {
      debugPrint(e.toString());
    }
    return '';
  }
}
