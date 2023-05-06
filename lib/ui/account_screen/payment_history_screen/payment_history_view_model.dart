import 'package:square_demo_architecture/util/enums/dialog_type.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import 'widget/filter_dialog_view.dart';

class PaymentHistoryViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final dialogService = locator<DialogService>();

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  void showDialog() {
    final builders = {
      DialogType.paymentFilter: (_, request, completer) =>
          FilterDialogWidget(request: request, completer: completer),
    };

    dialogService.registerCustomDialogBuilders(builders);

    dialogService.showCustomDialog(variant: DialogType.paymentFilter);
  }
}
