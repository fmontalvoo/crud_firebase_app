bool isNumber(String numero) {
  if (numero.isEmpty) return false;

  if (num.tryParse(numero) == null) return false;

  return true;
}
