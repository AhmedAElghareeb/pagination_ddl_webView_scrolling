// import 'dart:convert';
// import 'dart:developer';

// import 'package:first/const.dart';
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:first/firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:first/local_notification.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';

// import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:first/webview.dart';
// import 'dart:convert';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await getFcmToken();
  runApp(const MyApp());
}

Future<String> getFcmToken() async {
  String deviceToken = (await FirebaseMessaging.instance.getToken())!;
  print('firebase token => $deviceToken  <<<<<<<<<');
  return deviceToken;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      home: const Notification(),
    );
  }
}

class Notification extends StatefulWidget {
  const Notification({super.key});

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  DateTime? selectedDate;

  // DateTime dateNow = DateTime.now();
  // Timer? notificationTimer;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // _startNotificationTimer();
      });
    }
  }

  // void _startNotificationTimer() {
  //   notificationTimer?.cancel();
  //   notificationTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
  //     if (selectedDate != null) {
  //       if (dateNow.year == selectedDate!.year &&
  //           dateNow.month == selectedDate!.month &&
  //           dateNow.day == selectedDate!.day &&
  //           dateNow.hour == 0 &&
  //           dateNow.minute == 0 &&
  //           dateNow.second == 0) {
  //         _showNotification();
  //         timer.cancel();
  //       }
  //     }
  //   });
  // }
  //
  // void _showNotification() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text("Reminder"),
  //         content: const Text("It's time for your scheduled notification!"),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: const Text("Dismiss"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  //
  // @override
  // void dispose() {
  //   notificationTimer?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            selectedDate != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xff088087),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "${selectedDate?.day} - ${selectedDate?.month} - ${selectedDate?.year}",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () => setState(() {
                          selectedDate = null;
                        }),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.red,
                          ),
                          child: const Icon(Icons.clear,
                              size: 25, color: Colors.white),
                        ),
                      ),
                    ],
                  )
                : FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: const Color(0xff003087),
                    ),
                    onPressed: () async {
                      await _selectDate(context);
                    },
                    child: const Text("Pick Date"),
                  ),
            const SizedBox(height: 20),
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: const Color(0xff003256),
              ),
              onPressed: () async {
                final DateTime dateTime =
                    DateTime.now().add(const Duration(seconds: 10));
                await NotificationService().makeNotify(
                  0,
                  selectedDate ?? dateTime,
                );
                print('Time : $dateTime');
              },
              child: const Text("Push Notification"),
            ),
          ],
        ),
      ),
    );
  }
}

