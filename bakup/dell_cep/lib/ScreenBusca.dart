import 'package:flutter/material.dart';
import 'package:dell_cep/PostalAddressProvider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'BuscaCEP';

    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        platform: TargetPlatform.iOS,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  MyCustomFormState();
  PostalAddressProvider jsoncep = PostalAddressProvider();
  final _formKey = GlobalKey<FormState>();

  String _cep = '';
  String devolveCEP() {
    return _cep;
  }

  bool cepEhValido;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.fromLTRB(50, 230, 50, 0),
        child: Column(
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.number,
              style: new TextStyle(
                color: Colors.black,
                fontFamily: "Poppins",
              ),
              decoration: InputDecoration(
                labelText: "Digite seu CEP",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.cyan),
                ),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
              validator: (value) {
                int contadorDeSimbolos = 0;
                int tamanhoCEP = value.length;
                String cepFormatado = '';

                for (var i = 0; i < tamanhoCEP; i++) {
                  String char = value[i];
                  if (char == '0' ||
                      char == '1' ||
                      char == '2' ||
                      char == '3' ||
                      char == '4' ||
                      char == '5' ||
                      char == '6' ||
                      char == '7' ||
                      char == '8' ||
                      char == '9') {
                    cepFormatado += char;
                  } else {
                    contadorDeSimbolos++;
                  }
                }
                tamanhoCEP -= contadorDeSimbolos;

                int diferenca = tamanhoCEP - 8;


                if (value.isEmpty || cepFormatado.length != 8) {
                  if (value.isEmpty) {
                    return "CEP esta em branco";
                  } else if (diferenca > 0) {
                    diferenca = diferenca.abs();
                    return 'Seu cep tem $diferenca numeros a mais';
                  } else if (diferenca < 8) {
                    diferenca = diferenca.abs();
                    return 'Seu cep tem $diferenca numeros a menos';
                  }
                } else if (tamanhoCEP == 8) {
                  _cep = cepFormatado;
                }
                return null;
              },
            ),
            Row(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: FloatingActionButton(
                  heroTag: "Buscar",
                  tooltip: 'Buscar CEP',
                  child: Icon(Icons.check),
                  backgroundColor: Colors.green,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      jsoncep.pegarCep(_cep, context);
                      if (jsoncep.oCepEhValido() == true) {
                        cepEhValido = true;
                      } else {
                        cepEhValido = false;
                      }
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Verificando'),
                        ),
                      );
                    }
                  },
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
