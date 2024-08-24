//
//
import 'package:domain_models/domain_models.dart';
import 'package:key_value_storage/key_value_storage.dart';


extension LocalePreferenceDomainToCM on LocalePreferenceDM {
  LocalePreferenceCM toCacheModel() {
    switch (this) {
      case LocalePreferenceDM.english:
        return LocalePreferenceCM.english;
      case LocalePreferenceDM.arabic:
        return LocalePreferenceCM.arabic;
    }
  }
}
//
//
//
// extension TaskDMtoCM on Task {
//   TaskTypeCM taskTypeDMtoCM(TaskType taskType) {
//     switch (taskType) {
//       case TaskType.call:
//         return TaskTypeCM.call;
//       case TaskType.email:
//         return TaskTypeCM.email;
//       case TaskType.meeting:
//         return TaskTypeCM.meeting;
//       case TaskType.general:
//         return TaskTypeCM.general;
//       default:
//         return TaskTypeCM.general;
//     }
//   }
//
//   TaskCM toCacheModel() {
//     try {
//       return TaskCM(
//         id: id,
//         ownerId: ownerId,
//         name: name ?? 'nameCM',
//         assigneeId: assigneeId,
//         assigneeName: assigneeName,
//         collaborators:
//         collaborators?.map((user) => user.toCacheModel()).toList(),
//         startDate: startDate,
//         type: type == null ? null : taskTypeDMtoCM(type!),
//         dueDate: dueDate,
//         priority: priority,
//         description: description,
//         historyLog:
//         historyLog.map((history) => history.toCacheModel()).toList(),
//         activities:
//         activities.map((activity) => activity.toCacheModel()).toList(),
//         associatedContacts: associatedContacts
//             .map((contact) => contact.toCacheModel())
//             .toList(),
//         associatedCompanies: associatedCompanies
//             .map((company) => company.toCacheModel())
//             .toList(),
//         associatedDeals:
//         associatedDeals.map((deal) => deal.toCacheModel()).toList(),
//       );
//     } catch (error) {
//       rethrow;
//     }
//   }
// }
//
// extension UserDMtoCM on User {
//   UserCM toCacheModel() {
//     try {
//       return UserCM(
//         id: id,
//         name: name ?? 'nameCM',
//         email: email,
//         phone: phone,
//         companyName: companyName,
//         companyAddress: companyAddress,
//         companyCountry: companyCountry,
//         accountName: accountName,
//         companyDomain: companyDomain,
//         jobTitle: jobTitle,
//       );
//     } catch (error) {
//       rethrow;
//     }
//   }
// }
//
// extension HistoryDMtoCM on History {
//   HistoryTypeCM historyTypeDMtoCM(HistoryType historyType) {
//     switch (historyType) {
//       case HistoryType.note:
//         return HistoryTypeCM.note;
//       case HistoryType.call:
//         return HistoryTypeCM.call;
//       case HistoryType.email:
//         return HistoryTypeCM.email;
//       case HistoryType.meeting:
//         return HistoryTypeCM.meeting;
//       case HistoryType.text:
//         return HistoryTypeCM.text;
//     }
//   }
//
//   HistoryCM toCacheModel() {
//     try {
//       return HistoryCM(
//         type: historyTypeDMtoCM(type),
//         title: title,
//       );
//     } catch (error) {
//       rethrow;
//     }
//   }
// }
//
// extension ActivityDMtoCM on Activity {
//   LogTypeCM logTypeDMtoCM(LogType logType) {
//     switch (logType) {
//       case LogType.call:
//         return LogTypeCM.call;
//       case LogType.email:
//         return LogTypeCM.email;
//       case LogType.meeting:
//         return LogTypeCM.meeting;
//       case LogType.text:
//         return LogTypeCM.text;
//     }
//   }
//
//   ActivityTypeCM activityTypeDMtoCM(ActivityType activityType) {
//     switch (activityType) {
//       case ActivityType.activity:
//         return ActivityTypeCM.activity;
//       case ActivityType.note:
//         return ActivityTypeCM.note;
//       case ActivityType.task:
//         return ActivityTypeCM.task;
//     }
//   }
//
//   ActivityCM toCacheModel() {
//     try {
//       return ActivityCM(
//         id: id,
//         name: name ?? 'nameCM',
//         author: author,
//         comments: comments.map((comment) => comment.toCacheModel()).toList(),
//         logDescription: logDescription,
//         logType: logType == null ? null : logTypeDMtoCM(logType!),
//         note: note,
//         task: task,
//         taskDescription: taskDescription,
//         type: type == null ? null : activityTypeDMtoCM(type!),
//       );
//     } catch (error) {
//       rethrow;
//     }
//   }
// }
//
// extension CommentDMtoCM on Comment {
//   CommentCM toCacheModel() {
//     try {
//       return CommentCM(
//         author: author,
//         content: content,
//       );
//     } catch (error) {
//       rethrow;
//     }
//   }
// }
//
// extension MkFieldDMtoCM on MkField {
//   MkFieldCM toCacheModel() {
//     try {
//       return MkFieldCM(
//         id: id,
//         name: name,
//         value: value,
//         values: values,
//       );
//     } catch (error) {
//       rethrow;
//     }
//   }
// }
//
// extension ContactDMtoCM on Contact {
//   ContactCM toCacheModel() {
//     try {
//       return ContactCM(
//         id: id,
//         name: name ?? 'nameCM',
//         email: email,
//         phone: phone,
//         owner: owner,
//         ownerId: ownerId,
//         jobTitle: jobTitle,
//         dateCreated: dateCreated,
//         isSelected: isSelected,
//         lifeCycle: lifeCycle,
//         historyLog:
//         historyLog.map((history) => history.toCacheModel()).toList(),
//         activities:
//         activities.map((activity) => activity.toCacheModel()).toList(),
//         description: description,
//         priority: priority,
//         status: status,
//         followers: followers.map((user) => user.toCacheModel()).toList(),
//         mkFields: mkFields.map((mkField) => mkField.toCacheModel()).toList(),
//         associatedCompanies: associatedCompanies
//             .map((company) => company.toCacheModel())
//             .toList(),
//         associatedDeals:
//         associatedDeals.map((deal) => deal.toCacheModel()).toList(),
//         associatedTasks:
//         associatedTasks.map((task) => task.toCacheModel()).toList(),
//       );
//     } catch (error) {
//       rethrow;
//     }
//   }
// }
//
// extension DealDMtoCM on Deal {
//   DealCM toCacheModel() {
//     try {
//       return DealCM(
//         id: id,
//         name: name ?? 'nameCM',
//         stage: stage?.toCacheModel(),
//         company: company?.toCacheModel(),
//         contactName: contactName,
//         lifeCycle: lifeCycle,
//         followers: followers?.map((user) => user.toCacheModel()).toList(),
//         cr: cr,
//         vat: vat,
//         value: value,
//         startDate: startDate,
//         endDate: endDate,
//         isSelected: isSelected,
//         owner: owner?.toCacheModel(),
//         brief: brief,
//         historyLog:
//         historyLog.map((history) => history.toCacheModel()).toList(),
//         activities:
//         activities.map((activity) => activity.toCacheModel()).toList(),
//         associatedTasks:
//         associatedTasks.map((task) => task.toCacheModel()).toList(),
//         associatedContacts: associatedContacts
//             .map((contact) => contact.toCacheModel())
//             .toList(),
//         associatedCompanies: associatedCompanies
//             .map((company) => company.toCacheModel())
//             .toList(),
//       );
//     } catch (error) {
//       rethrow;
//     }
//   }
// }
//
// extension CompanyDMtoCM on Company {
//   CompanyCM toCacheModel() {
//     try {
//       return CompanyCM(
//         id: id,
//         name: name ?? 'nameCM',
//         website: website,
//         phone: phone,
//         owner: owner,
//         ownerName: ownerName,
//         email: email,
//         lifeCycle: lifeCycle,
//         lifeCycleFromGetSingleCompany: lifeCycleFromGetSingleCompany,
//         priority: priority,
//         facebook: facebook,
//         twitter: twitter,
//         instagram: instagram,
//         tiktok: tiktok,
//         snapchat: snapchat,
//         linkedin: linkedin,
//         followers: followers.map((user) => user.toCacheModel()).toList(),
//         dateCreated: dateCreated,
//         isSelected: isSelected,
//         brief: brief,
//         mkFields: mkFields.map((mkField) => mkField.toCacheModel()).toList(),
//         historyLog:
//         historyLog.map((history) => history.toCacheModel()).toList(),
//         activities:
//         activities.map((activity) => activity.toCacheModel()).toList(),
//         associatedContacts: associatedContacts
//             .map((contact) => contact.toCacheModel())
//             .toList(),
//         associatedTasks:
//         associatedTasks.map((task) => task.toCacheModel()).toList(),
//         associatedDeals:
//         associatedDeals.map((deal) => deal.toCacheModel()).toList(),
//       );
//     } catch (error) {
//       rethrow;
//     }
//   }
// }
//
// extension DealStageDMtoCM on DealStage {
//   String colorToHex(Color color) {
//     return '#${color.value.toRadixString(16).substring(2)}';
//   }
//
//   DealStageCM toCacheModel() {
//     try {
//       return DealStageCM(
//         id: id,
//         name: name ?? 'nameCM',
//         color: colorToHex(color!),
//       );
//     } catch (error) {
//       rethrow;
//     }
//   }
// }
