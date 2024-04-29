import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_home_travel/models/notification/notification_model.dart';
import 'package:mobile_home_travel/screens/notifications/bloc/notification_bloc.dart';
import 'package:mobile_home_travel/screens/notifications/bloc/notification_event.dart';
import 'package:mobile_home_travel/screens/notifications/bloc/notification_state.dart';
import 'package:mobile_home_travel/screens/notifications/ui/row_notification.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/utils/navigator/navigator_bar.dart';
import 'package:mobile_home_travel/widgets/input/text_content.dart';
import 'package:toastification/toastification.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> listNotification = [];
  String displayScreen = 'assets/images/empty_list.png';
  double widthDisplay = 350;
  double heightDisplay = 350;
  final _bloc = NotificationBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.add(GetListNotification());
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          shadowColor: Colors.grey,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NavigatorBar(
                          stt: 4,
                        )),
              );
            },
            icon: const Icon(Icons.keyboard_arrow_left),
          ),
          // centerTitle: true,
          title: const Text(
            "Thông báo",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(182, 0, 0, 0),
              fontSize: 20,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: BlocConsumer<NotificationBloc, NotificationState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is NotificationLoading) {
              setState(() {
                widthDisplay = 50;
                heightDisplay = 50;
                displayScreen = 'assets/gifs/loading.gif';
              });
            } else if (state is GetNotificationSuccess) {
              listNotification = state.listNotification;
            } else if (state is NotificationEmpty) {
              setState(() {
                widthDisplay = 350;
                heightDisplay = 350;
                displayScreen = 'assets/images/empty_list.png';
              });
            } else if (state is NotificationError) {
              setState(() {
                widthDisplay = 300;
                heightDisplay = 300;
                displayScreen = 'assets/images/error_loading.png';
              });
              toastification.show(
                  pauseOnHover: false,
                  showProgressBar: false,
                  progressBarTheme: const ProgressIndicatorThemeData(
                    color: Colors.red,
                  ),
                  icon: const Icon(
                    Icons.error_outline_rounded,
                    color: Colors.red,
                  ),
                  foregroundColor: Colors.black,
                  context: context,
                  type: ToastificationType.error,
                  style: ToastificationStyle.flatColored,
                  title: TextContent(
                    contentText: state.error,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  autoCloseDuration: const Duration(milliseconds: 2500),
                  animationDuration: const Duration(milliseconds: 500),
                  alignment: Alignment.topCenter);
            }
          },
          builder: (context, state) {
            return listNotification.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 15, bottom: 10),
                          child: Text(
                            'Mới nhất',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                        Center(
                          child: Column(
                            children: List.generate(
                              1,
                              (index) => RowNotification(
                                  notificationModel: listNotification[index]),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            width: screenSize.width * 0.9,
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 15, bottom: 10),
                          child: Text(
                            'Trước đó',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                        Center(
                          child: Column(
                            children: List.generate(
                              listNotification.length - 1,
                              (index) => Padding(
                                padding: const EdgeInsets.all(1),
                                child: RowNotification(
                                    notificationModel:
                                        listNotification[index + 1]),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: SizedBox(
                      width: widthDisplay,
                      height: heightDisplay,
                      child: Image.asset(
                        displayScreen,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
