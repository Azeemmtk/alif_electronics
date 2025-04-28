import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildCategorySection(String title, List<Map<String, dynamic>> items) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(items.isEmpty ? '' : title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      if (items.isNotEmpty)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: items.first.keys
                .map((key) => DataColumn(label: Text(key)))
                .toList(),
            rows: items.map((item) {
              return DataRow(
                cells: item.values
                    .map((value) => DataCell(Text(value.toString())))
                    .toList(),
              );
            }).toList(),
          ),
        )
    ],
  );
}
