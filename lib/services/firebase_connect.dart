import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:invoice/firebase_options.dart';

login(email, password) async{

  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  
  try {
  var auth = FirebaseAuth.instance;
  await auth.signInWithEmailAndPassword(
    email: email, password: password);

  return true;
  } catch (e) {
    return false;
    
  }

}

register(email, password, user, cpf) async{

  Firebase.initializeApp(
    
    options: DefaultFirebaseOptions.currentPlatform
  );
  try {
  var auth = FirebaseAuth.instance;
  await auth.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );

    // String id = UserCredential.user!.id;

    // var db = FirebaseFirestore.instance;
    // await db.collection('User').doc(id).set({
    //   'id': id,
    //   'email': email,
    //   'name': user,
    //   'cpf':cpf,

    // });

  return true;
  } catch (e) {
    return false;
    
  }

}

update(name) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;
  db.collection('Users').doc(auth.currentUser!.uid).set({
    'name': name,
    'email': auth.currentUser!.email,
  });
}

get_items() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var db = FirebaseFirestore.instance;
  var items = await db.collection('Items').get();
  items.docs.forEach((item) => {print(item.data())});
  return items.docs;
}

get_categories() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var db = FirebaseFirestore.instance;
  var items = await db.collection('Categories').get();
  items.docs.forEach((item) => {print(item.data())});
  return items.docs;
}

set_cart(List<dynamic> item) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;
  print(item);
  try {
    await db.collection('Users').doc(auth.currentUser!.uid).update({
      'cart': FieldValue.arrayUnion(item),
    });
  } catch (e) {
    print(e);
  }
}

get_cart() async{
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;
  var user = await db.collection('Users').doc(auth.currentUser!.uid).get();
  var cart = user['cart'];
  return cart;
}

buy_cart(items) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;
  await db.collection('Users').doc(auth.currentUser!.uid).set({
    'historic': FieldValue.arrayUnion([items]),
  }, SetOptions(merge: true));
}

get_wishlist() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;
  var user = await db.collection('Users').doc(auth.currentUser!.uid).get();
  var wishlist = user['wishlist'];
  var itemsQuery = await db
      .collection('Items')
      .where(FieldPath.documentId, whereIn: wishlist)
      .get();

  var items = itemsQuery.docs.toList();
  print(itemsQuery.docs);
  return itemsQuery.docs;
}


set_wishlist(item) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;
  print("OK");
  try {
    await db.collection('Users').doc(auth.currentUser!.uid).set({
      'wishlist': FieldValue.arrayUnion(item),
    }, SetOptions(merge: true));
  } catch (e) {
    print(e);
  }
}