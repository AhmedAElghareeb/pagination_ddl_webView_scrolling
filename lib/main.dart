import 'dart:developer';

import 'package:first/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:first/webview.dart';
// import 'dart:convert';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      home: const PaypalPaymentView(),
    );
  }
}

class PaypalPaymentView extends StatefulWidget {
  const PaypalPaymentView({super.key});

  @override
  State<PaypalPaymentView> createState() => _PaypalPaymentViewState();
}

class _PaypalPaymentViewState extends State<PaypalPaymentView> {
  // String? selectedCountryCode = "+1";
  // TextEditingController phoneController = TextEditingController();
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff003087),
        elevation: 0.5,
        title: const Text(
          'Paypal Payment',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Icon(Icons.paypal_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const FittedBox(child: TableData()),
            const SizedBox(height: 20),
            const Divider(color: Color(0xff003087)),
            const SizedBox(height: 10),
            const Text(
              'You Will Pay After Tax: 34.00 USD',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 50),
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaypalCheckoutView(
                      sandboxMode: true,
                      clientId: AppConst.clientId,
                      secretKey: AppConst.secretId,
                      transactions: const [
                        {
                          "amount": {
                            "total": '34.00',
                            "currency": "USD",
                            "details": {
                              "subtotal": '34.00',
                              "shipping": '0',
                              "shipping_discount": 0
                            }
                          },
                          "description": "Payment Details",
                          "item_list": {
                            "items": [
                              {
                                "name": "Item 1",
                                "quantity": 1,
                                "price": '12',
                                "currency": "USD"
                              },
                              {
                                "name": "Item 2",
                                "quantity": 1,
                                "price": '22',
                                "currency": "USD"
                              }
                            ],
                          }
                        },
                      ],
                      note:
                          "Contact us for any questions on your order.",
                      onSuccess: (Map params) async {
                        Navigator.pop(context);
                        log("onSuccess: $params");
                        debugPrint("onSuccess: $params");
                      },
                      onError: (error) {
                        Navigator.pop(context);
                        log("onError: $error");
                        debugPrint('onError: $error');
                      },
                      onCancel: () {
                        Navigator.pop(context);
                        log('onCancelled:');
                        debugPrint('onCancelled:');
                      },
                    ),
                  ),
                );
              },
              style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xff003087),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pay by',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.paypal_outlined),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TableData extends StatelessWidget {
  const TableData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      decoration: BoxDecoration(
        color: const Color(0xff003087).withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      columns: [
        buildDataColumnItem(title: 'Item'),
        buildDataColumnItem(title: 'Price'),
        buildDataColumnItem(title: 'Tax'),
        buildDataColumnItem(title: 'Total'),
      ],
      rows: [
        buildDataRowCells(
          title: 'Item 1',
          price: '10.00',
          tax: '2.00 USD',
          total: '12.00 USD',
        ),
        buildDataRowCells(
          title: 'Item 2',
          price: '20.00',
          tax: '2.00 USD',
          total: '22.00 USD',
        ),
      ],
    );
  }

  DataRow buildDataRowCells(
          {required String title,
          required String price,
          required String tax,
          required String total}) =>
      DataRow(
        cells: [
          DataCell(Text(title)),
          DataCell(Text(price)),
          DataCell(Text(tax)),
          DataCell(Text(total)),
        ],
      );

  DataColumn buildDataColumnItem({required String title}) => DataColumn(
        label: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}

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
