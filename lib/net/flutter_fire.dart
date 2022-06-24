import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


//database functions for farms registration 
Future<bool> addFarmer(String name, String location) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance
            .collection('Farmers')
            .doc(uid)
            .collection('Farms')
            .doc(name);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({'Location': location});
        return true;
      }
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> updateFarm(String id, String location) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance
            .collection('Farmers')
            .doc(uid)
            .collection('Farms')
            .doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await transaction.get(documentReference);

      try {
        //double newAmount = value;
        transaction.update(documentReference, {'Location': location});
        return true;
      } catch (e) {
        rethrow;
      }
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> removeFarm(String id) async {
  try {
    if (FirebaseAuth.instance.currentUser != null) {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore.instance
          .collection('Farmers')
          .doc(uid)
          .collection('Farms')
          .doc(id)
          .delete();
      return true;
    } else {
      throw ("This is my first general exception");
    }
  } catch (e) {
    rethrow;
  }
}



//database functions for farm branch registration 
Future<bool> addBranch(String branchName, String farmName) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance
            .collection('Farmers')
            .doc(uid)
            .collection('Branch')
            .doc(branchName);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({'FarmName': farmName});
        return true;
      }
    });
    return true;
  } catch (e) {
    return false;
  }
}


Future<bool> updateBranch(String id, String farmName) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance
            .collection('Farmers')
            .doc(uid)
            .collection('Branch')
            .doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await transaction.get(documentReference);

      try {
        //double newAmount = value;
        transaction.update(documentReference, {'FarmName': farmName});
        return true;
      } catch (e) {
        rethrow;
      }
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> removeBranch(String id) async {
  try {
    if (FirebaseAuth.instance.currentUser != null) {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore.instance
          .collection('Farmers')
          .doc(uid)
          .collection('Branch')
          .doc(id)
          .delete();
      return true;
    } else {
      throw ("This is my first general exception");
    }
  } catch (e) {
    rethrow;
  }
}



//database functions for sheds
Future<bool> addShed(String shedName, String branchName) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance
            .collection('Farmers')
            .doc(uid)
            .collection('Shed')
            .doc(shedName);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({'BranchName': branchName});
        return true;
      }
    });
    return true;
  } catch (e) {
    return false;
  }
}


Future<bool> updateShed(String id, String branchName) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance
            .collection('Farmers')
            .doc(uid)
            .collection('Shed')
            .doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await transaction.get(documentReference);

      try {
        //double newAmount = value;
        transaction.update(documentReference, {'BranchName': branchName});
        return true;
      } catch (e) {
        rethrow;
      }
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> removeShed(String id) async {
  try {
    if (FirebaseAuth.instance.currentUser != null) {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore.instance
          .collection('Farmers')
          .doc(uid)
          .collection('Shed')
          .doc(id)
          .delete();
      return true;
    } else {
      throw ("This is my first general exception");
    }
  } catch (e) {
    rethrow;
  }
}