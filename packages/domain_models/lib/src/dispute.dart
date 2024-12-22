import 'dart:ui';

import 'package:domain_models/src/service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Dispute extends Equatable {
  const Dispute({
    required this.id,
    required this.serviceRequestId,
    required this.serviceRequest,
    required this.status,
    this.resolverId,
    required this.reason,
    required this.  createdAt,
  });

  final int id;
  final int serviceRequestId;
  final Service serviceRequest;
  final DisputeStatus status;
  final int? resolverId;
  final String? reason;
  final DateTime createdAt;

  @override
  List<Object?> get props => [
        id,
        serviceRequestId,
        serviceRequest,
        status,
        resolverId,
        reason,
      ];

  Dispute copyWith({
    DisputeStatus? status,
  }) {
    return Dispute(
      id: id,
      serviceRequestId: serviceRequestId,
      serviceRequest: serviceRequest,
      status: status ?? this.status,
      resolverId: resolverId,
      reason: reason,
      createdAt: createdAt,
    );
  }
}

class DisputeListPage {
  DisputeListPage({
    required this.list,
    required this.isLastPage,
  });

  final List<Dispute> list;
  final bool isLastPage;
}

enum DisputeStatus {
  pendingReview,
  chargedBack,
  denied;

  Color get color {
    switch (this) {
      case DisputeStatus.pendingReview:
        return const Color(0xFF2D9CDB);
      case DisputeStatus.chargedBack:
        return const Color(0xFF2C8268);
      case DisputeStatus.denied:
        return const Color(0xFFEB5757);
    }
  }
}
