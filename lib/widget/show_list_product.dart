import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_shoping_mall/models/product_model.dart';

class ShowListProduct extends StatefulWidget {
  ShowListProduct({Key key}) : super(key: key);

  @override
  _ShowListProductState createState() => _ShowListProductState();
}

class _ShowListProductState extends State<ShowListProduct> {
  List<ProductModel> productModels = List();

  @override
  void initState() {
    super.initState();
    readAllData();
  }

  Future<Null> readAllData() async {
    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference = firestore.collection('Product');
    await collectionReference.snapshots().listen((response) {
      List<DocumentSnapshot> snapshots = response.documents;
      for (var snapshot in snapshots) {
        // print('snapshot = $snapshot');
        print('Name = ${snapshot.data['Name']}');
        ProductModel productModel = ProductModel.fromMap(snapshot.data);
        setState(() {
          productModels.add(productModel);
        });
      }
    });
  }

  Widget showImage(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Image.network(productModels[index].pathImage),
    );
  }

  Widget showText(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        children: [
          showName(index),
          showDetail(index),
        ],
      ),
    );
  }

  Widget showName(int index) {
    return Text(productModels[index].name);
  }

  Widget showDetail(int index) {
    String string = productModels[index].detail;
    if (string.length > 100) {
      string = string.substring(0, 99);
      string = '$string...';
    }
    return Text(string);
  }

  Widget showListView(int index) {
    return Row(
      children: [
        showImage(index),
        showText(index),
        
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext buildContext, int index) {
          return showListView(index);
        },
        itemCount: productModels.length,
      ),
    );
  }
}
