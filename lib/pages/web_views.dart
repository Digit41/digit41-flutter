// import 'package:digit41/widgets/inner_appbar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViews extends StatefulWidget {
//   String title;
//   String url;
//
//   WebViews({required this.url, required this.title});
//
//   @override
//   _WebViewsState createState() => _WebViewsState();
// }
//
// class _WebViewsState extends State<WebViews> {
//   bool visible = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: InnerAppbar(title: widget.title),
//       body: Stack(
//         children: [
//           WebView(
//             initialUrl: widget.url,
//             javascriptMode: JavascriptMode.unrestricted,
//             onPageFinished: (s) {
//               setState(() {
//                 visible = false;
//               });
//             },
//           ),
//           Center(
//             child: Visibility(
//               child: CupertinoActivityIndicator(),
//               visible: visible,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
