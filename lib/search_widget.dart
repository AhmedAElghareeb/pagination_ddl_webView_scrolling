// import 'package:flutter/material.dart';
// import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';
//
// class SearchWidget<T> extends StatelessWidget {
//   const SearchWidget({super.key, this.items});
//
//   final Future<List<SearchableDropdownMenuItem<T>>?> Function(int, String?)?
//   items;
//
//   @override
//   Widget build(BuildContext context) {
//     return SearchableDropdown<T>.paginated(
//       noRecordText: const Text('لا يوجد بيانات'),
//       searchHintText: 'ابحث',
//       backgroundDecoration: (child) => InputDecorator(
//         baseStyle: const TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.w500,
//         ),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.grey.shade200,
//           contentPadding: const EdgeInsets.symmetric(horizontal: 8),
//           errorStyle: const TextStyle(
//             color: Colors.red,
//             fontSize: 12,
//           ),
//           errorMaxLines: 2,
//           border: _border(context),
//           enabledBorder: _border(context),
//           focusedBorder: _border(context),
//           errorBorder: _border(context),
//           focusedErrorBorder: _border(context),
//           disabledBorder: _border(context),
//         ),
//         child: child,
//       ),
//       hintText: const Text(
//         'Paginated request',
//         style: TextStyle(fontSize: 16),
//       ),
//       paginatedRequest: items,
//       onChanged: (T? value) {
//         debugPrint('$value');
//       },
//       hasTrailingClearIcon: false,
//       trailingIcon: const Icon(
//         Icons.keyboard_arrow_down_outlined,
//       ),
//     );
//   }
//
//   OutlineInputBorder _border(context) => OutlineInputBorder(
//     borderRadius: BorderRadius.circular(8),
//     borderSide: const BorderSide(color: Colors.grey),
//   );
// }

// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// const Text(
// 'Pokemons',
// style: TextStyle(
// fontSize: 16,
// fontWeight: FontWeight.w500,
// ),
// ),
// const SizedBox(height: 8),
// SearchWidget(
// items: (int page, String? searchKey) async {
// final paginatedList = await getAnimeList(filter: page);
// return paginatedList
//     .map(
// (e) => SearchableDropdownMenuItem(
// value: e.name,
// label: e.name,
// child: Text(
// e.name,
// ),
// ),
// )
//     .toList();
// },
// ),
// ],
// ),
// )
// Future<List<UserModel>> getAnimeList({required int filter}) async {
//   try {
//     var response = await dio.get(
//       "https://63c1210999c0a15d28e1ec1d.mockapi.io/users",
//       queryParameters: {"filter": filter},
//     );
//     final data = response.data;
//     if (data != null) {
//       return UserModel.fromJsonList(data);
//     } else {
//       return [];
//     }
//   } catch (exception) {
//     throw Exception(exception);
//   }
// }
