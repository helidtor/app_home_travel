// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_home_travel/widgets/buttons/round_gradient_button.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:mobile_home_travel/screens/booking/step_pick_room/ui/list_room_empty.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/utils/format/format.dart';
import 'package:mobile_home_travel/widgets/notification/error_provider.dart';

class PickDate extends StatefulWidget {
  String checkinTime;
  PickDate({
    super.key,
    required this.checkinTime,
  });

  @override
  State<PickDate> createState() => _PickDateState();
}

class _PickDateState extends State<PickDate> {
  final List<String> _days = <String>['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'];
  final DateRangePickerController _controller = DateRangePickerController();
  String _checkInDate = '';
  String _checkOutDate = '';
  String _displayCheckinDate = '';
  String _displayCheckoutDate = '';
  int quantityNormalDays = 0;
  int quantityWeekendDays = 0;
  bool canPickToday = false;
  bool _isPicked = false;
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(
    //     'Giờ dùng để check là: ${FormatProvider().convertStringToDateTime('${FormatProvider().convertTo24HourFormat(FormatProvider().convertTimeEarlierOneHour(widget.checkinTime).toString())} - ${FormatProvider().convertDate(DateTime.now().toString())}')}');
    canPickToday = (DateTime.now().isBefore(FormatProvider()
            .convertStringToDateTime(
                '${FormatProvider().convertTo24HourFormat(FormatProvider().convertTimeEarlierOneHour(widget.checkinTime).toString())} - ${FormatProvider().convertDate(DateTime.now().toString())}')))
        ? true //nếu thời gian hiện tại trước giờ checkin 1 tiếng thì cho chọn
        : false;
    // print(canPickToday);
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(
      () {
        print('a');
        if (args.value is PickerDateRange) {
          startDate = args.value.startDate ?? null;
          endDate = args.value.endDate ?? null;
          _checkInDate =
              DateFormat('yyyy/MM/dd').format(args.value.startDate ?? '');
          // ignore: lines_longer_than_80_chars
          _checkOutDate =
              DateFormat('yyyy/MM/dd').format(args.value.endDate ?? '');
          _displayCheckinDate =
              DateFormat('dd/MM').format(args.value.startDate);
          _displayCheckoutDate = DateFormat('dd/MM').format(args.value.endDate);
          _isPicked = true;
          //Đếm số ngày
          if (args.value.endDate != null && args.value.startDate != null) {
            quantityWeekendDays = FormatProvider().countWeekendDays(
                args.value.startDate, args.value.endDate); //số ngày cuối tuần
            quantityNormalDays = FormatProvider().countNormalDays(
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
    final double height = MediaQuery.of(context).size.height;
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
      body: Column(
        children: [
          Flexible(
            flex: 10,
            child: Stack(
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
                  margin: const EdgeInsets.only(top: 30),
                  child: SfDateRangePicker(
                    minDate: canPickToday
                        ? DateTime.now()
                        : DateTime.now().add(const Duration(days: 1)),
                    maxDate: DateTime.now().add(const Duration(days: 60)),
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
                    rangeSelectionColor:
                        AppColors.primaryColor3.withOpacity(0.5),
                    startRangeSelectionColor: AppColors.primaryColor0,
                    endRangeSelectionColor: AppColors.primaryColor0,
                    selectionMode: DateRangePickerSelectionMode.range,
                    navigationMode: DateRangePickerNavigationMode.scroll,
                    navigationDirection:
                        DateRangePickerNavigationDirection.vertical,
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
                    // onSubmit: (e) {
                    //   if (quantityNormalDays != 0 || quantityWeekendDays != 0) {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => ListRoomEmpty(
                    //               quantityNormalDays: quantityNormalDays,
                    //               quantityWeekendDays: quantityWeekendDays,
                    //               dateCheckIn: _checkInDate,
                    //               dateCheckOut: _checkOutDate)),
                    //     );
                    //   } else {
                    //     ErrorNotiProvider()
                    //         .showError(context, 'Bạn chưa chọn ngày!');
                    //   }
                    // },
                    showActionButtons: false,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (_displayCheckinDate.length > 2 &&
                          _displayCheckoutDate.length > 2)
                      ? 'Từ $_displayCheckinDate đến $_displayCheckoutDate (${FormatProvider().countDays(startDate!, endDate!)} ngày)'
                      : (_displayCheckinDate.length > 2 &&
                              _displayCheckoutDate == '')
                          ? 'Vui lòng chọn ngày trả phòng'
                          : (_displayCheckinDate == '' &&
                                  _displayCheckoutDate == '')
                              ? 'Vui lòng chọn ngày nhận & trả phòng'
                              : '',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: width * 0.95,
                  height: height * 0.075,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: _isPicked
                          ? AppColors.primaryColor3.withOpacity(0.7)
                          : Colors.grey.withOpacity(0.5),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onPressed: () {
                      _isPicked
                          ? {
                              if (quantityNormalDays != 0 ||
                                  quantityWeekendDays != 0)
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ListRoomEmpty(
                                            quantityNormalDays:
                                                quantityNormalDays,
                                            quantityWeekendDays:
                                                quantityWeekendDays,
                                            dateCheckIn: _checkInDate,
                                            dateCheckOut: _checkOutDate)),
                                  )
                                }
                              else
                                {
                                  ErrorNotiProvider()
                                      .showError(context, 'Bạn chưa chọn ngày!')
                                }
                            }
                          : {};
                    },
                    child: Center(
                      child: Text(
                        'Tiếp tục',
                        style: TextStyle(
                            color:
                                _isPicked ? Colors.white : Colors.grey.shade500,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
