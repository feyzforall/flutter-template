/// `Endpoints` sınıfı, uygulamada http istekleri için kullanılacak olan
/// endpointleri içerir.
class Endpoints {
  // Singleton
  static final Endpoints _instance = Endpoints._internal();

  factory Endpoints() {
    return _instance;
  }

  Endpoints._internal();

  static const String baseUrl = '';
  static const String token = '';
}
