import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class WalletSecureStorage {
  static const _pendingTransactionsKey = 'pending-paymob-transactions';

  const WalletSecureStorage({
    FlutterSecureStorage? secureStorage,
  }) : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _secureStorage;

  Future<List<Map<String, dynamic>>> getPendingTransactions() async {
    try {
      final jsonString = await _secureStorage.read(key: _pendingTransactionsKey);
      if (jsonString == null) return [];
      final list = jsonDecode(jsonString) as List<dynamic>;
      return list.map((item) => Map<String, dynamic>.from(item as Map)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> savePendingTransactions(List<Map<String, dynamic>> transactions) async {
    try {
      final jsonString = jsonEncode(transactions);
      await _secureStorage.write(key: _pendingTransactionsKey, value: jsonString);
    } catch (_) {}
  }

  Future<void> addPendingTransaction(String transactionId) async {
    final list = await getPendingTransactions();
    // Prevent duplicate entries
    if (list.any((item) => item['id'] == transactionId)) return;
    list.add({
      'id': transactionId,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });
    await savePendingTransactions(list);
  }

  Future<void> removePendingTransaction(String transactionId) async {
    final list = await getPendingTransactions();
    list.removeWhere((item) => item['id'] == transactionId);
    await savePendingTransactions(list);
  }
}
