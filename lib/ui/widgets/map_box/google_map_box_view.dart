import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import '../../../others/constants.dart';
import '../../../util/others/size_config.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GoogleMapBoxScreen extends StatefulWidget {
  final double lat;
  final double lng;
  final String zoom;
  final String size;
  final bool loading;
  const GoogleMapBoxScreen({
    Key? key,
    required this.lat,
    required this.lng,
    this.zoom = "13",
    this.loading = false,
    this.size = "400x200",
  }) : super(key: key);

  @override
  State<GoogleMapBoxScreen> createState() => _GoogleMapBoxScreenState();
}

class _GoogleMapBoxScreenState extends State<GoogleMapBoxScreen> {
  WebViewController? _controller;

  String baseUrl = "https://api.mapbox.com/styles/v1/mapbox/streets-v12/static";
  String marker =
      "https%3A%2F%2Fdocs.mapbox.com%2Fapi%2Fimg%2Fcustom-marker.png";
  @override
  void initState() {
    print("Google map ");
    String latLng = "${widget.lng},${widget.lat}";
    String url =
        "$baseUrl/url-$marker($latLng)/$latLng,${widget.zoom}/${widget.size}?access_token=$MAPBOX_TOKEN";
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(url));
    print("MapBox----------------------------------------->\n$url");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      height: SizeConfig.margin_padding_50 * 2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          SizeConfig.margin_padding_20,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          SizeConfig.margin_padding_20,
        ),
        child: WebViewWidget(controller: _controller!),
      ),
    );
  }
}

class MapBoxShimmerWidget extends StatelessWidget {
  const MapBoxShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Shimmer.fromColors(
      baseColor: textRegularColor.withOpacity(0.2),
      highlightColor: textRegularColor.withOpacity(0.4),
      child: Container(
        height: SizeConfig.margin_padding_50 * 2.5,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: independenceColor,
          borderRadius: BorderRadius.circular(
            SizeConfig.margin_padding_20,
          ),
        ),
      ),
    );
  }
}
