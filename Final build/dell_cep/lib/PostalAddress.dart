class PostalAddress {
  String _cep;
  String _logradouro;
  String _bairro;
  String _localidade;
  String _uf;

  PostalAddress(
      String cep, String rua, String bairro, String cidade, String uf) {
    this._cep = cep;
    this._logradouro = rua;
    this._bairro = bairro;
    this._localidade = cidade;
    this._uf = uf;
  }

  String getCep() {
    return _cep;
  }

  String getRua() {
    return _logradouro;
  }

  String getBairro() {
    return _bairro;
  }

  String getCidade() {
    return _localidade;
  }

  String getUf() {
    return _uf;
  }
}
