import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app_example/Text/heading.dart';

class MyFvouritePage extends StatefulWidget {
  const MyFvouritePage({super.key});

  @override
  State<MyFvouritePage> createState() => _MyFvouritePageState();
}

class _MyFvouritePageState extends State<MyFvouritePage> {
  String? uid = FirebaseAuth.instance.currentUser?.uid!;
  User? user = FirebaseAuth.instance.currentUser;
  // final CollectionReference users =
  //     FirebaseFirestore.instance.collection("favourites");

  void deleteFavourite(String name) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    final User? user = await firebaseAuth.currentUser;
    if (user != null) {
      String uid = user.uid;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Favourites $uid')
          .where('title', isEqualTo: name)
          .get();

      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Modified_Text2(
            text: 'Favourite Movies',
            color: Colors.red,
            size: 30.0,
            fontWeight: FontWeight.bold),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Favourites $uid')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return Container(
                  height: 200,
                  width: 200,
                  child: ListTile(
                    title: Modified_Text2(
                        text: data['title'],
                        color: Colors.white,
                        size: 20,
                        fontWeight: FontWeight.bold),
                    subtitle: Image.network(
                      'https://image.tmdb.org/t/p/w500${data['poster']}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        deleteFavourite(data['title']);
                      },
                    ),
                  ));
            }).toList(),
          );
        },
      ),
    );
  }
}
