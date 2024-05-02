import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:path_provider/path_provider.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'dart:io';


class DocumentationPage extends StatelessWidget {
  // Sample documentation content

  final List<Map<String, dynamic>> users = [
    {
      "id": 1,
      "name": "Tanay Sayed",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "address": "Pabna",
      "image": ""
    },
    {
      "id": 2,
      "name": "Bkash Nahid",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "address": "Pabna",
      "image": ""
    },
    {
      "id": 3,
      "name": "Pitom Ahmed",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "address": "Pabna",
      "image": ""
    },
    {
      "id": 4,
      "name": "Roni From ",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "address": "Pabna",
      "image": ""
    },
    {
      "id": 5,
      "name": "Partho Das",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "address": "Pabna",
      "image": ""
    },
    {
      "id": 6,
      "name": "Bkash Naiii",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "address": "Pabna",
      "image": ""
    },
    {
      "id": 7,
      "name": "Bkash Nahid",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "address": "Pabna",
      "image": ""
    },
    {
      "id": 8,
      "name": "Nahid Bkash",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "address": "Pabna",
      "image": ""
    },
    {
      "id": 9,
      "name": "Bkash Bolci",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "address": "Pabna",
      "image": ""
    },
    {
      "id": 10,
      "name": "Tanay Sayed",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "address": "Pabna",
      "image": ""
    },
    {
      "id": 11,
      "name": "Tanay Sayed",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "address": "Pabna",
      "image": ""
    },
    {
      "id": 12,
      "name": "Tanay Sayed",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "address": "Pabna",
      "image": ""
    },
    {
      "id": 13,
      "name": "Tanay Sayed",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "address": "Pabna",
      "image": ""
    },
    {
      "id": 14,
      "name": "Tanay Sayed",
      "employeeCode": "###",
      "faName": "New York",
      "gender": "Male",
      "dateOfBirth": "9-9-2000",
      "Nationality": "BD",
      "address": "Pabna",
      "image": ""
    },
    {"id": 15, "name": "Tanay Sayed", "employeeCode": "###", "faName": "New York", "gender": "Male", "dateOfBirth": "9-9-2000", "Nationality": "BD", "address": "Pabna", "image": ""},
    // {"id": 16, "name": "Tanay Sayed", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","address":"Pabna","image":""},
    // {"id": 17, "name": "Tanay Sayed", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","address":"Pabna","image":""},
    // {"id": 18, "name": "Tanay Sayed", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","address":"Pabna","image":""},
    // {"id": 19, "name": "Tanay Sayed", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","address":"Pabna","image":""},
    // {"id": 20, "name": "Tanay Sayed", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","address":"Pabna","image":""},
    // {"id": 21, "name": "Tanay Sayed", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","address":"Pabna","image":""},
    // {"id": 22, "name": "Tanay Sayed", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","address":"Pabna","image":""},
    // {"id": 23, "name": "Tanay Sayed", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","address":"Pabna","image":""},
    // {"id": 24, "name": "Tanay Sayed", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","address":"Pabna","image":""},
    //{"id": 25, "name": "Tanay Sayed", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","address":"Pabna","image":""},

  ];

