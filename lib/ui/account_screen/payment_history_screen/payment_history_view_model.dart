import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/util/enums/dialog_type.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../others/constants.dart';
import 'widget/filter_dialog_view.dart';

class PaymentHistoryViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final dialogService = locator<DialogService>();
  TextEditingController nameController = TextEditingController();
  TextEditingController formDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  var timeNow = DateFormat('hh:mm a').format(DateTime.now());
  // var dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
  var dateNow = DateFormat('dd MMM yyyy').format(DateTime.now());
  DateTime selectedDate = DateTime.now();

  PaymentHistoryViewModel() {
    formDateController.text = dateNow;
    toDateController.text = dateNow;
  }

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  void showFilterDialog(PaymentHistoryViewModel viewModel) {
    final builders = {
      DialogType.paymentFilter: (_, request, completer) =>
          FilterDialogView(viewModel: viewModel),
    };

    dialogService.registerCustomDialogBuilders(builders);

    dialogService.showCustomDialog(variant: DialogType.paymentFilter);
  }

  void pickFormDate(DateTime dateTime) {
    formDateController.text = DateFormat("dd MMM yyyy").format(dateTime);
    notifyListeners();
  }

  void pickToDate(DateTime dateTime) {
    toDateController.text = DateFormat("dd MMM yyyy").format(dateTime);
    notifyListeners();
  }
}
