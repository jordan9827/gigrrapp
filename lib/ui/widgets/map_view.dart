import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import '../../../others/constants.dart';
import '../../../util/others/size_config.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GoogleMapViewScreen extends StatefulWidget {
  final double lat;
  final double lng;
  final String zoom;
  final String size;
  final bool loading;
  const GoogleMapViewScreen({
    Key? key,
    required this.lat,
    required this.lng,
    this.zoom = "13",
    this.loading = false,
    this.size = "1280x1280",
  }) : super(key: key);

  @override
  State<GoogleMapViewScreen> createState() => _GoogleMapViewScreenState();
}

class _GoogleMapViewScreenState extends State<GoogleMapViewScreen> {
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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: WebViewWidget(controller: _controller!),
    );
  }
}
