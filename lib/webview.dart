// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewView extends StatefulWidget {
//   const WebViewView({super.key});
//
//   @override
//   State<WebViewView> createState() => _WebViewViewState();
// }
//
// class _WebViewViewState extends State<WebViewView> {
//   final WebViewController controller = WebViewController();
//
//   @override
//   void initState() {
//     super.initState();
//     controller
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadRequest(
//         Uri.parse('https://fluttergems.dev/'),
//       );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WebViewWidget(
//       controller: controller,
//       gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
//         Factory<VerticalDragGestureRecognizer>(
//             () => VerticalDragGestureRecognizer()),
//       },
//     );
//   }
// }
