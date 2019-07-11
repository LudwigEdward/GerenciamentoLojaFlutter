import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:ecommerce_venda/blocs/orders_bloc.dart';
import 'package:ecommerce_venda/blocs/user_bloc.dart';
import 'package:ecommerce_venda/tabs/orders_tab.dart';
import 'package:ecommerce_venda/tabs/users_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PageController _pageController;
  int _page = 0;

  UserBloc _userBloc;
  OrdersBloc _ordersBloc;


  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _userBloc = UserBloc();
    _ordersBloc = OrdersBloc();
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.pinkAccent,
            primaryColor: Colors.white,
            textTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: Colors.white54))
        ),
        child: BottomNavigationBar(
          currentIndex: _page,
            onTap: (p){
            _pageController.animateToPage(p, duration: Duration(milliseconds: 500), curve: Curves.ease);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.person),title: Text("Clientes")),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),title: Text("Pedidos")),
              BottomNavigationBarItem(icon: Icon(Icons.list),title: Text("Produtos")),
            ]),
      ),
      body: SafeArea(
        child: BlocProvider<UserBloc>(
          bloc: _userBloc,
          child: BlocProvider<OrdersBloc>(
            bloc: _ordersBloc,
            child: PageView(
              controller: _pageController,
              onPageChanged: (p){
              setState((){
                _page = p;
    });
                },
              children: <Widget>[
                UsersTab(),
                OrdersTab(),
                Container(color: Colors.green,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
