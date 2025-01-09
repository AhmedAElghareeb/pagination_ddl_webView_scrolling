import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

// import 'package:first/webview.dart';
// import 'dart:convert';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: CountryCodeInput(),
    );
  }
}

class CountryCodeInput extends StatefulWidget {
  const CountryCodeInput({super.key});

  @override
  State<CountryCodeInput> createState() => _CountryCodeInputState();
}

class _CountryCodeInputState extends State<CountryCodeInput> {
  String? selectedCountryCode = "+1";
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Country Code Input")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                SizedBox(
                  width: 117,
                  child: DropdownSearch<String>(
                    items: (filter, loadProps) => [
                      '+ 1',
                      '+ 33',
                      '+ 44',
                      '+ 55',
                      '+ 66',
                      '+ 77',
                      '+ 88',
                      '+ 99',
                    ],
                    itemAsString: (item) => item,
                    onChanged: (value) {
                      setState(() {
                        selectedCountryCode = value;
                        if (kDebugMode) {
                          print(selectedCountryCode);
                        }
                      });
                    },
                    dropdownBuilder: (context, selectedItem) {
                      return Row(
                        children: [
                          const Icon(
                            Icons.flag,
                            size: 16,
                          ),
                          const SizedBox(width: 10),
                          Text('$selectedCountryCode'),
                        ],
                      );
                    },
                    popupProps: PopupProps.menu(
                      showSearchBox: true,
                      searchFieldProps: const TextFieldProps(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 13, horizontal: 10),
                          prefixIcon: Icon(
                            Icons.search_outlined,
                            size: 20,
                          ),
                        ),
                      ),

                      /// item when open ddl...
                      itemBuilder: (context, item, isDisabled, isSelected) {
                        bool isSelect = item == selectedCountryCode;
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isSelect ? Colors.grey : null,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.flag,
                                size: 16,
                              ),
                              const SizedBox(width: 10),
                              Text(item),
                            ],
                          ),
                        );
                      },
                    ),
                    decoratorProps: const DropDownDecoratorProps(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
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
///
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
