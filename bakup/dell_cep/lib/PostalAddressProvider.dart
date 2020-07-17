import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dell_cep/ScreenBusca.dart';
import 'package:dell_cep/PostalAddress.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:http/http.dart' as http;

class PostalAddressProvider {
  String _cepBuscado;
  String _logradouroBuscado;
  String _bairroBuscado;
  String _localidadeBuscado;
  String _ufBuscado;
  bool valido = false;

  var cepDoUsuario;
  PostalAddressProvider();
  MyApp acesso = MyApp();

  void pegarCep(var cepDoUsuario, BuildContext context) async {
    var url = 'https://viacep.com.br/ws/$cepDoUsuario/json/';
    var response = await http.get(url);

    PostalAddress location;
    

    Map<String, dynamic> teste = json.decode(response.body);

    if (teste.containsKey("erro")) {
      valido = false;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("BuscaCEP"),
            content: new Text("CEP invalido!"),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  FlatButton(
                    child: new Text("Fechar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          );
        },
      );
    } else {
      valido = true;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("BuscaCEP"),
            content: new Text("CEP valido!"),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  FlatButton(
                    child: new Text("Trocar pra mapa"),
                    onPressed: () {
                      location = PostalAddress(_cepBuscado, _logradouroBuscado,
                          _bairroBuscado, _localidadeBuscado, _ufBuscado);
                      Navigator.of(context).pop();
                      lancaNoMapa(location);
                    },
                  ),
                  FlatButton(
                    child: new Text("Fechar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          );
        },
      );
      teste.forEach((key, value) {
        if (value.toString().isNotEmpty) {
          if (key.toString() == "cep") {
            _cepBuscado = value;
          } else if (key.toString() == 'logradouro') {
            _logradouroBuscado = value;
          } else if (key.toString() == 'bairro') {
            _bairroBuscado = value;
          } else if (key.toString() == 'localidade') {
            _localidadeBuscado = value;
          } else if (key.toString() == 'uf') {
            _ufBuscado = value;
          }
        }
      });
    }
  }

  bool oCepEhValido() {
    if (valido == true) {
      return true;
    } else {
      return false;
    }
  }

  getCepBuscado() {
    return _cepBuscado;
  }

  getLogradouroBuscado() {
    return _logradouroBuscado;
  }

  getBairroBuscado() {
    return _bairroBuscado;
  }

  getLocalidadeBuscado() {
    return _localidadeBuscado;
  }

  getUfBuscado() {
    return _ufBuscado;
  }

  setInvalido() {
    this.valido = false;
  }

  lancaNoMapa(PostalAddress location) {
    MapsLauncher.launchQuery(
        "${location.getRua()} - ${location.getBairro()}, ${location.getCidade()} - ${location.getUf()}, ${location.getCep()}");
  }
}
