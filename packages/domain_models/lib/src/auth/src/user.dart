import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? emailVerifiedAt;
  final String? phoneVerifiedAt;
  final List? permissions;
  final List? roles;
  final String? createdAt;
  final Locale? language;
  final String? updatedAt;
  final String? deletedAt;
  final double balance;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    this.permissions,
    this.roles,
    this.createdAt,
    this.language,
    this.updatedAt,
    this.deletedAt,
    required this.balance,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        emailVerifiedAt,
        phoneVerifiedAt,
        permissions,
        roles,
        createdAt,
        language,
        updatedAt,
        deletedAt,
        balance,
      ];
}
