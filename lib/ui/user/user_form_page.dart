import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_balcoder_fb/ui/home/model/data_model.dart';

class UserFormPage extends StatefulWidget {
  UserFormPage({super.key, required this.dataModel});

  DataModel dataModel;

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  TextEditingController _controllerName = new TextEditingController();
  TextEditingController _controllerPhone = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.dataModel.key != null) {
      _controllerName.text = widget.dataModel.name!;
      _controllerPhone.text = widget.dataModel.phone!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          widget.dataModel.key != null
              ? GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Icon(Icons.delete),
                  ),
                  onTap: () {
                    widget.dataModel.isDeleted = true;

                    FirebaseFirestore.instance
                        .collection("dataCollection")
                        .doc(widget.dataModel.key)
                        .update(widget.dataModel.toJson());

                    Navigator.pop(context);
                  },
                )
              : Container()
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(children: [
            TextFormField(
              controller: _controllerName,
              decoration: InputDecoration(labelText: "Nombre"),
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: _controllerPhone,
              decoration: InputDecoration(labelText: "Teléfono"),
            ),
            SizedBox(height: 24),
            Center(
                child: GestureDetector(
              onTap: () {
                DataModel _dataModel = new DataModel();
                _dataModel.name = _controllerName.text;
                _dataModel.phone = _controllerPhone.text;
                _dataModel.isDeleted = false;

                if (widget.dataModel.key != null) {
                  FirebaseFirestore.instance
                      .collection("dataCollection")
                      .doc(widget.dataModel.key)
                      .update(_dataModel.toJson());
                } else {
                  FirebaseFirestore.instance
                      .collection("dataCollection")
                      .add(_dataModel.toJson());
                }

                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Center(
                    child: Text(
                  widget.dataModel.key != null ? "Update" : "Add",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            )),
          ]),
        ),
      ),
    );
  }
}
