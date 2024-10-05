import 'package:key_value_storage/key_value_storage.dart';
import 'package:tymer_api/tymer_api.dart';

extension ReservationServiceTypeRMtoCM on ReservationServiceTypeRM {
  ReservationServiceTypeCM toCacheModel() {
    return ReservationServiceTypeCM(
      id: id,
      name: NameCM(
        ar: name.ar,
        en: name.en,
      ),
    );
  }
}

extension ReservationServiceTypesRMtoCM on ReservationServiceTypesRM {
  ReservationServiceTypesCM toCacheModel() {
    return ReservationServiceTypesCM(
      list: list.map((e) => e.toCacheModel()).toList(),
    );
  }
}
