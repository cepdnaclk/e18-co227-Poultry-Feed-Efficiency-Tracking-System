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
            .doc();
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({'Location': location, 'Name': name});
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
Future<bool> addBranch(String branchName, String farmID) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance
            .collection('Farmers')
            .doc(uid)
            .collection('Branch')
            .doc();
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({'FarmID': farmID, 'BranchName': branchName});
        //documentReference.set({'BranchName': branchName});
        return true;
      }
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> updateBranch(String id, String branchName) async {
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
        //transaction.update(documentReference, {'FarmName': farmName});
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
Future<bool> addShed(String shedName, String branchID, String farmID) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance
            .collection('Farmers')
            .doc(uid)
            .collection('Shed')
            .doc();
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set(
            {'BranchID': branchID, 'ShedName': shedName, 'FarmID': farmID});
        return true;
      }
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> updateShed(String id, String shedName) async {
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
        transaction.update(documentReference, {'ShedName': shedName});
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

//database functions for sheds
Future<bool> addFlock(
    String flockName,
    String shedID,
    String branchID,
    String farmID,
    String sDay,
    //String type,
    String strain,
    String numberChicken,
    String bDay) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance
            .collection('Farmers')
            .doc(uid)
            .collection('flock')
            .doc()
        /*.collection('startdays')
            .doc(sDay)
            .collection('types')
            .doc(type)
            .collection('strains')
            .doc(strain)
            .collection('counts')
            .doc(numberChicken)*/
        ;

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({
          'ShedID': shedID,
          'BranchID': branchID,
          'FarmID': farmID,
          'startdays': sDay,
          //'type': type,
          'strain': strain,
          'count': numberChicken,
          'FlockName': flockName,
          'birthDate': bDay,
          'Active': "yes",
          'Mortal': 0
        });
        return true;
      }
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> updateFlockName(
  String id,
  String flockName,
) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance
            .collection('Farmers')
            .doc(uid)
            .collection('flock')
            .doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await transaction.get(documentReference);

      try {
        //double newAmount = value;
        transaction.update(documentReference, {'FlockName': flockName});
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

Future<bool> updatesDay(String id, String sDay) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance
            .collection('Farmers')
            .doc(uid)
            .collection('flock')
            .doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await transaction.get(documentReference);

      try {
        //double newAmount = value;
        transaction.update(documentReference, {'startdays': sDay});
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

Future<bool> updateType(String id, String type) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance
            .collection('Farmers')
            .doc(uid)
            .collection('flock')
            .doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await transaction.get(documentReference);

      try {
        //double newAmount = value;
        transaction.update(documentReference, {'type': type});
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

Future<bool> updateStrain(String id, String strain) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance
            .collection('Farmers')
            .doc(uid)
            .collection('flock')
            .doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await transaction.get(documentReference);

      try {
        //double newAmount = value;
        transaction.update(documentReference, {'strain': strain});
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

Future<bool> updateCount(String id, String count) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance
            .collection('Farmers')
            .doc(uid)
            .collection('flock')
            .doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await transaction.get(documentReference);

      try {
        //double newAmount = value;
        transaction.update(documentReference, {'count': count});
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

Future<bool> updatebDay(String id, String bDay) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance
            .collection('Farmers')
            .doc(uid)
            .collection('flock')
            .doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await transaction.get(documentReference);

      try {
        //double newAmount = value;
        transaction.update(documentReference, {'birthDate': bDay});
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

Future<bool> removeFlock(String id) async {
  try {
    if (FirebaseAuth.instance.currentUser != null) {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore.instance
          .collection('Farmers')
          .doc(uid)
          .collection('flock')
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
