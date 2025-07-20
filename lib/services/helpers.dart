String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return 'Email cannot be empty';
  }
  int atIndex = email.indexOf('@');
  if (atIndex == -1 || atIndex == 0 || atIndex == email.length - 1) {
    // нет собачки в строке, или в начале строки, или в конце
    return 'Please enter a valid adress email';
  }

  return null;
}
