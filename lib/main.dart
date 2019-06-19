import 'package:flutter/material.dart';

void main() {
    runApp(MaterialApp(
      home: Home(),
    )); 
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GlobalKey<FormState> _formState = GlobalKey<FormState>();

  String _info = "Insira um peso e uma altura!";
  String _result = "";

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  void _reset() {

    weightController.text = "";
    heightController.text = "";

    setState(() {
      _info = "Insira um peso e uma altura!";
      _result = "";
      _formState = GlobalKey<FormState>();  
    });

  }

  void _calcular() {

    double weight = double.parse(weightController.text.replaceAll(',', '.'));
    double height = double.parse(heightController.text.replaceAll(',', '.'));

    setState(() {
      double resultado = weight / (height * height);
      _result = resultado.toStringAsPrecision(4);

      if (resultado <= 18.6) {
        _info = "Levemente Acima do peso";
        _result = "Seu Imc é: $_result";
      } else if(resultado >= 18.6 && resultado <= 24.9) {
        _info = "Peso Ideal";
        _result = "Seu Imc é: $_result";
      }  else if(resultado >= 24.9 && resultado <= 29.9) {
        _info = "Levemente Acima do Peso";
        _result = "Seu Imc é: $_result";
      } else if(resultado >= 29.9 && resultado <= 34.9) {
        _info = "Obesidade Grau I";
        _result = "Seu Imc é: $_result";
      } else if(resultado >= 34.9 && resultado <= 39.9) {
        _info = "Obesidade Grau II";
        _result = "Seu Imc é: $_result";
      } else if(resultado >= 39.9) {
        _info = "Obesidade Grau III";
        _result = "Seu Imc é: $_result";
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculadora IMC',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh
            ),
            onPressed: () {
              _reset();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formState,
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, color: Colors.green, size: 120.0),
              TextFormField(
                controller: weightController,
                decoration: InputDecoration(
                  labelText: "Peso (Kg)",
                  labelStyle: TextStyle(
                    color: Colors.green,
                    fontSize: 18.0
                  ),
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if(value.isEmpty) {
                    return "Insira um valor para peso!";
                  }
                }
              ),
              TextFormField(
                controller: heightController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira um valor para Altura!";
                  }
                },
                decoration: InputDecoration(
                  labelText: "Altura (m)",
                  labelStyle: TextStyle(color: Colors.green, fontSize: 18.0)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Container(
                  height: 60.0,
                  child: RaisedButton(
                    color: Colors.green,
                    onPressed: () {
                      if (_formState.currentState.validate()) {
                        _calcular();
                      }
                    },
                    textColor: Colors.white,
                    child: Text(
                      "Calcular",
                      style: TextStyle(
                        fontSize: 30.0
                      )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Text(
                  _info,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 25.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Text(
                  _result,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 25.0
                  ),
                ),
              ),
            ],
          ),
          )
        ),
      ),
    );
  }
}