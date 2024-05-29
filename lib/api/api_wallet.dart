import 'dart:convert';

import 'package:mobile_home_travel/api/api_header.dart';
import 'package:mobile_home_travel/constants/baseUrlApi.dart';
import 'package:mobile_home_travel/models/bank/bank_model.dart';
import 'package:mobile_home_travel/models/wallet/transaction_model.dart';
import 'package:mobile_home_travel/models/wallet/wallet_model.dart';
import 'package:mobile_home_travel/utils/shared_preferences_util.dart';
import 'package:http/http.dart' as http;

class ApiWallet {
  // <<<< Get wallet >>>>
  static Future<WalletModel?> getWallet() async {
    List<WalletModel>? listWallet;
    String? token = SharedPreferencesUtil.getToken();
    String? idTourist = SharedPreferencesUtil.getIdUserCurrent();
    try {
      var url = "$baseUrl/api/v1/Wallets?pageSize=50&touristId=$idTourist";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      print("TEST get wallet: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        var postsJson = bodyConvert['data'];
        listWallet = (postsJson as List)
            .map<WalletModel>((postJson) => WalletModel.fromMap(postJson))
            .toList();
        print("Thông tin model từ get wallet: $listWallet");
        return listWallet[0];
      } else {
        print('Lỗi wallet');
        return null;
      }
    } catch (e) {
      print("Loi get wallet: $e");
    }
    return null;
  }

  // <<<< Add funds to wallet >>>>
  static Future<String?> addFund({required double amountFund}) async {
    String? link;
    String? token = SharedPreferencesUtil.getToken();
    String? idTourist = SharedPreferencesUtil.getIdUserCurrent();
    var url = "$baseUrl/api/v1/VnPays/Topup";
    Map<String, String> header = await ApiHeader.getHeader();
    header.addAll({'Authorization': 'Bearer $token'});
    try {
      final body = {
        'amount': amountFund,
        'touristId': idTourist,
      };
      var response = await http.post(Uri.parse(url.toString()),
          headers: header, body: jsonEncode(body));
      print("TEST nạp tiền: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        link = bodyConvert['data']['url'];
        print('Link là: $link');
        return link;
      } else {
        print('Error add fund');
        return null;
      }
    } catch (e) {
      print("Loi nạp tiền: $e");
    }
    return null;
  }

  // <<<< Get all transaction >>>>
  static Future<List<TransactionModel>?> getAllTransaction(
      {required String idWallet}) async {
    List<TransactionModel>? transaction;
    String? token = SharedPreferencesUtil.getToken();
    String? idTourist = SharedPreferencesUtil.getIdUserCurrent();

    try {
      // var url = "$baseUrl/api/v1/Transactions?pageSize=50&walletId=$idWallet";
      var url =
          "$baseUrl/api/v1/Transactions?pageSize=50&paidUserId=$idTourist";
      Map<String, String> header = await ApiHeader.getHeader();
      header.addAll({'Authorization': 'Bearer $token'});
      var response = await http.get(Uri.parse(url.toString()), headers: header);
      print(
          "TEST get all transaction: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
        // print("Xem body sau khi convert: $bodyConvert");
        var postsJson = bodyConvert['data'];
        transaction = (postsJson as List)
            .map<TransactionModel>(
                (postJson) => TransactionModel.fromMap(postJson))
            .toList();
        // print("Thông tin get all transaction: $transaction");
        return transaction;
      } else {
        print('Lỗi get lịch sử gd');
        return null;
      }
    } catch (e) {
      print("Loi get all transaction: $e");
    }
    return null;
  }

  // <<<< Get list bank >>>>
  static Future<List<BankModel>?> getListBank() async {
    List<BankModel>? listWallet;
    try {
      var url = "https://api.vietqr.io/v2/banks";
      var response = await http.get(Uri.parse(url.toString()));
      // print(
      //     "TEST get list bank: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      var bodyConvert = jsonDecode(response.body);
      var postsJson = bodyConvert['data'];
      listWallet = (postsJson as List)
          .map<BankModel>((postJson) => BankModel.fromMap(postJson))
          .toList();
      // print("Thông tin model từ get list bank: $listWallet");
      return listWallet;
    } catch (e) {
      print("Loi get list bank: $e");
    }
    return null;
  }

  // <<<< Withdraw wallet >>>>
  static Future<String?> withdrawWallet({
    required String idWallet,
    required num amount,
    required String bankName,
    required String bankNumber,
  }) async {
    try {
      print('Số tiền rút trong api là: $amount');
      var url =
          "$baseUrl/api/v1/Wallets/$idWallet/WithDraw?amount=$amount&bankName=$bankName&bankNumber=$bankNumber";
      var response = await http.get(Uri.parse(url.toString()));
      var bodyConvert = jsonDecode(utf8.decode(response.bodyBytes));
      var result = bodyConvert['msg'];
      print("TEST rút wallet: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      if (response.statusCode == 200) {
        return result;
      } else {
        print('Lỗi rút ví');
        return result;
      }
    } catch (e) {
      print("Loi rút wallet: $e");
    }
    return 'Tính năng rút tiền đang gặp trục trặc!';
  }
}
