class CheckPasswordValid {
  bool isPasswordValid(String password) {
    if (password.length < 8) {
      return false;
    }

    // Kiểm tra xem có chứa ít nhất 1 chữ hoa và 1 chữ thường không
    bool hasUppercase = false;
    bool hasLowercase = false;

    for (int i = 0; i < password.length; i++) {
      if (password[i].toUpperCase() != password[i]) {
        hasLowercase = true;
      } else if (password[i].toLowerCase() != password[i]) {
        hasUppercase = true;
      }
    }

    return hasUppercase && hasLowercase;
  }
}
