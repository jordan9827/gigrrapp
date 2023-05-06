import 'package:dartz/dartz.dart';
import 'package:square_demo_architecture/data/network/dtos/gigrr_type_response.dart';
import 'package:stacked/stacked.dart';
import '../../app/app.locator.dart';
import '../../data/network/dtos/business_type_category.dart';
import '../../util/exceptions/failures/failure.dart';
import '../repos/business_repos.dart';

class BusinessTypeService with ListenableServiceMixin {
  final _businessTypeList = <BusinessTypeCategoryList>[];
  final _gigrrTypeList = <GigrrTypeCategoryList>[];
  final businessRepo = locator<BusinessRepo>();

  List<BusinessTypeCategoryList> get businessTypeList => _businessTypeList;
  List<GigrrTypeCategoryList> get gigrrTypeList => _gigrrTypeList;

  void updateBusinessType(List<BusinessTypeCategoryList> businessType) {
    _businessTypeList.clear();
    _businessTypeList.addAll(businessType);
    notifyListeners();
  }

  void updateGigrrName(List<GigrrTypeCategoryList> gigrrType) {
    _gigrrTypeList.clear();
    _gigrrTypeList.addAll(gigrrType);
    notifyListeners();
  }
}