/// Api Request
// class HomeView extends StatefulWidget {
//   const HomeView({super.key});
//
//   @override
//   State<HomeView> createState() => _HomeViewState();
// }
//
// class _HomeViewState extends State<HomeView> {
//   late Future<Album> futureAlbum;
//
//   Future<Album> fetchAlbum() async {
//     final response = await http
//         .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
//     if (response.statusCode == 200) {
//       return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
//     } else {
//       throw Exception('Failed to load album');
//     }
//   }
//
//   @override
//   void initState() {
//     futureAlbum = fetchAlbum();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.5,
//         backgroundColor: Colors.white,
//         title: const Text(
//           'Api Requests',
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: Center(
//         child: FutureBuilder<Album>(
//           future: futureAlbum,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return Text(snapshot.data?.title ?? '');
//             } else if (snapshot.hasError) {
//               return Text('${snapshot.error}');
//             }
//             return const CircularProgressIndicator();
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class Album {
//   final int? userId;
//   final int? id;
//   final String? title;
//
//   const Album({
//     this.userId,
//     this.id,
//     this.title,
//   });
//
//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       userId: json['userId'],
//       id: json['id'],
//       title: json['title'],
//     );
//   }
// }
///
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({
//     super.key,
//     required this.title,
//   });
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final TextEditingController _controller = TextEditingController();
//   final _channel = WebSocketChannel.connect(
//     Uri.parse('wss://echo.websocket.events'),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Form(
//               child: TextFormField(
//                 controller: _controller,
//                 decoration: const InputDecoration(
//                   labelText: 'Send a message',
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),
//             StreamBuilder(
//               stream: _channel.stream,
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Text('loading...');
//                 } else {
//                   return Text(snapshot.data);
//                 }
//               },
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _sendMessage,
//         tooltip: 'Send message',
//         child: const Icon(Icons.send),
//       ),
//     );
//   }
//
//   void _sendMessage() {
//     if (_controller.text.isNotEmpty) {
//       _channel.sink.add(_controller.text);
//     }
//   }
//
//   @override
//   void dispose() {
//     _channel.sink.close();
//     _controller.dispose();
//     super.dispose();
//   }
// }
//======================================//
/// Web View
// class View extends StatelessWidget {
//   const View({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('WebView with Scroll'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         child: Column(
//           children: [
//             TextFormField(
//               decoration: InputDecoration(
//                 hintText: 'Field 1',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 15),
//             TextFormField(
//               decoration: InputDecoration(
//                 hintText: 'Field 2',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 side: const BorderSide(color: Colors.white, width: 3),
//                 backgroundColor: Colors.black26,
//                 fixedSize: const Size(double.maxFinite, 50),
//               ),
//               onPressed: () {},
//               child: const Text('Click 1'),
//             ),
//             const SizedBox(height: 10),
//             ConstrainedBox(
//               constraints: const BoxConstraints(maxHeight: 500),
//               child: const WebViewView(),
//             ),
//             const SizedBox(height: 10),
//             OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 side: const BorderSide(color: Colors.white, width: 3),
//                 backgroundColor: Colors.black26,
//                 fixedSize: const Size(double.maxFinite, 50),
//               ),
//               onPressed: () {},
//               child: const Text('Click 2'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
/// Google Map
// return Scaffold(
//   body: GoogleMap(
//     mapType: MapType.hybrid,
//     initialCameraPosition: cameraPosition,
//     markers: {
//       const Marker(
//         markerId: MarkerId('1'),
//         position: LatLng(31.4055239, 31.0561257),
//       ),
//     },
//   ),
// );
/// Location and translation placeMark
// CameraPosition cameraPosition = const CameraPosition(
//   target: LatLng(31.4055239, 31.0561257),
//   zoom: 13,
// );
//
// @override
// void initState() {
//   getLocation(
//     const LatLng(31.4055239, 31.0561257),
//   );
//   super.initState();
// }
//
// Future<void> getLocaleIdentifier() async {
//   await GeocodingPlatform.instance!.setLocaleIdentifier('en');
// }
//
// Future<void> getLocation(LatLng latLng) async {
//   try {
//     await getLocaleIdentifier();
//     List<Placemark> placemarks =
//         await GeocodingPlatform.instance!.placemarkFromCoordinates(
//       latLng.latitude,
//       latLng.longitude,
//     );
//     if (placemarks.isNotEmpty) {
//       Placemark place = placemarks.first;
//       print('Original Place: $place');
//       String location =
//           '${place.street ?? ''}, ${place.subAdministrativeArea ?? ''}, ${place.administrativeArea ?? ''}, ${place.country ?? ''}';
//       print('Original Location: $location');
//     } else {
//       print('No placemarks found.');
//     }
//   } catch (e) {
//     print('Error: $e');
//   }
// }
/// Searchable DDL
//return Scaffold(
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 16,
//           vertical: 50,
//         ),
//         child: Form(
//           key: formKey,
//           child: Column(
//             children: [
//               Stack(
//                 children: [
//                   SizedBox(
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: TextFormField(
//                             controller: phoneController,
//                             keyboardType: TextInputType.phone,
//                             onTapOutside: (event) {
//                               FocusManager.instance.primaryFocus?.unfocus();
//                             },
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Phone is Required!!!';
//                               } else if (value.length < 15) {
//                                 return 'Phone must be at least 15 numbers';
//                               } else {
//                                 return null;
//                               }
//                             },
//                             decoration: const InputDecoration(
//                               labelText: 'Phone Number',
//                               border: OutlineInputBorder(),
//                               contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 12,
//                                 vertical: 14,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 15),
//                         SizedBox(
//                           width: 117,
//                           child: DropdownSearch<String>(
//                             items: (filter, loadProps) => [
//                               '+ 1',
//                               '+ 33',
//                               '+ 44',
//                               '+ 55',
//                             ],
//                             itemAsString: (item) => item,
//                             selectedItem: selectedCountryCode,
//                             onChanged: (value) {
//                               setState(() {
//                                 selectedCountryCode = value;
//                                 if (kDebugMode) {
//                                   print(selectedCountryCode);
//                                 }
//                               });
//                             },
//                             dropdownBuilder: (context, selectedItem) {
//                               return Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Icon(
//                                     Icons.flag,
//                                     size: 16,
//                                   ),
//                                   Text('$selectedCountryCode'),
//                                 ],
//                               );
//                             },
//                             popupProps: PopupProps.menu(
//                               showSearchBox: true,
//                               searchFieldProps: const TextFieldProps(
//                                 decoration: InputDecoration(
//                                   hintText: 'Search',
//                                   contentPadding: EdgeInsets.symmetric(
//                                       vertical: 13, horizontal: 10),
//                                   prefixIcon: Icon(
//                                     Icons.search_outlined,
//                                     size: 20,
//                                   ),
//                                 ),
//                               ),
//
//                               /// item when open ddl...
//                               itemBuilder:
//                                   (context, item, isDisabled, isSelected) {
//                                 bool isSelect = item == selectedCountryCode;
//                                 return Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 20, vertical: 15),
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                     color: isSelect ? Colors.grey : null,
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       const Icon(
//                                         Icons.flag,
//                                         size: 16,
//                                       ),
//                                       const SizedBox(width: 10),
//                                       Text(item),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                             decoratorProps: const DropDownDecoratorProps(
//                               decoration: InputDecoration(
//                                 border: OutlineInputBorder(),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 50,
//               ),
//               FilledButton(
//                 onPressed: () {
//                   if (formKey.currentState!.validate()) {
//                     if (kDebugMode) {
//                       print(
//                         'Selected Country Code: $selectedCountryCode , Phone: ${phoneController.text}',
//                       );
//                     }
//                   }
//                 },
//                 style: FilledButton.styleFrom(
//                   backgroundColor: Colors.black26,
//                   minimumSize: const Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//                 child: const Text(
//                   'Click',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
/// Paypal Integration
//return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xff003087),
//         elevation: 0.5,
//         title: const Text(
//           'Paypal Payment',
//           style: TextStyle(
//               fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
//         ),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 8),
//             child: Icon(Icons.paypal_outlined),
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding:
//             const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 20),
//             const FittedBox(child: TableData()),
//             const SizedBox(height: 20),
//             const Divider(color: Color(0xff003087)),
//             const SizedBox(height: 10),
//             const Text(
//               'You Will Pay After Tax: 34.00 USD',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//             const SizedBox(height: 50),
//             FilledButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => PaypalCheckoutView(
//                       sandboxMode: true,
//                       clientId: AppConst.clientId,
//                       secretKey: AppConst.secretId,
//                       transactions: const [
//                         {
//                           "amount": {
//                             "total": '34.00',
//                             "currency": "USD",
//                             "details": {
//                               "subtotal": '34.00',
//                               "shipping": '0',
//                               "shipping_discount": 0
//                             }
//                           },
//                           "description": "Payment Details",
//                           "item_list": {
//                             "items": [
//                               {
//                                 "name": "Item 1",
//                                 "quantity": 1,
//                                 "price": '12',
//                                 "currency": "USD"
//                               },
//                               {
//                                 "name": "Item 2",
//                                 "quantity": 1,
//                                 "price": '22',
//                                 "currency": "USD"
//                               }
//                             ],
//                           }
//                         },
//                       ],
//                       note:
//                           "Contact us for any questions on your order.",
//                       onSuccess: (Map params) async {
//                         Navigator.pop(context);
//                         log("onSuccess: $params");
//                         debugPrint("onSuccess: $params");
//                       },
//                       onError: (error) {
//                         Navigator.pop(context);
//                         log("onError: $error");
//                         debugPrint('onError: $error');
//                       },
//                       onCancel: () {
//                         Navigator.pop(context);
//                         log('onCancelled:');
//                         debugPrint('onCancelled:');
//                       },
//                     ),
//                   ),
//                 );
//               },
//               style: FilledButton.styleFrom(
//                   backgroundColor: const Color(0xff003087),
//                   minimumSize: const Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15))),
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Pay by',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Icon(Icons.paypal_outlined),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//Customize Table
//class TableData extends StatelessWidget {
//   const TableData({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return DataTable(
//       decoration: BoxDecoration(
//         color: const Color(0xff003087).withOpacity(0.08),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       clipBehavior: Clip.antiAlias,
//       columns: [
//         buildDataColumnItem(title: 'Item'),
//         buildDataColumnItem(title: 'Price'),
//         buildDataColumnItem(title: 'Tax'),
//         buildDataColumnItem(title: 'Total'),
//       ],
//       rows: [
//         buildDataRowCells(
//           title: 'Item 1',
//           price: '10.00',
//           tax: '2.00 USD',
//           total: '12.00 USD',
//         ),
//         buildDataRowCells(
//           title: 'Item 2',
//           price: '20.00',
//           tax: '2.00 USD',
//           total: '22.00 USD',
//         ),
//       ],
//     );
//   }
//
//   DataRow buildDataRowCells(
//           {required String title,
//           required String price,
//           required String tax,
//           required String total}) =>
//       DataRow(
//         cells: [
//           DataCell(Text(title)),
//           DataCell(Text(price)),
//           DataCell(Text(tax)),
//           DataCell(Text(total)),
//         ],
//       );
//
//   DataColumn buildDataColumnItem({required String title}) => DataColumn(
//         label: Text(
//           title,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       );
// }
/// WebSocket
//ListView Builder child
//child: ListView.builder(
//           physics: const BouncingScrollPhysics(),
//           padding: const EdgeInsets.all(10),
//           itemCount: _messages.length,
//           itemBuilder: (context, index) => Card(
//             elevation: 4,
//             margin: const EdgeInsets.symmetric(
//               vertical: 10,
//             ),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: ListTile(
//               title: Text(
//                 _messages[index],
//                 style: const TextStyle(
//                   fontSize: 16,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),
//           ),
//         ),
/// Bitcoin price
//class WebSocketView extends StatefulWidget {
//   const WebSocketView({super.key});
//
//   @override
//   State<WebSocketView> createState() => _WebSocketViewState();
// }
//
// class _WebSocketViewState extends State<WebSocketView>
//     with SingleTickerProviderStateMixin {
//   // String? selectedCountryCode = "+1";
//   // TextEditingController phoneController = TextEditingController();
//   // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   // final List<String> _messages = [];
//   final WebSocketChannel _channel = IOWebSocketChannel.connect(
//       'wss://stream.binance.com:9443/ws/btcusdt@trade');
//
//   String _lastPrice = 'loading...';
//   String _lastQuantity = 'loading...';
//
//   late AnimationController _animationController;
//   late Animation<double> animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _listenToMessage();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(
//         microseconds: 5000,
//       ),
//     );
//
//     animation = Tween<double>(
//       begin: 1.0,
//       end: 1.2,
//     ).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeInOut,
//       ),
//     );
//   }
//
//   void _listenToMessage() {
//     _channel.stream.listen(
//       (message) {
//         final data = jsonDecode(message);
//         final price = data['p'];
//         final quantity = data['q'];
//         _animationController.forward().then(
//               (_) => _animationController.reverse(),
//             );
//         setState(() {
//           _lastPrice = price;
//           _lastQuantity = quantity;
//         });
//         // setState(() {
//         //   _messages.add(message);
//         // });
//       },
//       onError: (error) {
//         setState(() {
//           _lastPrice = 'Error: $error';
//           _lastQuantity = 'Error: $error';
//         });
//         // setState(() {
//         //   log('error: $error');
//         // });
//       },
//       onDone: () {
//         setState(() {
//           _lastPrice = 'Connection closed';
//           _lastQuantity = 'Connection closed';
//         });
//         // setState(() {
//         //   _messages.add('Connection closed');
//         // });
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0.5,
//         title: const Text(
//           'Web Socket Test Real Time',
//           style: TextStyle(
//               fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.blue.shade900,
//               Colors.purple.shade900,
//             ],
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.currency_bitcoin,
//                   color: Colors.amber, size: 100),
//               const SizedBox(height: 20),
//               Card(
//                 elevation: 0.5,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 color: Colors.white,
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text("BTC/USDT Real-Time Price",
//                           style: TextStyle(color: Colors.blue.shade900)),
//                       const SizedBox(height: 10),
//                       const Text(
//                         'Last Trade Price:',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       Text(
//                         "$_lastPrice USDT",
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.green,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       const Text(
//                         'Last Trade Quantity:',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       Text(
//                         "$_lastQuantity BTC",
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
