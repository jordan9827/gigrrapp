import 'package:easy_localization/easy_localization.dart';
import 'package:pub_semver/pub_semver.dart';

enum PickedFileType {
  Document,
  Video,
  Image,
}

extension StringExtensions on String {
  String toDateFormat() =>
      DateFormat("dd MMM, yyyy").format(DateTime.parse(this));

  String toSentDateFormat() =>
      DateFormat("yyyy-MM-dd").format(DateTime.parse(this));

  double getNumber({int p = 2}) =>
      double.parse('$this'.substring(0, '$this'.indexOf('.')));

  String toPriceFormat([int p = 2]) {
    return "${double.parse(this).toStringAsFixed(p)}";
  }

  String capitalize() {
    if (this.isNotEmpty) {
      return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
    } else {
      return "";
    }
  }

  PickedFileType getFileType() {
    String fileType = split(".").last.toLowerCase();
    List<String> image = ["jpeg", "jpg", "png"];
    List<String> video = ["mp4", "3gp", "mov", "mkv"];
    if (image.contains(fileType)) {
      return PickedFileType.Image;
    } else if (video.contains(fileType)) {
      return PickedFileType.Video;
    }
    return PickedFileType.Document;
  }

  Version toVersion() {
    print("toVersion ${Version.parse(this)}");
    return Version.parse(this);
  }
}
