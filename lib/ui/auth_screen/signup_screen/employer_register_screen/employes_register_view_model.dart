import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapbox_search/mapbox_search.dart' as search;
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:square_demo_architecture/data/network/dtos/business_type_category.dart';
import 'package:square_demo_architecture/domain/repos/business_repos.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/util/others/image_constants.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart'
    as auto;
import '../../../../app/app.locator.dart';
import '../../../../app/app.router.dart';
import '../../../../data/local/preference_keys.dart';
import '../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../domain/repos/auth_repos.dart';
import '../../../widgets/image_picker_util.dart';

class EmployerRegisterViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final authRepo = locator<Auth>();
  final businessRepo = locator<Business>();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  LatLng latLng = const LatLng(14.508, 46.048);
  double latitude = 0.0;
  double longitude = 0.0;
  List<BusinessTypeCategoryList> businessTypeList = [];
  String address = "";
  BusinessTypeCategoryList? selectedBusinessType;
  final Set<Marker> markers = {};
  XFile? _imageFile;

  XFile? get imageFile => _imageFile;
  List<String>? serverImageList = [];

  List<String>? imageList = [];
  bool isListEmpty = true;
  bool fourImagesAdded = false;

  EmployerRegisterViewModel() {
    acquireCurrentLocation();
  }

  Future<void> markersLoadData() async {
    markers.add(Marker(
      markerId: MarkerId(""),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(latitude, longitude),
    ));

    notifyListeners();
  }

  void navigatorToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  void updateEmptyItem(val) {
    isListEmpty = val;
    notifyListeners();
  }

  void navigationToBusinessFormView() {
    navigationService.navigateTo(Routes.employBusinessInfoFormView);
  }

  void acquireCurrentLocation() async {
    setBusy(true);
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    final locationData = await location.getLocation();
    var geoCodingService = search.ReverseGeoCoding(
      apiKey: MAPBOX_TOKEN,
    );

    var getAddress = await geoCodingService.getAddress(search.Location(
      lat: locationData.latitude ?? 0.0,
      lng: locationData.longitude ?? 0.0,
    ));
    search.MapBoxPlace addressData = getAddress!.first;

    await setAddressPlace(addressData);
    latLng =
        LatLng(locationData.latitude ?? 0.0, locationData.longitude ?? 0.0);
    setBusy(false);
    notifyListeners();
  }

  Future<void> setAddressPlace(search.MapBoxPlace mapBoxPlace) async {
    print("$mapBoxPlace");
    setBusy(true);
    var addressData = mapBoxPlace.context ?? [];

    addressController.text = mapBoxPlace.placeName ?? "";
    cityController.text = addressData[2].text ?? "";
    stateController.text = addressData[4].text ?? "";
    pinCodeController.text = addressData[0].text ?? "";
    notifyListeners();
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
          cityController.text = addressData[2].text ?? "";
          stateController.text = addressData[4].text ?? "";
          pinCodeController.text = addressData[0].text ?? "";
          latLng = LatLng(
              place.geometry!.coordinates![1], place.geometry!.coordinates![0]);
          setBusy(false);

          notifyListeners();
        },
        limit: 7,
      ),
    );
  }

  Future<void> businessTypeCategoryApiCall() async {
    setBusy(true);
    final response = await authRepo.businessTypeCategory();
    response.fold(
      (fail) {
        snackBarService.showSnackbar(message: fail.errorMsg);
        setBusy(false);
      },
      (businessTypeResponse) {
        selectedBusinessType = businessTypeResponse.first;
        businessTypeList = businessTypeResponse;
        notifyListeners();
        setBusy(false);
      },
    );
    notifyListeners();
  }

  Future pickImage(BuildContext context) async {
    if (imageList!.length < 3) {
      fourImagesAdded = false;
    } else {
      fourImagesAdded = true;
    }
    XFile pickImage = await _showImagePicker(context);
    final imageFile = await cropImage(PickedFile(pickImage.path));
    if (imageFile != null) {
      _imageFile = XFile(imageFile.path);
      await uploadMediaForBusiness(imageFile.path);
      setBusy(false);
      notifyListeners();
    }
  }

  Future<XFile> _showImagePicker(context) async {
    return await ImagePickerUtil.showCameraOrGalleryChooser(context);
  }

  Future<CroppedFile?> cropImage(PickedFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      uiSettings: [
        AndroidUiSettings(
          toolbarColor: mainWhiteColor,
        ),
      ],
      aspectRatio: const CropAspectRatio(
        ratioX: 1.0,
        ratioY: 1.0,
      ),
      sourcePath: imageFile.path,
      maxWidth: 512,
      maxHeight: 512,
    );
    return croppedFile;
  }

  Future<void> uploadMediaForBusiness(String image) async {
    setBusy(true);
    final response = await authRepo.uploadImages(image);

    response.fold((failure) {
      setBusy(false);
    }, (response) {
      imageList!.add(response.imageList.first);
      updateEmptyItem(false);
      notifyListeners();
    });
  }

  bool validationAddBusinessProfile() {
    if (businessNameController.text.isEmpty) {
      snackBarService.showSnackbar(
        message: "msg_enter_businessName".tr(),
      );
      return false;
    } else if (imageList!.isEmpty) {
      snackBarService.showSnackbar(
        message: "msg_upload_image".tr(),
      );
      return false;
    }
    return true;
  }

  Future<void> addBusinessProfileApiCall() async {
    if (validationAddBusinessProfile()) {
      setBusy(true);
      final response = await businessRepo
          .addBusinessProfile(await _getRequestForAddBusiness());
      response.fold(
        (fail) {
          snackBarService.showSnackbar(message: fail.errorMsg);
          setBusy(false);
        },
        (businessTypeResponse) {
          // snackBarService.showSnackbar(message: "sucess");

          notifyListeners();
          setBusy(false);
        },
      );
      notifyListeners();
    }
  }

  Future<void> employerCompleteProfileApiCall() async {
    if (validationAddBusinessProfile()) {
      setBusy(true);
      final response = await authRepo.employerCompleteProfile(
          await _getRequestForEmployerCompleteProfile());
      response.fold(
        (fail) {
          snackBarService.showSnackbar(message: fail.errorMsg);
          setBusy(false);
        },
        (businessTypeResponse) => successBody(businessTypeResponse),
      );
      notifyListeners();
    }
  }

  Future<void> successBody(UserAuthResponseData res) async {
    navigationToSignup(res);
    setBusy(false);
  }

  void navigationToSignup(UserAuthResponseData res) {
    if (res.status.toLowerCase() == "incompleted") {
      if (res.roleId == "3") {
        navigationService.clearStackAndShow(Routes.employPersonalInfoFormView);
      } else {}
    } else
      navigationService.clearStackAndShow(Routes.homeScreenView);
    setBusy(false);
  }

  Future<Map<String, String>> _getRequestForAddBusiness() async {
    Map<String, String> request = {};
    request['business_type'] = selectedBusinessType!.id.toString();
    request['business_name'] = businessNameController.text;
    request['business_address'] = addressController.text;
    request['business_latitude'] = latLng.latitude.toString();
    request['business_longitude'] = latLng.longitude.toString();
    request['images'] = imageList!.join(', ');
    log("Body Add Business :: $request");
    return request;
  }

  Future<Map<String, String>> _getRequestForEmployerCompleteProfile() async {
    Map<String, String> request = {};
    request['full_name'] = fullNameController.text;
    request['country_code'] = "+91";
    request['mobile_no'] = mobileController.text;
    request['address'] = addressController.text;
    request['latitude'] = latLng.latitude.toString();
    request['longitude'] = latLng.longitude.toString();
    log("Body Complete Profile >>> $request");
    return request;
  }
}
