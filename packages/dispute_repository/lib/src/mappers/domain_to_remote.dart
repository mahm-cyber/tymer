import 'package:domain_models/domain_models.dart';

extension DisputeRequestsFetchModeDMtoRM on UserType {
  String toRemoteModel() {
    switch (this) {
      case UserType.requester:
        return 'requester';
      case UserType.provider:
        return 'provider';
    }
  }
}

extension DisputeStatusDMtoRM on DisputeStatus {
  String toRemoteModel() {
    switch (this) {
      case DisputeStatus.pendingReview:
        return 'pending-review';
      case DisputeStatus.chargedBack:
        return 'charged-back';
      case DisputeStatus.denied:
        return 'denied';
    }
  }
}
