import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_project/model/floors.dart';

final CollectionReference floorsCollection = Firestore.instance.collection('Floors');

class FloorFirestoreService {

  static final FloorFirestoreService _instance = new FloorFirestoreService.internal();

  factory FloorFirestoreService() => _instance;

  FloorFirestoreService.internal();

  Future<Floors> createFloors(String floorLevel, String collegeName) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(floorsCollection.document());

      final Floors floors = new Floors(ds.documentID, floorLevel, collegeName);
      final Map<String, dynamic> data = floors.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Floors.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getFloorList(String college, {int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = floorsCollection.where('collegeName',isEqualTo:college ).snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Future<dynamic> updateFloor(Floors floors) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(floorsCollection.document(floors.id));

      await tx.update(ds.reference, floors.toMap());
      return {'updated': true};
    };

    return Firestore.instance
        .runTransaction(updateTransaction)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  Future<dynamic> deleteFloor(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(floorsCollection.document(id));

      await tx.delete(ds.reference);
      return {'deleted': true};
    };

    return Firestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }
}
