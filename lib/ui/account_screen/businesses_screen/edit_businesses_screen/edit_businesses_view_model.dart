import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/app.locator.dart';
import '../../../../data/network/dtos/get_businesses_response.dart';
import '../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../others/constants.dart';
import '../../../widgets/image_picker_util.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart'
    as auto;

class EditBusinessesViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final user = locator<UserAuthResponseData>();

  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessTypeController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController =
      TextEditingController(text: "House no., Street name, Area");
  LatLng latLng = const LatLng(14.508, 46.048);
  double latitude = 0.0;
  double longitude = 0.0;
  List<String>? imageList = [];

  EditBusinessesViewModel(GetBusinessesList data) {}

  void initialDataLoad(GetBusinessesList e) {
    businessNameController.text = e.businessName;
    addressController.text = e.businessAddress;
    for (var i in e.businessesImage) imageList!.add(i.imageUrl);
  }

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  void mapBoxPlace() {
    navigationService.navigateWithTransition(
      auto.MapBoxAutoCompleteWidget(
        apiKey: MAPBOX_TOKEN,
        hint: "Select Location",
        language: "en",
        onSelect: (place) async {
          var addressData = place.context!;
          setBusy(true);
          addressController.text = place.placeName ?? "";
          latLng = LatLng(
              place.geometry!.coordinates![1], place.geometry!.coordinates![0]);
          setBusy(false);

          notifyListeners();
        },
        limit: 7,
      ),
    );
  }
}
