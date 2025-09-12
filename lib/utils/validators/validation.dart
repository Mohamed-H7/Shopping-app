class Validator {
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName gereklidir';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-posta gereklidir.';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Geçersiz e-posta adresi.';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Şifre gereklidir.';
    }

    // Check for minimum password length
    if (value.length < 6) {
      return 'Şifre en az 6 karakter uzunluğunda olmalıdır.';
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Şifrenizde en az bir büyük harf bulunmalıdır.';
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Şifre en az bir rakam içermelidir.';
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#\$%\^&\*\(\),\.?":{}|<>]'))) {
      return 'Şifre en az bir özel karakter içermelidir.';
    }

    return null;
  }

  static String? validatePasswordsimilarity(String? value, String? value2) {
    if (value != value2) {
      return 'Şifre uyuşmazlığı';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Telefon numarası gereklidir.';
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r'^\+?\d{10,}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Geçersiz telefon numarası biçimi (en az 10 hane gereklidir).';
    }

    return null;
  }

  static String? validateOTPcode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Doğrulama kodu gereklidir.';
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r'^\d{6}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Geçersiz Doğrulama kodu biçimi (6 hane gerekli).';
    }

    return null;
  }

  //

  static String? validateCardHolderName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Kart sahibinin adı gereklidir.';
    }

    final nameParts = value.trim().split(' ');
    if (nameParts.length < 2) {
      return 'Lütfen tam adınızı girin (en az iki kelime).';
    }

    return null;
  }

  static String? validateExpiryDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Son kullanma tarihi gereklidir.';
    }

    final expRegExp = RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$');
    if (!expRegExp.hasMatch(value)) {
      return 'Geçersiz tarih biçimi. MM/YY biçiminde olmalıdır.';
    }

    final parts = value.split('/');
    final month = int.tryParse(parts[0]);
    final year = int.tryParse('20${parts[1]}');

    if (month == null || year == null) return 'Geçersiz tarih.';

    final now = DateTime.now();
    final expiry = DateTime(year, month + 1); // geçerli ay dahil

    if (expiry.isBefore(now)) {
      return 'Kartın süresi dolmuş.';
    }

    return null;
  }

  static String? validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return 'CVV gereklidir.';
    }

    final cvvRegExp = RegExp(r'^\d{3}$');
    if (!cvvRegExp.hasMatch(value)) {
      return 'CVV 3 haneli olmalıdır.';
    }

    return null;
  }

  static String? validateCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Kart numarası gereklidir.';
    }

    final cleanedValue = value.replaceAll(' ', '');

    if (!RegExp(r'^\d{13,19}$').hasMatch(cleanedValue)) {
      return 'Geçersiz kart numarası biçimi (13-19 hane, sadece rakam).';
    }

    // if (!_luhnCheck(cleanedValue)) {
    //   return 'Geçersiz kart numarası.';
    // }

    return null;
  }
}