  final List<Map<String, dynamic>> userss = [
    {"id": 1, "name": "Tanay Sayed", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","image":""},
    {"id": 2, "name": "Bkash Nahid", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","image":""},
    {"id": 3, "name": "Pitom Ahmed", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","image":""},
    {"id": 4, "name": "Roni From Noakhali", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","image":""},
    {"id": 5, "name": "Partho Das", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","image":""},
    {"id": 6, "name": "Bkash Naiii", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","image":""},
    {"id": 7, "name": "Bkash Nahid", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","image":""},
    {"id": 8, "name": "Nahid Bkash", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","image":""},
    {"id": 9, "name": "Bkash Bolci", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","image":""},
    {"id": 10, "name": "Tanay Sayed", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","image":""},
    {"id": 11, "name": "Tanay Sayed", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","image":""},
    {"id": 12, "name": "Tanay Sayed", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","image":""},
    {"id": 13, "name": "Tanay Sayed", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","image":""},
    {"id": 14, "name": "Tanay Sayed", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","image":""},
    {"id": 15, "name": "Tanay Sayed", "employeeCode": "###","faName": "New York", "gender":"Male", "dateOfBirth":"9-9-2000","Nationality":"BD","image":""},

  ];

  final String documentationContent = ""
      "Abul Kalam Mallick, a meteorologist at the Bangladesh Meteorological Department,"
      " confirmed the matter to The Daily Star,"
      " adding that it was the highest temperature recorded in Bangladesh this year."
      "He also said 43.7 degrees Celsius was recorded in Chuadanga today. "
      "Meanwhile, the highest temperature in Dhaka was recorded at 38.6 degrees Celsius."
      "Meanwhile, the highest temperature in Dhaka was recorded at 38.6 degrees Celsius."
      "Meanwhile, the highest temperature in Dhaka was recorded at 38.6 degrees Celsius."
      "Meanwhile, the highest temperature in Dhaka was recorded at 38.6 degrees Celsius."
  ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Documentation'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Common Documentations',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                documentationContent,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => _createPDF(context),
                child: Text('Download as PDF'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isPDFCreated = false;

  Future<void> _createPDF(BuildContext context) async {
    if (_isPDFCreated) {
      // PDF has already been created, no need to create again
      return;
    }

    // Set _isPDFCreated to true to indicate that PDF creation has started
    _isPDFCreated = true;

    final pdf = pw.Document();

    // Create a table header
    final List<String> headers = ["ID", "Name", "Employee Code", "Father's Name", "Gender", "Date of Birth", "Nationality", "Image"];

    // Split the data into chunks (each chunk represents data for a page)
    final int chunkSize = 10; // Adjust the chunk size as needed
    final List<List<Map<String, dynamic>>> chunks = List.generate((users.length / chunkSize).ceil(), (index) {
      final int start = index * chunkSize;
      final int end = (index + 1) * chunkSize;
      return users.sublist(start, end > users.length ? users.length : end);
    });

    // Add pages to PDF
    for (final chunk in chunks) {
      final List<List<String>> data = [];

      // Add rows of data to the table
      for (final user in chunk) {
        final List<String> row = [
          user["id"].toString(),
          user["name"],
          user["employeeCode"],
          user["faName"],
          user["gender"],
          user["dateOfBirth"],
          user["Nationality"],
          user["image"],
        ];
        data.add(row);
      }

      // Add table to PDF
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.TableHelper.fromTextArray(
              headers: headers,
              data: data,
              border: pw.TableBorder.all(),
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              cellStyle: const pw.TextStyle(),
            );
          },
        ),
      );
    }


        // Add first page
        final List<List<String>> datas = [];

        // Add rows of data to the table
        for (final user in users) {
          final List<String> row = [
            user["id"].toString(),
            user["name"],
            user["employeeCode"],
            user["faName"],
            user["gender"],
            user["dateOfBirth"],
            user["Nationality"],
            user["address"],
            user["image"],
          ];
          datas.add(row);

              pdf.addPage(
                pw.Page(
                  build: (pw.Context context) {
                    return pw.Center(
                      child: pw.Column(
                        // CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
                          children: [
                            pw.Text(textScaleFactor: 2,
                                "This is First Line"),
                            pw.SizedBox(height: 50),
                            pw.Text(
                                textScaleFactor: 2,
                                'Page 1: $datas')
                          ]
                      ),
                    );
                  },
                ),
              );

        }


    // Save and share the PDF
    final Uint8List bytes = await pdf.save();
    final directory = await getApplicationDocumentsDirectory();
    final String path = '${directory.path}/users.pdf';
    final File file = File(path);
    await file.writeAsBytes(bytes);

    // Open the PDF
    Printing.sharePdf(bytes: bytes, filename: 'users.pdf');
  }



///  second update
  // Future<void> _createPDF(BuildContext context) async {
  //   final pdf = pw.Document();
  //   // Create a table header
  //   final List<String> headers = [
  //     "ID",
  //     "Name",
  //     "Employee Code",
  //     "Father's Name",
  //     "Gender",
  //     "Date of Birth",
  //     "Nationality",
  //     "Address",
  //     "Image"
  //   ];
  //
  //   // Split the data into chunks (each chunk represents data for a page)
  //   final int chunkSize = 7; // Adjust the chunk size as needed
  //   final List<List<Map<String, dynamic>>> chunks = List.generate(
  //       (users.length / chunkSize).ceil(), (index) {
  //     final int start = index * chunkSize;
  //     final int end = (index + 1) * chunkSize;
  //     return users.sublist(start, end > users.length ? users.length : end);
  //   });
  //
  //   // Add pages to PDF
  //   for (final chunk in chunks) {
  //     final List<List<String>> data = [];
  //
  //     // Add rows of data to the table
  //     for (final user in chunk) {
  //       final List<String> row = [
  //         user["id"].toString(),
  //         user["name"],
  //         user["employeeCode"],
  //         user["faName"],
  //         user["gender"],
  //         user["dateOfBirth"],
  //         user["Nationality"],
  //         user["address"],
  //         user["image"],
  //       ];
  //       data.add(row);
  //     }
  //
  //
  //     // Create a table header
  //     // final List<String> headers = ["ID", "Name", "Employee Code", "Father's Name", "Gender", "Date of Birth", "Nationality", "Address","Image",];
  //     // final List<List<String>> data = [];
  //     //
  //     // // Add rows of data to the table
  //     // for (final user in users) {
  //     //   final List<String> row = [
  //     //     user["id"].toString(),
  //     //     user["name"],
  //     //     user["employeeCode"],
  //     //     user["faName"],
  //     //     user["gender"],
  //     //     user["dateOfBirth"],
  //     //     user["Nationality"],
  //     //     user["address"],
  //     //     user["image"],
  //     //   ];
  //     //   data.add(row);
  //     // }
  //
  //     // Add first page
  //     pdf.addPage(
  //       pw.Page(
  //         build: (pw.Context context) {
  //           return pw.Center(
  //             child: pw.Column(
  //               // CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  //                 children: [
  //                   pw.Text(textScaleFactor: 2,
  //                       "This is First Line"),
  //                   pw.SizedBox(height: 50),
  //                   pw.Text(
  //                       textScaleFactor: 2,
  //                       'Page 1: $documentationContent')
  //                 ]
  //             ),
  //           );
  //         },
  //       ),
  //     );
  //
  //     // Add second page
  //     // Add first page
  //     pdf.addPage(
  //       pw.Page(
  //         build: (pw.Context context) {
  //           return pw.Center(
  //               child: pw.Column(
  //
  //                   children: [
  //                     pw.TableHelper.fromTextArray(
  //                       headers: headers,
  //                       data: data,
  //                       border: pw.TableBorder.all(),
  //                       headerStyle: pw.TextStyle(
  //                           fontWeight: pw.FontWeight.bold),
  //                       cellStyle: const pw.TextStyle(),
  //                     ),
  //                   ]
  //               )
  //           );
  //         },
  //       ),
  //     );
  //
  //     // Save and share the PDF
  //     final Uint8List bytes = await pdf.save();
  //     final directory = await getApplicationDocumentsDirectory();
  //     final String path = '${directory.path}/documentation.pdf';
  //     await pdf.save();
  //     print("path $path");
  //     final File file = File(path);
  //     await file.writeAsBytes(bytes);
  //
  //     // Open the PDF
  //     Printing.sharePdf(bytes: bytes, filename: 'documentation.pdf');
  //   }
  // }
}
