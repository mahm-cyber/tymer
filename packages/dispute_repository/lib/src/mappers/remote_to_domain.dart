import 'package:domain_models/domain_models.dart';
import 'package:service_repository/service_repository.dart';
import 'package:tymer_api/tymer_api.dart';

DisputeStatus disputeStatusRMtoDM(String status) {
  switch (status) {
    case 'pending-review':
      return DisputeStatus.pendingReview;
    case 'charged-back':
      return DisputeStatus.refunded;
    case 'denied':
      return DisputeStatus.denied;
    default:
      throw Exception('Unknown dispute status');
  }
}

extension DisputeRMtoDM on DisputeRM {
  Dispute toDomainModel() {
    return Dispute(
      id: id,
      serviceRequestId: serviceRequestId,
      resolverId: resolvedBy,
      status: disputeStatusRMtoDM(status),
      serviceRequest: serviceRequest?.toDomainModel(),
      reason: reason,
      createdAt: DateTime.parse(createdAt).toLocal(),
    );
  }
}

extension DisputeListPageRMtoDM on DisputeListPageRM {
  DisputeListPage toDomainModel() {
    return DisputeListPage(
      list: list.map((dispute) => dispute.toDomainModel()).toList(),
      isLastPage: isLastPage,
    );
  }
}

extension DisputeMessageRMtoDM on DisputeMessageRM {
  DisputeMessage toDomainModel(int disputeId) {
    const filesUrl = '${UrlBuilder.baseUrl}/files';
    try {
      final messageUri = chatImages.isNotEmpty
          ? '$filesUrl/${chatImages[0]}'
          : chatRecords.isNotEmpty
              ? '$filesUrl/${chatRecords[0]}'
              : chatDocuments.isNotEmpty
                  ? '$filesUrl/${chatDocuments[0]}'
                  : '';
      final messageFileName = chatImages.isNotEmpty
          ? chatImages[0].split('/').last
          : chatRecords.isNotEmpty
              ? chatRecords[0].split('/').last
              : chatDocuments.isNotEmpty
                  ? chatDocuments[0].split('/').last
                  : '';

      final dateDM = DateTime.parse(createdAt).toLocal();
      final chatMessage = DisputeMessage(
        id: id,
        text: content,
        files: [
          if (messageUri.isNotEmpty)
            FileDM(
              name: messageFileName,
              dlUrl: messageUri,
            ),
        ],
        date: dateDM,
        sender: Sender(
          id: senderId,
          name: senderName,
        ),
      );
      return chatMessage;
    } catch (e) {
      throw Exception('Error parsing DisputeMessageRM to MessageDM: $e');
    }
  }
}

extension DisputeChatRMtoDM on DisputeChatRM {
  DateGroupedMessagesList toDomainModel(int disputeId) {
    final messagesList =
        messages.map((message) => message.toDomainModel(disputeId)).toList();
    // group messageslist by date with two fields inside the map, the first is the date the second is the list of messages for that date
    final groupedMessagesListOfMaps = <Map<String, dynamic>>[];
    for (final message in messagesList) {
      final messageDate = message.date;
      final messageDateFormatted =
          '${messageDate.year}-${messageDate.month}-${messageDate.day}';
      final messageIndex = groupedMessagesListOfMaps
          .indexWhere((element) => element['date'] == messageDateFormatted);
      if (messageIndex == -1) {
        groupedMessagesListOfMaps.add({
          'date': messageDateFormatted,
          'messages': [message],
        });
      } else {
        groupedMessagesListOfMaps[messageIndex]['messages'].add(message);
      }
    }
    final List<DateGroupedMessages> groupedMessagesList = [];
    for (final groupedMessagesMap in groupedMessagesListOfMaps) {
      // convert  "2024-2-3" to "2024-02-03"
      final remoteDate = groupedMessagesMap['date'];
      final month = remoteDate.split('-')[1];
      final day = remoteDate.split('-')[2];
      //if month  or day is less than 10 add a 0 before it
      final formattedMonth = month.length == 1 ? '0$month' : month;
      final formattedDay = day.length == 1 ? '0$day' : day;
      final formattedDate =
          '${remoteDate.split('-')[0]}-$formattedMonth-$formattedDay';
      final date = DateTime.parse(formattedDate);
      final messages = groupedMessagesMap['messages'] as List<DisputeMessage>;
      groupedMessagesList.add(
        DateGroupedMessages(
          date: date,
          messages: messages,
        ),
      );
    }

    return DateGroupedMessagesList(
      list: groupedMessagesList,
    );
  }
}

