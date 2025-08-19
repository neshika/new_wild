// Импортируем пакет для аутентификации Firebase
// Эта строка была добавлена с помощью команды: flutter pub add firebase_auth
import 'package:firebase_auth/firebase_auth.dart';

// Класс-сервис для работы с аутентификацией пользователей
// Содержит все методы для входа, выхода, регистрации и восстановления пароля
class Auth {
  // Создаем экземпляр FirebaseAuth для работы с аутентификацией
  // _firebaseAuth - приватное поле (начинается с _), доступное только внутри этого класса
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Геттер для получения текущего пользователя
  // Возвращает User? - может вернуть пользователя или null, если никто не авторизован
  User? get getCurrentUser => _firebaseAuth.currentUser;

  // Геттер для получения ID текущего пользователя
  // Возвращает String? - может вернуть uid или null
  String? get getUserId => _firebaseAuth.currentUser?.uid;

  // Геттер для получения потока изменений состояния аутентификации
  // Stream - это "поток данных", который будет отправлять события при изменении состояния входа
  // Используется в main.dart для автоматического переключения между экранами
  Stream<User?> get getAuthStateChange => _firebaseAuth.authStateChanges();

  // Метод для входа существующего пользователя по email и паролю
  // Future<void> - означает, что метод асинхронный и не возвращает конкретного значения
  // {required ...} - именованные обязательные параметры
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Вызываем метод FirebaseAuth для входа
      // await - ждем завершения операции
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {
      // Ловим исключения, которые могут возникнуть при входе
      // (неверный пароль, пользователь не найден и т.д.)
      // В текущей реализации ошибки просто "проглатываются" - можно добавить обработку
      // print(error);
    }
  }

  // Метод для выхода пользователя из системы
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Метод для восстановления пароля
  // Отправляет письмо для сброса пароля на указанный email
  Future<void> repearPassword({
    required String email,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(
        email: email,
      );
    } on FirebaseAuthException {
      // Обработка возможных ошибок (неверный email и т.д.)
      // print(error);
    }
  }

  // Метод для регистрации нового пользователя
  // Создает новую учетную запись по email и паролю
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {
      // Обработка ошибок регистрации (email уже используется, слабый пароль и т.д.)
      // print(error);
    }
  }
}
