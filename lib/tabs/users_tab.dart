import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:ecommerce_venda/blocs/user_bloc.dart';
import 'package:ecommerce_venda/widgets/user_tile.dart';
import 'package:flutter/material.dart';


class UsersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _userBloc = BlocProvider.of<UserBloc>(context);

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.search,color: Colors.white,),
                Container(
                  padding: EdgeInsets.fromLTRB(5, 15, 0, 0),
                  width: 300,
                  height: 40,
                  color: Colors.grey[700],
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(hintText: "Pesquisar",hintStyle: TextStyle(color: Colors.white.withAlpha(70)),border: InputBorder.none),
                    onChanged: _userBloc.onChangedSearch,
                  ),
                ),
              ],
            ),
          ),
        Expanded(
          child: StreamBuilder<List>(
            stream: _userBloc.outUsers,
            builder: (context, snapshot) {
              if(!snapshot.hasData) return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),),);
              else if(snapshot.data.length==0) return Center(child: Text("Nenhum usuário encontrado!",style: TextStyle(color: Colors.pinkAccent),),);
              else{
                return ListView.separated(
                    itemBuilder: (context,index){
                      return UserTile(snapshot.data[index]);
                    },
                    separatorBuilder: (context,index){
                      return Divider(color: Colors.white,);
                    },
                    itemCount: snapshot.data.length
                );
              }
            }
          ),
        ),
      ],
    );
  }
}
