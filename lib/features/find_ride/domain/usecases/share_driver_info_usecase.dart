import 'package:saffar_app/core/models/driver.dart';
import 'package:share_plus/share_plus.dart';

class ShareDriverInfoUsecase {
  /// Shares driver info in text format
  Future<void> call(Driver driver) async {
    return Share.share(
      'Driver info\n\nName: ${driver.name}\nPhone: ${driver.phone}\nVehicle name: ${driver.vehicleName}\nVehicle number: ${driver.vehicleNumber}',
    );
  }
}
