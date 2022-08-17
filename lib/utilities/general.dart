import 'dart:math';
import 'package:cell_avenue_store/ui/dialogs/custom_dialog.dart';
import 'package:flutter/material.dart';

import 'package:klocalizations_flutter/klocalizations_flutter.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ui/dialogs/custom_progress_dialog.dart';

class General {
  // static ArsProgressDialog _progressDialog;
  static CustomProgressDialog? _dialog;

  static Future<String?> getStringSP(String key) async {
    final sp = await SharedPreferences.getInstance();
    var data = sp.getString(key);
    return data;
  }

  static Map<String, dynamic> removeNullsFromMap(Map<String, dynamic> json) =>
      json
        ..removeWhere((String key, dynamic value) => value == null)
        ..map<String, dynamic>(
            (key, value) => MapEntry(key, removeNulls(value)));

  static List removeNullsFromList(List list) => list
    ..removeWhere((value) => value == null)
    ..map((e) => removeNulls(e)).toList();

  static removeNulls(e) => (e is List)
      ? removeNullsFromList(e)
      : (e is Map<String, dynamic> ? removeNullsFromMap(e) : e);

  // static Future<bool> checkVersion(String storeVersion) async {
  //   if (storeVersion.isEmpty) {
  //     return false;
  //   }
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   String currentVersion = packageInfo.version;
  //   List<String> store = storeVersion.split(".");
  //   List<String> current = currentVersion.split(".");
  //   print('storeVersion: $storeVersion');
  //   print('currentVersion: $currentVersion');
  //   try {
  //     // To avoid IndexOutOfBounds
  //     int maxIndex = min(store.length, current.length);
  //     for (int i = 0; i < maxIndex; i++) {
  //       int n1 = int.parse(store[i]);
  //       int n2 = int.parse(current[i]);
  //       if (n1 > n2) {
  //         return true;
  //       } else if (n2 > n1) return false;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   return false;
  // }

//   static addProductToCart(
//       {required int productId,
//       required String price,
//       required String name,
//       required String image}) {
//     var cart = FlutterCart();
//     cart.addToCart(
//       productId: productId,
//       unitPrice: double.parse(price),
//       productName: name,
//       productDetailsObject: image,
//     );
//   }
//
//   static decrementItemQuantity(
//       {required int productId}) {
//     var cart = FlutterCart();
//     cart.decrementItemFromCart(cart.cartItem.indexWhere((element) => element.productId == productId));
//   }
//
//   static incrementItemQuantity(
//       {required int productId}) {
//     var cart = FlutterCart();
//     cart.incrementItemToCart(cart.cartItem.indexWhere((element) => element.productId == productId));
//   }
//
//   static removeItemFromCart(
//       {required int productId}) {
//     var cart = FlutterCart();
//     cart.deleteItemFromCart(cart.cartItem.indexWhere((element) => element.productId == productId));
//   }
//
//   static clearCart() {
//     var cart = FlutterCart();
//     cart.deleteAllCart();
//   }
//
// static int getCountProductsFromCart() {
//     var cart = FlutterCart();
//     int totalCount = 0;
//     cart.cartItem.forEach((element) {
//       totalCount += element.quantity;
//     });
//     return totalCount;}
//
//   static List<CartItem> getProductsFromCart() {
//     var cart = FlutterCart();
//     return cart.cartItem;
//   }
//
//   static CartItem? getSingleProductFromCart(int productId) {
//     var cart = FlutterCart();
//     return cart.getSpecificItemFromCart(productId);
//   }
//
//   static int getSingleProductQuantity(int productId) {
//     var cart = FlutterCart();
//     return cart.getSpecificItemFromCart(productId)!.quantity;
//   }
//
//   static double getCartTotalAmount() {
//     var cart = FlutterCart();
//     var totalAmount = 0.0;
//     cart.cartItem.forEach((element) {
//       totalAmount+=(element.quantity * element.unitPrice);
//     });
//     return double.parse(totalAmount.toStringAsFixed(2));
//   }

  static Future<bool> searchInSP(String key) async {
    final sp = await SharedPreferences.getInstance();
    var data = sp.containsKey(key);
    return data;
  }

