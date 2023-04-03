import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_balcoder_fb/ui/home/model/data_model.dart';
import 'package:flutter_balcoder_fb/ui/user/user_form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "";
  List<DataModel> dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFirebaseInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        // child: Center(child: Text(name)),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("dataCollection")
              .where("isDeleted", isEqualTo: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<QueryDocumentSnapshot> docs = snapshot.data!.docs;

              dataList = [];
              for (var i = 0; i < docs.length; i++) {
                dataList.add(new DataModel.fromSnapshot(
                    data: docs[i].data(), id: docs[i].id));
              }
              return dataList.length > 0
                  ? ListView.builder(
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: ListTile(
                            title: Text(dataList[index].name!),
                            subtitle: Text(dataList[index].key!),
                          ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return UserFormPage(dataModel: dataList[index]);
                            }));
                          },
                        );
                      })
                  : Center(child: Text("No hay data"));
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return UserFormPage(dataModel: new DataModel());
            }));
          }),
    );
  }

  getFirebaseInfo() {
    FirebaseFirestore.instance
        .collection("dataCollection")
        .doc("dXepiBe7ilQhrJZgANRr")
        .snapshots()
        .listen((value) {
      setState(() {
        // SIEMPRE USAR
        var data = value.data();
        name = data!["name"];
      });
    });
  }
}
