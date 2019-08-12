import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'total_price'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController current_slide_controller = new TextEditingController();
  TextEditingController last_slide_controller = new TextEditingController();
  TextEditingController current_water_controller = new TextEditingController();
  TextEditingController last_water_controller = new TextEditingController();
  TextEditingController house_controller = new TextEditingController();
  TextEditingController sum_controller = new TextEditingController();

  void _resetAll() {
    setState(() {
      this.current_slide_controller.text = "";
      this.last_slide_controller.text = "";
      this.current_water_controller.text = "";
      this.last_water_controller.text = "";
      this.house_controller.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                this._inputField(
                    controller: current_slide_controller,
                    label: '请输入当月电费',
                    errorMessage: '当月电费不能为空'),
                this._inputField(
                    controller: last_slide_controller,
                    label: '请输入上月电费',
                    errorMessage: '上月电费不能为空'),
                this._inputField(
                    controller: current_water_controller,
                    label: '请输入当月水费',
                    errorMessage: '当月水费不能为空'),
                this._inputField(
                    controller: last_water_controller,
                    label: '请输入上月水费',
                    errorMessage: '上月水费不能为空'),
                this._inputField(
                    controller: house_controller,
                    label: '请输入房租',
                    errorMessage: '房租不能为空'),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: 370,
                  height: 50,
                  child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text(
                      "统计",
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: () {
                      this._calculate();
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  controller: sum_controller,
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                  readOnly: true,
                  decoration: InputDecoration(
                      fillColor: Colors.redAccent, filled: true),
                )
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: _resetAll,
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _inputField({controller, errorMessage, label}) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value.isEmpty) {
          return errorMessage;
        }
        return null;
      },
      style: TextStyle(fontSize: 30, color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 24),
        contentPadding: EdgeInsets.all(10),
        icon: Icon(Icons.attach_money),
        filled: true,
        fillColor: Colors.white24,
      ),
      keyboardType: TextInputType.number,
    );
  }

  void _calculate() {
    if(!_formKey.currentState.validate()) return null;

    // num current_slide = num.parse(current_slide_controller.text);
    // num last_slide = double.parse(last_slide_controller.text);
    // num current_water = double.parse(current_water_controller.text);
    // num last_water = double.parse(last_water_controller.text);
    // num house = double.parse(house_controller.text);

    this.setState(() {
      num current_slide = num.parse(current_slide_controller.text);
      num last_slide = num.parse(last_slide_controller.text);
      num current_water = num.parse(current_water_controller.text);
      num last_water = num.parse(last_water_controller.text);
      num house = num.parse(house_controller.text);
      num slideOut = (current_slide - last_slide + 2) * 4;
      num waterOut = (current_water - last_water + 2) * 1.5;
      this.sum_controller.text = (house + slideOut + waterOut).toString();
    });
  }
}
