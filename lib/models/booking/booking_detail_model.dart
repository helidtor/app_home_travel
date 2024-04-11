import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/models/homestay/room/room_model.dart';

class BookingDetailModel {
  String? id;
  num? price;
  String? roomId;
  String? bookingId;
  RoomModel? room;
  BookingHomestayModel? booking;
}
