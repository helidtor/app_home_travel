// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class InputCalculatePriceModel {
  String? roomId;
  String? startDate;
  String? endDate;
  InputCalculatePriceModel({
    this.roomId,
    this.startDate,
    this.endDate,
  });

  InputCalculatePriceModel copyWith({
    String? roomId,
    String? startDate,
    String? endDate,
  }) {
    return InputCalculatePriceModel(
      roomId: roomId ?? this.roomId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roomId': roomId,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  factory InputCalculatePriceModel.fromMap(Map<String, dynamic> map) {
    return InputCalculatePriceModel(
      roomId: map['roomId'] != null ? map['roomId'] as String : null,
      startDate: map['startDate'] != null ? map['startDate'] as String : null,
      endDate: map['endDate'] != null ? map['endDate'] as String : null,
    );
  }

  // String toJson() => json.encode(toMap());

  factory InputCalculatePriceModel.fromJson(String source) =>
      InputCalculatePriceModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  @override
  String toString() =>
      'InputCalculatePriceModel(roomId: $roomId, startDate: $startDate, endDate: $endDate)';

  @override
  bool operator ==(covariant InputCalculatePriceModel other) {
    if (identical(this, other)) return true;

    return other.roomId == roomId &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode => roomId.hashCode ^ startDate.hashCode ^ endDate.hashCode;
}
