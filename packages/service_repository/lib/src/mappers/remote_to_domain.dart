import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:tymer_api/tymer_api.dart';

extension ServiceRMtoDM on ServiceRM {
  ServiceType serviceTypeRMtoDM(String serviceType) {
    switch (serviceType) {
      case 'other_service':
        return ServiceType.other;
      case 'reservation_service':
        return ServiceType.reservation;
      default:
        throw Exception('Unknown service type');
    }
  }

  Service toDomainModel() {
    try {
      ServiceStatus serviceStatusRMtoDM(String status) {
        switch (status) {
          case 'pending':
            return ServiceStatus.pending;
          case 'in-progress':
            return ServiceStatus.inProgress;
          case 'completed':
            return ServiceStatus.completed;
          case 'canceled':
            return ServiceStatus.canceled;
          case 'pending-review':
            return ServiceStatus.pendingReview;
          case 'disputed':
            return ServiceStatus.disputed;
          default:
            throw Exception('Unknown service status');
        }
      }

      final isOtherService = serviceTypeRMtoDM(type) == ServiceType.other;

      ServiceResponse? serviceResponse;
      if (isOtherService) {
        serviceResponse = response != null
            ? (response as OtherServiceRM).toDomainModel()
            : null;
      } else {
        serviceResponse = response != null
            ? (response as ReservationServiceRM).toDomainModel()
            : null;
      }
      return Service(
        id: id,
        distanceBetweenProviderAndServiceLocation: double.tryParse(
          distanceBetweenProviderAndServiceLocation ?? '',
        ),
        status: serviceStatusRMtoDM(status),
        createdAt: DateTime.parse(createdAt),
        type: serviceTypeRMtoDM(type),
        totalPrice: double.parse(totalPrice),
        price: double.parse(servicePrice),
        fee: double.parse(servicefee),
        location: location.toDomainModel(),
        details: details?.toDomainModel(),
        response: serviceResponse,
      );
    } catch (e) {
      throw Exception('Error parsing ServiceRM to ServiceDM: $e');
    }
  }
}

extension ServiceListPageRMtoDM on ServiceListPageRM {
  ServiceListPage toDomainModel() {
    return ServiceListPage(
      list: list.map((service) => service.toDomainModel()).toList(),
      isLastPage: isLastPage,
    );
  }
}

extension OtherServiceResponseRMtoDM on OtherServiceRM {
  ServiceResponse toDomainModel() {
    return ServiceResponse(
      date: date != null ? DateTime.parse(date!) : null,
      time: time != null ? stringToTimeOfDay(time!) : null,
      additionalNotes: additionalNotes,
      imageUrl: image == null ? null : '${UrlBuilder.baseUrl}/files/${image!}',
    );
  }
}

extension ReservationServiceResponseRMtoDM on ReservationServiceRM {
  ServiceResponse toDomainModel() {
    return ServiceResponse(
      reservationNumber: code,
      time: stringToTimeOfDay(time),
      date: DateTime.parse(date),
      additionalNotes: additionalNotes,
      imageUrl: image == null ? null : '${UrlBuilder.baseUrl}/files/${image!}',
    );
  }
}

extension LocationRMtoDM on LocationRM {
  LocationDM toDomainModel() {
    return LocationDM(
      type: type,
      coordinates: coordinates,
    );
  }
}

extension ServiceDetailsRMtoDM on ServiceDetailsRM {
  ServiceDetails toDomainModel() {
    return ServiceDetails(
      placeName: placeName,
      placeAddress: placeAddress,
      date: date != null ? DateTime.parse(date!) : null,
      reservedFor: reservedFor,
      reservationDate:
          reservationDate != null ? DateTime.parse(reservationDate!) : null,
      reservationTime:
          reservationTime != null ? stringToTimeOfDay(reservationTime!) : null,
      time: time != null ? stringToTimeOfDay(time!) : null,
      reservationServiceCategory: reservationServiceCategory?.toDomainModel(),
      additionalComments: additionalDetails,
    );
  }
}

extension ReservationServiceTypeRMtoDM on ReservationServiceTypeRM {
  ReservationServiceType toDomainModel() {
    return ReservationServiceType(
      id: id,
      name: Name(
        en: name.en,
        ar: name.ar,
      ),
    );
  }
}

extension DisputeRMtoDM on DisputeRM {
  DisputeStatus disputeStatusRMtoDM(String status) {
    switch (status) {
      case 'pending-review':
        return DisputeStatus.pendingReview;
      case 'charged-back':
        return DisputeStatus.chargedBack;
      case 'denied':
        return DisputeStatus.denied;
      default:
        throw Exception('Unknown dispute status');
    }
  }

  Dispute toDomainModel() {
    return Dispute(
      id: id,
      serviceRequestId: serviceRequestId,
      resolverId: resolvedBy,
      status: disputeStatusRMtoDM(status),
      serviceRequest: serviceRequest.toDomainModel(),
      reason: reason,
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

      final dateDM = DateTime.parse(createdAt);
      final chatMessage = DisputeMessage(
        id: id,
        text: content,
        files: [
          if(messageUri.isNotEmpty)
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
      final formattedDate = '${remoteDate.split('-')[0]}-$formattedMonth-$formattedDay';
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

TimeOfDay stringToTimeOfDay(String timeString) {
  final parts = timeString.split(':');
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);
  return TimeOfDay(hour: hour, minute: minute);
}
