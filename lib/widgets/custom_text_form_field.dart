import 'package:flutter/material.dart';



class CustomInput extends StatefulWidget {

  final IconData _icon;
  final String _hint;
  final TextEditingController _controller;
  final TextInputType type;
  final bool _obscure;
  final Stream<String> _stream;
  final Function(String) onChanged;
  CustomInput(this._icon, this._hint,this._controller,this.type,this._obscure,this._stream,this.onChanged);

  @override
  _CustomInputState createState() => _CustomInputState(this._icon, this._hint,this._controller,this.type,this._obscure,this._stream,this.onChanged);
}

class _CustomInputState extends State<CustomInput> {

  final IconData icon;
  final String hint;
  final TextEditingController controller;
  final TextInputType type;
  final bool obscure;
  final Stream<String> stream;
  final Function(String) onChanged;
  Color newColor = Colors.white;
  _CustomInputState(this.icon, this.hint,this.controller,this.type,this.obscure,this.stream,this.onChanged);

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  onChanged: onChanged,
                  obscureText: obscure,
                  keyboardType: type,
                  controller: controller,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: hint,
                    labelStyle: TextStyle(color: newColor),
                    prefixIcon: Icon(
                      icon,
                      color: Colors.white,
                      size: 25,
                    ),
                    errorText: snapshot.hasError ? snapshot.error : null
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

