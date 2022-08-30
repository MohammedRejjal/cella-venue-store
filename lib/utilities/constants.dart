import 'package:flutter/foundation.dart';

import 'package:flutter/foundation.dart';

abstract class Constants {
  static const String BASE_URL = 'https://cellavenuestore.com';
  static const String LOST_PASSWORD_WEB_URL =
      'https://staging.jsscent.com/my-account-2/lost-password';
  // static const String LOST_PASSWORD_WEB_URL = 'https://jsscent.com/my-account-2/lost-password';
  // static const String BASE_URL = 'https://jsscent.com';
  static const String BASE_AUTH_URL = '$BASE_URL/wp-json/jwt-auth/v1/token';
  static const String _consumerKey =
      'consumer_key=ck_6114d7418f75540206977b0d4868b4ad442ab343';
  static const String _consumerSecert =
      'consumer_secret=cs_f5bd3e8e305ac60c97fb49a0ee50f4efe5700529';
  static const String wooAuth = '?$_consumerKey&$_consumerSecert';
  static const String TAB_SECRET_KEY = kDebugMode
      ? 'sk_test_x2zKpqUlYH6JiFu5Z4IDg39R'
      : 'sk_live_jxnpdM0mfXlTouCU4vIeGawS';
  static const String customer = '/wp-json/wc/v3/customers';
  static const String categories = '/wp-json/wc/v3/products/categories';
  static const String products = '/wp-json/wc/v3/products';
  static const String variations = '/wp-json/wc/v3/variations';
  static const String order = '/wp-json/wc/v3/orders';
  static const String coupons = '/wp-json/wc/v3/coupons';
  static const String shippingZones = '/wp-json/wc/v3/shipping/zones';
  static const String getBrand = '/wp-json/wc/v3/products/attributes/1/terms';
  static const String PAYMENT_METHODS = '/wp-json/wc/v3/payment_gateways';
  static const String shippingMethods = 'methods';
  static const String shippingLocations = 'locations';
  static const String arabicReturnPolicy = '/wp-json/wp/v2/pages/1885';
  static const String englishReturnPolicy = '/wp-json/wp/v2/pages/1356';
  static const String englishTermsPolicy = '/wp-json/wp/v2/pages/1356';
  static const String arabicAboutUs = '/wp-json/wp/v2/pages/1143';
  static const String englishAboutUs = '/wp-json/wp/v2/pages/1971';
  static const String englishPrivacyPolicy = '/wp-json/wp/v2/pages/3';
  static const String arabicPrivacyPolicy = '/wp-json/wp/v2/pages/6045';
  static const String banner = '/wp-json/wp/v2/mobile_banners';
  static const String RESET_PASSWORD = '/wp-json/bdpwr/v1/reset-password';
  static const String RESET_PASSWORD_VALIDATE =
      '/wp-json/bdpwr/v1/validate-code';
  static const String SET_PASSWORD = '/wp-json/bdpwr/v1/set-password';
  static const String promotion = '/wp-json/wp/v2/mobile_promotions';
  static const String TOTAL_PAGES_KEY = 'x-wp-totalpages';
  static const String DISCOUNT_TYPE_PERCENT = 'percent';
  static const String DISCOUNT_TYPE_FIXED = 'fixed_cart';
  static const IN_MAINTENANCE =
      kDebugMode ? 'debug_in_maintenance' : 'in_maintenance';
  static const APP_VERSION = kDebugMode ? 'debug_app_version' : 'app_version';
  static const String CartScreenUrl = "https://cellavenuestore.com/cart/";
}
