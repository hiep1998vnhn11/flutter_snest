import 'package:flutter/material.dart';

class BottomInput extends StatefulWidget {
  const BottomInput({Key? key}) : super(key: key);

  @override
  _BottomInputState createState() => _BottomInputState();
}

class _BottomInputState extends State<BottomInput> {
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,

          ///Your TextBox Container
          child: Container(
              height: 20.0,
              padding: EdgeInsets.symmetric(vertical: 2.0),
              alignment: Alignment.bottomCenter,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                // First child is enter comment text input
                TextFormField(
                  controller: _textController,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    labelText: "Some Text",
                    labelStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                    fillColor: Colors.blue,
                    border: OutlineInputBorder(
                        // borderRadius:
                        //     BorderRadius.all(Radius.zero(5.0)),
                        borderSide: BorderSide(color: Colors.purpleAccent)),
                  ),
                ),
                // Second child is button
                IconButton(
                  icon: Icon(Icons.send),
                  iconSize: 20.0,
                  onPressed: () {},
                )
              ])),
        )
      ],
    );
  }
}
