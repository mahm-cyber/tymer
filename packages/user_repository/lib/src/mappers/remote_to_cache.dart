import 'package:tymer_api/tymer_api.dart';
import 'package:key_value_storage/key_value_storage.dart';

extension UserRMtoCM on UserRM {
  UserCM toCacheModel() {
    return UserCM(
      id: id,
      name: name ?? 'nameRM',
      email: email,
      phone: phone,

    );
  }
}

