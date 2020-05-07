import 'package:climbingpals/models/climber.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:climbingpals/models/user.dart';

class DatabaseService{
  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference climberCollection = Firestore.instance.collection('climbers');

  Future<void> updateUserData(String ages, String name, int rank) async {
    return await climberCollection.document(uid).setData({
      'ages': ages,
      'name': name,
      'rank':  rank,
    });
  }

  // climber list from snapshot
  List<Climber> _climberListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Climber(
        name: doc.data['name'] ?? '',
        rank: doc.data['rank'] ?? 0,
        ages: doc.data['ages'] ?? '0',
      );
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      ages: snapshot.data['ages'],
      rank: snapshot.data['rank']
    );
  }

  // get climber stream (snapshot of store)
  Stream<List<Climber>> get climbers {
    return climberCollection.snapshots()
        .map(_climberListFromSnapshot);
  }

  // get user document (data model)
  Stream<UserData> get userData {
    return climberCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }


}


