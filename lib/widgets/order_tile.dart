import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'order_header.dart';
enum ConfirmAction { CANCEL, ACCEPT }
class OrderTile extends StatelessWidget {

  final DocumentSnapshot order;
  OrderTile(this.order);

  final states = [
    "","Em Preparação","Em transporte","Aguardando Entrega","Entregue"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
      child: Card(
        child: ExpansionTile(
          initiallyExpanded: order.data["status"]>3? false : true,
          title: Text("#${order.documentID.substring(order.documentID.length-7,order.documentID.length)} - ${states[order.data["status"]]}",style: TextStyle(color: order.data["status"]!=4? Colors.grey[700]:Colors.green),),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 16,right: 16,top: 0,bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    OrderHeader(order),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: order.data["products"].map<Widget>((p){
                        return ListTile(
                          title: Text(p["product"]["title"]+ " "+ p["size"]),
                          subtitle: Text(p["category"]+ "/" + p["pid"]),
                          trailing: Text(p["quantity"].toString(),style: TextStyle(fontSize: 20),),
                          contentPadding: EdgeInsets.zero,
                        );
                      }).toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                          onPressed: (){
                            _asyncConfirmDialog(context);
                          },
                          textColor: Colors.red,
                          child: Text("Excluir"),
                        ),
                        FlatButton(
                          onPressed: order.data["status"] > 1 ? (){
                            order.reference.updateData({"status" : order.data["status"] - 1});
                          }:null,
                          textColor: Colors.grey[850],
                          child: Text("Regredir"),
                        ),
                        FlatButton(
                          onPressed: order.data["status"] < 4 ? (){
                            order.reference.updateData({"status" : order.data["status"] + 1});
                          }:null,
                          textColor: Colors.green,
                          child: Text("Avançar"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: true, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("ATENÇÃO",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.red,fontSize: 30),),

            ],
          ),
          content: const Text(
              'Deseja realmente excluir este pedido ?',style: TextStyle(fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
          actions: <Widget>[
            FlatButton(
              child:  Text('Sim',style: TextStyle(color: Colors.red),),
              onPressed: () {
                Firestore.instance.collection("users").document(order["clientId"]).collection("orders").document(order.documentID).delete();
                order.reference.delete();
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child:  Text('Não',style:TextStyle(color: Colors.grey[800]),),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    );
  }
}

