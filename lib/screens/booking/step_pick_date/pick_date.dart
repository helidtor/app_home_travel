import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_home_travel/screens/booking/step_pick_room/ui/list_room_empty.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/notification/error_bottom.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PickDate extends StatefulWidget {
  const PickDate({super.key});

  @override
  State<PickDate> createState() => _PickDateState();
}

class _PickDateState extends State<PickDate> {
  final List<String> _days = <String>['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'];
  final DateRangePickerController _controller = DateRangePickerController();
  String _checkInDate = '';
  String _checkOutDate = '';
  int quantityNormalDays = 0;
  int quantityWeekendDays = 0;

  int _countWeekendDays(DateTime startDate, DateTime endDate) {
    int count = 0;
    for (DateTime date = startDate;
        (date.isBefore(endDate) || date.isAtSameMomentAs(endDate));
        date = date.add(const Duration(days: 1))) {
      if (date.weekday == DateTime.saturday ||
          date.weekday == DateTime.sunday) {
        count++;
      }
    }
    return count;
  }

  int _countNormalDays(DateTime startDate, DateTime endDate) {
    int count = 0;
    for (DateTime date = startDate;
        (date.isBefore(endDate) || date.isAtSameMomentAs(endDate));
        date = date.add(const Duration(days: 1))) {
      if (date.weekday != DateTime.saturday &&
          date.weekday != DateTime.sunday) {
        count++;
      }
    }
    return count;
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(
      () {
        if (args.value is PickerDateRange) {
          _checkInDate = DateFormat('yyyy/MM/dd').format(args.value.startDate);
          // ignore: lines_longer_than_80_chars
          _checkOutDate = DateFormat('yyyy/MM/dd')
              .format(args.value.endDate ?? args.value.startDate);
          //Đếm số ngày
          if (args.value.endDate != null && args.value.startDate != null) {
            quantityWeekendDays = _countWeekendDays(
                args.value.startDate, args.value.endDate); //số ngày cuối tuần
            quantityNormalDays = _countNormalDays(
                args.value.startDate, args.value.endDate); //số ngày thường
          } else if (args.value.startDate != null &&
              args.value.endDate == null) {
            //nếu chỉ chọn 1 ngày
            if (args.value.startDate.weekday == DateTime.saturday ||
                args.value.startDate.weekday == DateTime.sunday) {
              quantityNormalDays = 0;
              quantityWeekendDays = 1;
            } else {
              quantityNormalDays = 1;
              quantityWeekendDays = 0;
            }
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double cellWidth = width / 7;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        shadowColor: Colors.grey,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
        // centerTitle: true,
        title: const Text(
          "Chọn ngày",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(182, 0, 0, 0),
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _days.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext ctxt, int index) {
              return Container(
                padding: const EdgeInsets.only(top: 4),
                alignment: Alignment.topCenter,
                width: cellWidth,
                height: 10,
                color: AppColors.primaryColor3.withOpacity(0.7),
                child: Text(
                  _days[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              );
            },
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 5, right: 5, top: 30, bottom: 5),
            child: SfDateRangePicker(
              viewSpacing: 50,
              enableMultiView: true,
              enablePastDates: false,
              view: DateRangePickerView.month,
              onSelectionChanged: _onSelectionChanged,
              rangeTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              selectionTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              selectionRadius: 25,
              todayHighlightColor: AppColors.primaryColor0,
              rangeSelectionColor: AppColors.primaryColor3.withOpacity(0.5),
              startRangeSelectionColor: AppColors.primaryColor0,
              endRangeSelectionColor: AppColors.primaryColor0,
              selectionMode: DateRangePickerSelectionMode.range,
              navigationMode: DateRangePickerNavigationMode.scroll,
              navigationDirection: DateRangePickerNavigationDirection.vertical,
              backgroundColor: Colors.white,
              // headerHeight: 0,
              headerStyle: const DateRangePickerHeaderStyle(
                backgroundColor: Colors.white,
                textStyle: TextStyle(
                    color: AppColors.primaryColor0,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
                textAlign: TextAlign.center,
              ),
              monthViewSettings: const DateRangePickerMonthViewSettings(
                  showTrailingAndLeadingDates: false,
                  enableSwipeSelection: false,
                  viewHeaderHeight: 0,
                  dayFormat: DateFormat.ABBR_WEEKDAY,
                  numberOfWeeksInView: 6),
              cancelText: "",
              confirmText: "Tiếp",
              onSubmit: (e) {
                if (quantityNormalDays != 0 || quantityWeekendDays != 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListRoomEmpty(
                            quantityNormalDays: quantityNormalDays,
                            quantityWeekendDays: quantityWeekendDays,
                            dateCheckIn: _checkInDate,
                            dateCheckOut: _checkOutDate)),
                  );
                } else {
                  showError(context, 'Bạn chưa chọn ngày!');
                }
              },
              showActionButtons: true,
            ),
          ),
        ],
      ),
    );
  }
}
