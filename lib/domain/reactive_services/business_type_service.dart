import 'package:square_demo_architecture/data/network/dtos/gigrr_type_response.dart';
import 'package:stacked/stacked.dart';
import '../../app/app.locator.dart';
import '../../data/network/dtos/business_type_category.dart';
import '../repos/business_repos.dart';

class BusinessTypeService with ListenableServiceMixin {
  final _businessTypeList = <BusinessTypeCategoryList>[];
  final _gigrrTypeList = <GigrrTypeCategoryData>[];
  final businessRepo = locator<BusinessRepo>();

  List<BusinessTypeCategoryList> get businessTypeList => _businessTypeList;
  List<GigrrTypeCategoryData> get gigrrTypeList => _gigrrTypeList;

  void updateBusinessType(List<BusinessTypeCategoryList> businessType) {
    _businessTypeList.clear();
    _businessTypeList.addAll(businessType);
    notifyListeners();
  }

  void updateGigrrName(List<GigrrTypeCategoryData> gigrrType) {
    _gigrrTypeList.clear();
    _gigrrTypeList.addAll(gigrrType);
    notifyListeners();
  }
}
