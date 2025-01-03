String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email adresinizi giriniz';
  }
  String pattern = r'^[^@]+@[^@]+\.[^@]+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Geçerli bir email adresi giriniz';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Şifrenizi giriniz';
  }
  if (value.length < 8) {
    return 'Şifreniz en az 8 karakter olmalıdır';
  }
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return 'Şifreniz en az bir büyük harf içermelidir';
  }
  if (!RegExp(r'[a-z]').hasMatch(value)) {
    return 'Şifreniz en az bir küçük harf içermelidir';
  }
  if (!RegExp(r'[0-9]').hasMatch(value)) {
    return 'Şifreniz en az bir rakam içermelidir';
  }
  return null;
}

String? validateConfirmPassword(String? value, String password) {
  if (value == null || value.isEmpty) {
    return 'Şifrenizi tekrar giriniz';
  }
  if (value != password) {
    return 'Şifreler eşleşmiyor';
  }
  return null;
}