  // static Future<bool> checkUserAvailability() async {
  //   if (await getUser() != null) return true;
  //   return false;
  // }

  static String getTranslatedText(context, key,
      {Map<String, dynamic>? params}) {
    final localizations = Provider.of<KLocalizations>(context, listen: false);
    return localizations.translate(key, params: params);
  }

  // static launchMapURL(latLon) async {
  //   var url = 'https://www.google.com/maps/search/?api=1&query=$latLon';
  //   url = Uri.encodeFull(url);
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Error launching $url';
  //   }
  // }

  // static makeCall(number) async {
  //   var url = 'tel: $number';
  //   url = Uri.encodeFull(url);
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Error launching $url';
  //   }
  // }
  //
  // static launchURL(url) async {
  //   url = Uri.encodeFull(url);
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Error launching $url';
  //   }
  // }

  static void changeLanguage(context, langKey) {
    final localizations = Provider.of<KLocalizations>(context, listen: false);
    setStringSP('lang', langKey);
    localizations.setLocale(Locale(langKey));
  }

  static String getLanguage(context) {
    final localizations = Provider.of<KLocalizations>(context, listen: false);
    return localizations.locale.languageCode;
  }

  static showProgress(context) {
    _dialog = CustomProgressDialog(
      context: context,
      isDismissible: false,
      // message: getTranslatedText(context, 'loading'),
    );
    _dialog?.show();
  }

  // static void saveUser(String data) {
  //   final box = GetStorage();
  //   print(data);
  //   box.write('user', data);
  // }
  //
  // static void logout()async{
  //   final box = GetStorage();
  //   await box.erase();
  // }
  //
  // static User? getUser() {
  //   final box = GetStorage();
  //   var user = box.read<String>('user');
  //   if(user!=null)
  //     return User.fromJson(user);
  //   return null;
  // }

  // static Client? getClient() {
  //   final box = GetStorage();
  //   var client = box.read<String>('client');
  //   if (client != null) return Client.fromJson(client);
  //   return null;
  // }

  // static void saveConfig(String data) {
  //   final box = GetStorage();
  //   print(data);
  //   box.write('config', data);
  // }
  //
  // static Configurations getConfig() {
  //   final box = GetStorage();
  //   var config = box.read<String>('config');
  //   if(config==null){
  //     return Configurations();
  //   }
  //   return Configurations.fromJson(config);
  // }

  static dismissProgress() {
    _dialog?.hide();
    _dialog = null;
  }

  static showErrorDialog(context, message) {
    return CustomDialog(
      dialogType: DialogType.ERROR,
      message: '$message',
      buttonText: getTranslatedText(context, 'ok'),
    )..show(context);
  }

  static showInfoDialog(context, message) {
    return CustomDialog(
      dialogType: DialogType.INFO,
      message: '$message',
      buttonText: getTranslatedText(context, 'ok'),
    )..show(context);
  }

  static showSuccessDialog(context, title, {Function? btnOkOnPress}) {
    return CustomDialog(
      dialogType: DialogType.SUCCESS,
      message: '$title',
      buttonText: getTranslatedText(context, 'ok'),
    )..show(context);
  }

  static String replaceArabicNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      //arabic to english
      input = input.replaceAll(arabic[i], english[i]);
      //English to Arabic
      // input = input.replaceAll(english[i],arabic[i]);
    }
    return input;
  }

  // static launchURL(context, url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     showErrorDialog(context, 'لا يمكننا عرض الرابط حالياً, حاول لاحقاً');
  //   }
  // }

  static Future<bool> getBooleanSP(String key) async {
    final sp = await SharedPreferences.getInstance();
    var data = sp.getBool(key);
    data ??= false;
    return data;
  }

  static Future<int?> getIntSP(String key) async {
    final sp = await SharedPreferences.getInstance();
    var data = sp.getInt(key);
    return data;
  }

  static void setStringSP(String key, String data) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(key, data);
  }

  static void removeValueFromSP(String key) async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(key);
  }

  static void clearSP() async {
    final sp = await SharedPreferences.getInstance();
    await sp.clear();
  }

  static void setIntSP(String key, int data) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setInt(key, data);
  }

  static void setBooleanSP(String key, bool data) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setBool(key, data);
  }
}
