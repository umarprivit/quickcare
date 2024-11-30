import 'package:pharmacy_store/Repository.dart';

class RepositorySingleton {
  // Singleton instance of Repository
  static final Repository _repository = Repository();

  // Private constructor to prevent instantiation
  RepositorySingleton._();

  // Accessor for the singleton instance
  static Repository get instance => _repository;
}
