import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String id;
  final String name;
  final String phoneNumber;
  final String address;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
    this.selectedAddress = true,
  });

  static AddressModel empty() => AddressModel(
        id: '',
        name: '',
        phoneNumber: '',
        address: '',
      );

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'PhoneNumber': phoneNumber,
      'Address': address,
      'SelectedAddress': selectedAddress,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      id: data['Id'] as String,
      name: data['Name'] as String,
      phoneNumber: data['PhoneNumber'] as String,
      address: data['Address'] as String,
      selectedAddress: data['SelectedAddress'] as bool,
    );
  }

  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return AddressModel(
      id: snapshot.id,
      name: data['Name'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      address: data['Address'] ?? '',
      selectedAddress: data['SelectedAddress'] as bool,
    );
  }
}
