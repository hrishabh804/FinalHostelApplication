
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_project/model/user_role.dart';

final CollectionReference roomsCollection = Firestore.instance.collection('UserRoles');


class RoleFirestoreService {

  static final RoleFirestoreService _instance = new RoleFirestoreService
      .internal();

  factory RoleFirestoreService() => _instance;

  RoleFirestoreService.internal();

  Future<UserRoles> createRoleStudent(String name, String email, String college,
      String role,String uid) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(roomsCollection.document());

      final UserRoles rooms = new UserRoles(college, email, name, role,uid);
      final Map<String, dynamic> data = rooms.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return UserRoles.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  updateUserRole(String email,String uid,{int offset, int limit}) async{
    print(email);
    print(uid);
    await Firestore.instance.collection('UserRoles').where(
        'email', isEqualTo: email).getDocuments()
        .then((value) {
      value.documents.forEach((f) =>
      {
        print(f.documentID),
        Firestore.instance.collection('UserRoles')
            .document(f.documentID)
            .updateData({"uid": uid})
      });
    });
  }
  deleteFromUserRole(String email) async{
    print(email);
    await Firestore.instance.collection('UserRoles').where('email',isEqualTo: email).getDocuments().then((value){
      value.documents.forEach((f) async =>
      {
        print(f.documentID),
        await Firestore.instance.collection('UserRoles').document(f.documentID).delete()

      });
    });

  }
}