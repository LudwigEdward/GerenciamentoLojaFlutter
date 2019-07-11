import 'package:ecommerce_venda/widgets/order_tile.dart';
import 'package:flutter/material.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        itemBuilder: (context,index){
          return OrderTile();
        },
        itemCount: 6,),
    );
  }
}
