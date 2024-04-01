// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WalletModel {
  String? id;
  num? balance;
  String? touristId;
  WalletModel({
    this.id,
    this.balance,
    this.touristId,
  });

  WalletModel copyWith({
    String? id,
    num? balance,
    String? touristId,
  }) {
    return WalletModel(
      id: id ?? this.id,
      balance: balance ?? this.balance,
      touristId: touristId ?? this.touristId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'balance': balance,
      'touristId': touristId,
    };
  }

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      id: map['id'] != null ? map['id'] as String : null,
      balance: map['balance'] != null ? map['balance'] as num : null,
      touristId: map['touristId'] != null ? map['touristId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletModel.fromJson(String source) => WalletModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WalletModel(id: $id, balance: $balance, touristId: $touristId)';

  @override
  bool operator ==(covariant WalletModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.balance == balance &&
      other.touristId == touristId;
  }

  @override
  int get hashCode => id.hashCode ^ balance.hashCode ^ touristId.hashCode;
}
