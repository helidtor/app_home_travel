// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class GetWallet extends WalletEvent {}

class AddFundWallet extends WalletEvent {
  double amount;
  AddFundWallet({
    required this.amount,
  });
}

class GetListBank extends WalletEvent {}
