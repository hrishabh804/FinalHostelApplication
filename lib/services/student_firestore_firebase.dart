
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_project/model/Student.dart';


final CollectionReference studentCollection = Firestore.instance.collection('Students');
class StudentFirestoreService {
  static final StudentFirestoreService _instance = new StudentFirestoreService
      .internal();

  factory StudentFirestoreService() => _instance;

  StudentFirestoreService.internal();

  Future<Students> createStudent(String usn, String name, String roomNumber, String floor, String collegeName,var imageURL,String email,String branch, String phoneNumber,
      String fatherName,
      String fatherNumber,
      String motherName,
      String motherNumber,
      String permanentAddress,
      String dueHostelFees) {
    print(email);
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(studentCollection.document());
      final Students student = new Students(ds.documentID, usn, name, roomNumber, floor, collegeName,imageURL,email,branch,phoneNumber,fatherName,fatherNumber,motherName,motherNumber,permanentAddress,dueHostelFees);
      final Map<String, dynamic> data = student.toMap();
      await tx.set(ds.reference, data);
      return data;
    };
    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Students.fromMap(mapData);
    }).catchError((error) {
      print(error);
      return null;
    });
  }

  Stream<QuerySnapshot> getStudentList(String roomNumber, String floor,String college,{int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = studentCollection.where(
        'collegeName', isEqualTo: college).where('floor',isEqualTo: floor).where('roomNumber',isEqualTo: roomNumber).snapshots();
    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }
  Stream<QuerySnapshot> getAllStudentList(String college,{int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = studentCollection.where(
        'collegeName', isEqualTo: college).snapshots();
    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }
  Stream<QuerySnapshot> getLoggedStudent(String email,{int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = studentCollection.where(
        'email', isEqualTo:email).snapshots();
    print(email);
    print('upar wala email');
    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }


  Future<dynamic> updateStudent(Students student) {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(
          studentCollection.document(student.id));
      await tx.update(ds.reference, student.toMap());
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

  Future<dynamic> deleteStudents(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(studentCollection.document(id));

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
  Future<String> addStudentToRoom(String floor,String college, String room, String name) async {
    String str;
    print(floor+'floors');
    print(college+'college');
    print(name+'name');
    List<String> list =[name];
    await Firestore.instance.collection('Rooms').where('collegeName',isEqualTo: college).where('floorLevel',isEqualTo:floor).where('roomNumber',isEqualTo:room).getDocuments().then((value){
      value.documents.forEach((f)=> {
        str = f.documentID,
        Firestore.instance.collection('Rooms').document(f.documentID).updateData({"students":FieldValue.arrayUnion(list)})
      });return str;
    });
    print(str);
    await new Future.delayed(const Duration(seconds: 5));
    return str;

  }
  Future<String> deleteStudentFromRoom(String floor,String college, String room, String name) async {
    List<String> list =[name.toUpperCase()];
    print(list);
    String str;
    await Firestore.instance.collection('Rooms').where('collegeName',isEqualTo: college).where('floorLevel',isEqualTo:floor).where('roomNumber',isEqualTo:room).getDocuments().then((value){
      value.documents.forEach((f)=> {
        str = f.documentID,
        Firestore.instance.collection('Rooms').document(f.documentID).updateData({"students":FieldValue.arrayRemove(list)})
      });return str;
    });
    print(str);
    await new Future.delayed(const Duration(seconds: 5));
    return str;

  }
  Future<String> updateStudentFromRoom(String floor,String college, String room, String name,String updatedName) async {
    List<String> list =[name.toUpperCase()];
    List<String> list1 =[updatedName.toUpperCase()];
    print(list);
    String str;
    await Firestore.instance.collection('Rooms').where('collegeName',isEqualTo: college).where('floorLevel',isEqualTo:floor).where('roomNumber',isEqualTo:room).getDocuments().then((value){
      value.documents.forEach((f)=> {
        str = f.documentID,
        print(f.documentID),
        Firestore.instance.collection('Rooms').document(f.documentID).updateData({"students":FieldValue.arrayRemove(list)}),
        Firestore.instance.collection('Rooms').document(f.documentID).updateData({"students":FieldValue.arrayUnion(list1)})

      });return str;
    });
    print(str);
    await new Future.delayed(const Duration(seconds: 5));
    return str;

  }
}