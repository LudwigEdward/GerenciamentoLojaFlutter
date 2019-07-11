import 'package:flutter/material.dart';

class OrderHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Daniel"),
              Text("Rua, flutter, top")
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text("Produtos",style: TextStyle(fontWeight: FontWeight.w500),),
              Text("Preço total",style: TextStyle(fontWeight: FontWeight.w500),)
            ],
        )
      ],
    );
  }
}
