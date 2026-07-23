import 'package:flutter_test/flutter_test.dart';
import 'package:tymer_api/src/models/response/src/paymob_top_up_rm.dart';

void main() {
  group('PaymobTopUpRM.fromJson', () {
    test('parses successfully when client_secret, intention_order_id and paymob_status are null', () {
      final json = {
        'message': 'Success',
        'data': null,
        'checkout_url': 'https://accept.paymob.com/standalone?payment_token=xyz',
        'client_secret': null,
        'intention_order_id': null,
        'paymob_transaction_id': '1234567',
        'internal_transaction_id': 99,
        'topup_request_status': 'pending',
        'paymob_status': null,
      };

      final rm = PaymobTopUpRM.fromJson(json);

      expect(rm.checkoutUrl, 'https://accept.paymob.com/standalone?payment_token=xyz');
      expect(rm.clientSecret, isNull);
      expect(rm.intentionOrderId, isNull);
      expect(rm.paymobTransactionId, '1234567');
      expect(rm.internalTransactionId, 99);
      expect(rm.paymobStatus, isNull);
    });
  });
}
