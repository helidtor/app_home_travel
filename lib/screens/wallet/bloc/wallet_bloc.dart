import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:mobile_home_travel/api/api_user.dart';
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
        var wallet = await ApiUser.getWallet();
        if (wallet != null) {
          emit(WalletSuccess(walletModel: wallet));
        } else {
          const WalletFailure(error: "Lỗi ví");
        }
      } else if (event is AddFundWallet) {
        String? link = await ApiUser.addFund(amountFund: event.amount);
        if (link != null) {
          emit(AddFundWalletSuccess(link: link));
        } else {
          emit(const AddFundWalletFailure(error: 'Lỗi nạp tiền'));
        }
      }
    } catch (e) {
      emit(const WalletFailure(error: "Lỗi ví"));
    }
  }
}
