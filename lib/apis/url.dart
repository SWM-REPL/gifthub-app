class ApiUrl {
  static const _baseUrl = 'https://api.gifthub.kr';

  static String get signin => '$_baseUrl/auth/sign-in';
  static String get signup => '$_baseUrl/auth/sign-up';
  static String get signout => '$_baseUrl/auth/sign-out';
  static String get refresh => '$_baseUrl/auth/refresh';

  static String get kakaoRedirectUri => '$_baseUrl/auth/sign-in/kakao/callback';
  static String get naverRedirectUri => '$_baseUrl/auth/sign-in/naver/callback';
  static String get googleRedirectUri =>
      '$_baseUrl/auth/sign-in/google/callback';
  static String get appleRedirectUri => '$_baseUrl/auth/sign-in/apple/callback';

  static String get vouchers => '$_baseUrl/vouchers';
  static String voucher(int id) => '$_baseUrl/vouchers/$id';
  static String voucherUsage(int id) => '$_baseUrl/vouchers/$id/usage';

  static String product(int id) => '$_baseUrl/products/$id';
}
