// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:mobile_home_travel/models/user/profile_user_model.dart';

class FeedbackModel {
  String? id;
  String? bookingId;
  String? description;
  double? rating;
  String? createdDate;
  String? touristId;
  String? homeStayId;
  UserProfileModel? tourist;
  FeedbackModel({
    this.id,
    this.bookingId,
    this.description,
    this.rating,
    this.createdDate,
    this.touristId,
    this.homeStayId,
    this.tourist,
  });

  FeedbackModel copyWith({
    String? id,
    String? bookingId,
    String? description,
    double? rating,
    String? createdDate,
    String? touristId,
    String? homeStayId,
    UserProfileModel? tourist,
  }) {
    return FeedbackModel(
      id: id ?? this.id,
      bookingId: bookingId ?? this.bookingId,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      createdDate: createdDate ?? this.createdDate,
      touristId: touristId ?? this.touristId,
      homeStayId: homeStayId ?? this.homeStayId,
      tourist: tourist ?? this.tourist,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'bookingId': bookingId,
      'description': description,
      'rating': rating,
      'createdDate': createdDate,
      'touristId': touristId,
      'homeStayId': homeStayId,
      'tourist': tourist?.toMap(),
    };
  }

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      id: map['id'] != null ? map['id'] as String : null,
      bookingId: map['bookingId'] != null ? map['bookingId'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      rating: map['rating'] != null ? map['rating'] as double : null,
      createdDate:
          map['createdDate'] != null ? map['createdDate'] as String : null,
      touristId: map['touristId'] != null ? map['touristId'] as String : null,
      homeStayId:
          map['homeStayId'] != null ? map['homeStayId'] as String : null,
      tourist: map['tourist'] != null
          ? UserProfileModel.fromMap(map['tourist'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedbackModel.fromJson(String source) =>
      FeedbackModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FeedbackModel(id: $id, bookingId: $bookingId, description: $description, rating: $rating, createdDate: $createdDate, touristId: $touristId, homeStayId: $homeStayId, tourist: $tourist)';
  }

  @override
  bool operator ==(covariant FeedbackModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.bookingId == bookingId &&
        other.description == description &&
        other.rating == rating &&
        other.createdDate == createdDate &&
        other.touristId == touristId &&
        other.homeStayId == homeStayId &&
        other.tourist == tourist;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        bookingId.hashCode ^
        description.hashCode ^
        rating.hashCode ^
        createdDate.hashCode ^
        touristId.hashCode ^
        homeStayId.hashCode ^
        tourist.hashCode;
  }
}
