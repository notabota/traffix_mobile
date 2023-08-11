import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:traffix/models/planets.dart';
import 'package:traffix/pages/widgets/cameras_summary.dart';
import 'package:traffix/pages/widgets/separator.dart';
import 'package:traffix/ui/text_style.dart';
import 'package:traffix/pages/cameras/traffic_info.dart';
import 'package:page_transition/page_transition.dart';

class CamerasDetails extends StatefulWidget {
  CamerasDetails({Key? key, required this.planet}) : super(key: key);
  final Planet planet;
  late InAppWebViewController? webViewController;

  @override
  CamerasDetailsState createState() => CamerasDetailsState();
}

class CamerasDetailsState extends State<CamerasDetails> {
  late InAppWebViewController _webViewController;
  String? url = "";
  double progress = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        color: const Color(0xFF736AB7),
        child: Stack(
          children: <Widget>[
            _getBackground(),
            _getGradient(),
            _getContent(),
            _getToolbar(context),
            _getVideo()
          ],
        ),
      ),
    );
  }

  Container _getBackground() {
    return Container(
      constraints: const BoxConstraints.expand(height: 295.0),
      child: Image.network(
        widget.planet.picture,
        fit: BoxFit.cover,
        height: 300.0,
      ),
    );
  }

  Container _getGradient() {
    return Container(
      margin: const EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Color(0x00736AB7), Color(0xFF736AB7)],
          stops: [0.0, 0.9],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  ListView _getContent() {
    final overviewTitle = "Overview".toUpperCase();
    return ListView(
      padding: const EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
      children: <Widget>[
        CamerasSummary(
          planet: widget.planet,
          horizontal: false,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                overviewTitle,
                style: Style.headerTextStyle,
              ),
              const Separator(),
              Text(widget.planet.description, style: Style.commonTextStyle),
            ],
          ),
        ),
      ],
    );
  }

  Container _getToolbar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: const BackButton(color: Colors.white),
    );
  }

  Container _getVideo() {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: Column(children: <Widget>[
        Container(
            padding: const EdgeInsets.all(10.0),
            child: progress < 1.0
                ? LinearProgressIndicator(value: progress)
                : Container()),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 440.0, left: 10.0, right: 10.0),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.blueAccent)),
            child: InAppWebView(
              initialUrlRequest:
                  URLRequest(url: Uri.parse("https://ac41-58-187-187-177.ngrok.io")),
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    useShouldOverrideUrlLoading: true,
                    mediaPlaybackRequiresUserGesture: false,
                  ),
                  android: AndroidInAppWebViewOptions(
                    useHybridComposition: true,
                  ),
                  ios: IOSInAppWebViewOptions(
                    allowsInlineMediaPlayback: true,
                  )),
              onWebViewCreated: (InAppWebViewController controller) {
                _webViewController = controller;
              },
              onLoadStart: (InAppWebViewController controller, Uri? uri) {
                setState(() {
                  url = uri?.path;
                });
              },
              onLoadStop: (InAppWebViewController controller, Uri? uri) {
                setState(() {
                  url = uri?.path;
                });
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Icon(Icons.arrow_back),
              onPressed: () {
                _webViewController.goBack();
              },
            ),
            ElevatedButton(
              child: const Icon(Icons.arrow_forward),
              onPressed: () {
                _webViewController.goForward();
              },
            ),
            ElevatedButton(
              child: const Icon(Icons.refresh),
              onPressed: () {
                _webViewController.reload();
              },
            ),
            ElevatedButton(
              child: const Icon(Icons.info),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: const TrafficInfo(),
                  ),
                );
              },
            ),
          ],
        ),
      ]),
    );
  }
}
