import 'package:domain_models/domain_models.dart';
import 'package:tymer_api/tymer_api.dart';

extension NotificationRMtoDM on NotificationRM {
  UserType? get userTypeDM {
    switch (type) {
      case 'dispute_selected_user_chat_message':
      case 'dispute_against_user_resolved':
      case 'response_accepted':
      case 'response_refused':
        return UserType.provider;
      case 'dispute_chat_message':
      case 'dispute_by_user_resolved':
      case 'service_request_accepted':
      case 'response_received':
        return UserType.requester;
      case 'top_up_success':
      case 'withdraw_success':
        return null;
      default:
        throw Exception('Unknown notification type: $type');
    }
  }

  NotificationType get notificationTypeDM {
    switch (type) {
      case 'dispute_chat_message':
      case 'dispute_selected_user_chat_message':
      case 'dispute_by_user_resolved':
      case 'response_refused':
      case 'dispute_against_user_resolved':
        return NotificationType.dispute;
      case 'response_received':
      case 'service_request_accepted':
      case 'response_accepted':
        return NotificationType.order;
      case 'top_up_success':
      case 'withdraw_success':
        return NotificationType.wallet;
      default:
        throw Exception('Unknown notification type: $type');
    }
  }



  TymerNotification toDomainModel() {

    return TymerNotification(
      id: id,
      disputeId: _parseId(disputeId),
      serviceRequestId: _parseId(serviceRequestId),
      type: notificationTypeDM,
      userType: userTypeDM,
    );
  }

  // Helper method for parsing IDs to avoid code duplication
  int? _parseId(String? id) => id != null ? int.tryParse(id) : null;
}
