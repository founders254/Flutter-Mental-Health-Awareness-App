import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:calm/models/resources_model.dart';



Future<List<Resource>> fetchResources() async {
  final querySnapshot = await FirebaseFirestore.instance.collection('resources').get();
  return querySnapshot.docs.map((doc) => Resource.fromJson(doc.data())).toList();
}
