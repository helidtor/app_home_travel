import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/api/api_wallet.dart';
import 'package:mobile_home_travel/models/bank/bank_model.dart';
import 'package:mobile_home_travel/models/wallet/transaction_model.dart';
import 'package:mobile_home_travel/screens/wallet/bloc/wallet_event.dart';
import 'package:mobile_home_travel/screens/wallet/bloc/wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial()) {
    // event handler was added
    on<WalletEvent>((event, emit) async {
      await post(emit, event);
    });
  }
  post(Emitter<WalletState> emit, WalletEvent event) async {
    emit(WalletLoading());
    try {
      if (event is GetWallet) {
        var wallet = await ApiWallet.getWallet();
        List<TransactionModel>? listTransaction;
        if (wallet != null) {
          listTransaction =
              await ApiWallet.getAllTransaction(idWallet: wallet.id!);
          //get tất cả giao dịch
          if (listTransaction!.isNotEmpty) {
            emit(WalletSuccess(
                walletModel: wallet, listTransaction: listTransaction));
          } else {
            emit(WalletSuccess(walletModel: wallet, listTransaction: const []));
          }
        } else {
          const WalletFailure(error: "Lỗi ví");
        }
      } else if (event is AddFundWallet) {
        String? link = await ApiWallet.addFund(amountFund: event.amount);
        if (link != null) {
          emit(AddFundWalletSuccess(link: link));
        } else {
          emit(const AddFundWalletFailure(error: 'Lỗi nạp tiền!'));
        }
      } else if (event is GetListBank) {
        List<BankModel>? listBank;
        listBank = await ApiWallet.getListBank();
        if (listBank!.isNotEmpty) {
          emit(GetListBankSuccess(listBank: listBank));
        } else {
          emit(const GetListBankFailure(msg: 'Rút tiền hiện không khả dụng!'));
        }
      }
    } catch (e) {
      emit(const WalletFailure(error: "Lỗi ví"));
    }
  }
}
