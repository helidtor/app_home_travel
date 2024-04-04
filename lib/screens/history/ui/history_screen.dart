import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/screens/history/bloc/history_bloc.dart';
import 'package:mobile_home_travel/screens/history/bloc/history_event.dart';
import 'package:mobile_home_travel/screens/history/bloc/history_state.dart';
import 'package:mobile_home_travel/screens/history/ui/history_row.dart';
import 'package:mobile_home_travel/widgets/notification/error_bottom.dart';
import 'package:mobile_home_travel/widgets/others/loading.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _bloc = HistoryBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.add(GetHistoryPending());
  }

  @override
  Widget build(BuildContext context) {
    BookingHomestayModel? bookingPending;

    return Scaffold(
      body: BlocConsumer<HistoryBloc, HistoryState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is HistoryLoading) {
              onLoading(context);
              return;
            } else if (state is HistorySuccess) {
              Navigator.pop(context);
              bookingPending = state.bookingPending;
            } else if (state is HistoryFailure) {
              Navigator.pop(context);
              showError(context, state.error);
            }
          },
          builder: (context, state) {
            return (bookingPending != null)
                ? HistoryRow(bookingHomestayModel: bookingPending!)
                : SizedBox();
          }),
    );
  }
}
