import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:square_demo_architecture/util/others/text_styles.dart';
import '../../../../../util/others/image_constants.dart';
import '../employes_register_view_model.dart';

class PickBusinessImageWidget extends StatelessWidget {
  final EmployerRegisterViewModel viewModel;

  const PickBusinessImageWidget({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Visibility(
          visible: !viewModel.isListEmpty,
          child: Flexible(
            child: Container(
              alignment: Alignment.topLeft,
              height: SizeConfig.margin_padding_50 * 3,
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: viewModel.fourImagesAdded
                    ? viewModel.imageList!.length
                    : viewModel.imageList!.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == viewModel.imageList!.length) {
                    if (!viewModel.fourImagesAdded)
                      return _buildAddMorePicture(context, viewModel);
                  }
                  return _buildListOfImages(viewModel, index);
                },
              ),
            ),
          ),
        ),
        Visibility(
          visible: viewModel.isListEmpty,
          child: InkWell(
            onTap: () => viewModel.pickImage(context),
            child: DottedBorder(
              color: independenceColor,
              strokeWidth: 1,
              dashPattern: const [4, 2],
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              padding: const EdgeInsets.all(1.5),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: SizedBox(
                  height: SizeConfig.margin_padding_50 * 2,
                  width: SizeConfig.margin_padding_50 * 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: SizeConfig.margin_padding_24,
                        width: SizeConfig.margin_padding_24,
                        child: Image.asset(upload_image),
                      ),
                      SizedBox(height: SizeConfig.margin_padding_10),
                      Text(
                        "add_picture_of_your_business".tr(),
                        style: TSB.regularMedium(textColor: independenceColor),
                      ),
                      SizedBox(height: SizeConfig.margin_padding_5),
                      Text(
                        "upload_upto_image".tr(),
                        style: TSB.regularSmall(textColor: fieldsRegularColor),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddMorePicture(
      BuildContext context, EmployerRegisterViewModel viewModel) {
    return InkWell(
      onTap: () => viewModel.pickImage(context),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.margin_padding_15,
          ),
          color: mainPinkColor.withOpacity(0.04),
          height: SizeConfig.margin_padding_50 * 3,
          width: SizeConfig.margin_padding_50 * 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeConfig.margin_padding_24,
                width: SizeConfig.margin_padding_24,
                child: Image.asset(upload_image),
              ),
              SizedBox(height: SizeConfig.margin_padding_8),
              Text(
                textAlign: TextAlign.center,
                "add_more_picture".tr(),
                style: TSB.regularSmall(textColor: independenceColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListOfImages(EmployerRegisterViewModel viewModel, int index) {
    return Container(
      width: SizeConfig.margin_padding_50 * 2,
      margin: EdgeInsets.only(right: SizeConfig.margin_padding_8),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            // child: Image.asset(
            //   viewModel.imageList![index],
            //   fit: BoxFit.cover,
            // ),
            child: CachedNetworkImage(
              imageUrl: viewModel.imageList![index],
              alignment: Alignment.center,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fill,
              placeholder: (_, url) => Image.asset(upload_image),
            ),
          ),
          Positioned(
            top: 0.0,
            right: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () {
                  // viewModel.deleteImage(
                  //     viewModel.imageList![index], index);
                },
                child: Container(
                  width: SizeConfig.margin_padding_24,
                  height: SizeConfig.margin_padding_24,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(
                      SizeConfig.margin_padding_20,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset(ic_remove_wht),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
