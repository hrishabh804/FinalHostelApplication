import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_project/model/rooms.dart';
import 'package:hostel_project/model/update_room_model.dart';

final CollectionReference roomsCollection = Firestore.instance.collection('Rooms');

class RoomsFirestoreService {

  static final RoomsFirestoreService _instance = new RoomsFirestoreService.internal();

  factory RoomsFirestoreService() => _instance;

  RoomsFirestoreService.internal();

  Future<Rooms> createRooms(String roomNumber, String collegeName,String floorLevel,List<String> list,int maxRoomCapacity) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(roomsCollection.document());

      final Rooms rooms = new Rooms(ds.documentID,collegeName,roomNumber,floorLevel,list,maxRoomCapacity);
      final Map<String, dynamic> data = rooms.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Rooms.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getRoomList(String college,String floor,{int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = roomsCollection.where('collegeName',isEqualTo: college).where('floorLevel',isEqualTo: floor).snapshots();
    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }
  Stream<QuerySnapshot> getAllRoomList(String college,{int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = roomsCollection.where('collegeName',isEqualTo: college).snapshots();
    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Future<dynamic> updateRooms(UpdateRooms rooms) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(roomsCollection.document(rooms.id));

      await tx.update(ds.reference, rooms.toMap());
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

  Future<dynamic> deleteRooms(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(roomsCollection.document(id));

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
