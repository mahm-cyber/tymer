import 'user_type.dart';

class TymerNotification {
  const TymerNotification({
    this.id,
    this.userType,
    required this.type,
    this.disputeId,
    this.serviceRequestId,
  });

  final String? id;
  final UserType? userType;
  final NotificationType type;
  final int? disputeId;
  final int? serviceRequestId;

  bool get shouldNavigateToFulfillServiceRequestScreen =>
      userType == UserType.provider && type == NotificationType.order;

  bool get shouldNavigateToRequestStatusScreen =>
      userType == UserType.requester && type == NotificationType.order;

  bool get shouldNavigateToRequesterDisputeChatScreen =>
      userType == UserType.requester && type == NotificationType.dispute;

  bool get shouldNavigateToProviderDisputeChatScreen =>
      userType == UserType.provider && type == NotificationType.dispute;

  bool get shouldNavigateToSupportChatScreen =>
      type == NotificationType.support;

  bool get shouldNavigateToWalletScreen => type == NotificationType.wallet;
}

enum NotificationType {
  order,
  dispute,
  wallet,
  support,
}
