// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/models/homestay/room/room_model.dart';
import 'package:mobile_home_travel/models/wallet/transaction_model.dart';
import 'package:mobile_home_travel/models/wallet/wallet_model.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletSuccess extends WalletState {
  WalletModel walletModel;
  List<TransactionModel> listTransaction;
  WalletSuccess({
    required this.walletModel,
    required this.listTransaction,
  });
}

class WalletFailure extends WalletState {
  final String error;

  const WalletFailure({required this.error});
}

class AddFundWalletFailure extends WalletState {
  final String error;

  const AddFundWalletFailure({required this.error});
}

class AddFundWalletSuccess extends WalletState {
  final String link;

  const AddFundWalletSuccess({required this.link});
}
