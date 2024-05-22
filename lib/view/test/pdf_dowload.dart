import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
// import 'package:path_provider/path_provider.dart';

import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';

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
    // final List<String> headers = ["ID", "Name", "Employee Code", "Father's Name", "Gender", "Date of Birth", "Nationality", "Image"];

    // Split the data into chunks (each chunk represents data for a page)
    // const int chunkSize = 10; // Adjust the chunk size as needed
    // final List<List<Map<String, dynamic>>> chunks = List.generate((users.length / chunkSize).ceil(), (index) {
      // final int start = index * chunkSize;
      // final int end = (index + 1) * chunkSize;
      // return users.sublist(start, end > users.length ? users.length : end);
    // });

    // Add pages to PDF
    // for (final chunk in chunks) {
    //   final List<List<String>> data = [];
    //
    //   // Add rows of data to the table
    //   for (final user in chunk) {
    //     final List<String> row = [
    //       user["id"].toString(),
    //       user["name"],
    //       user["employeeCode"],
    //       user["faName"],
    //       user["gender"],
    //       user["dateOfBirth"],
    //       user["Nationality"],
    //       user["image"],
    //     ];
    //     data.add(row);
    //   }
    //
    //   // Add table to PDF
    //   pdf.addPage(
    //     pw.Page(
    //       build: (pw.Context context) {
    //         return pw.TableHelper.fromTextArray(
    //           headers: headers,
    //           data: data,
    //           border: pw.TableBorder.all(),
    //           headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
    //           cellStyle: const pw.TextStyle(),
    //         );
    //       },
    //     ),
    //   );
    // }

    // Pdf Format

    // Add content to PDF
    final Uint8List imageBytes = await _getImageBytes('assets/images/profile_pic.png');
    final pdfImage = pw.MemoryImage(imageBytes);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              pw.Container(
                color: PdfColors.red,
                width: double.infinity,
                height: 2, // Adjust border thickness as needed
                margin: const pw.EdgeInsets.all(0.0), // Remove gap from right side
              ),
              pw.SizedBox(height: 5),
              pw.Column(
                children: [
                  pw.Text('SZamanTech', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 5),
                  pw.Text('Phone:+8801713694070, Address: 93, Kazi Nazrul Islam Avenue, (5th Floor),',),
                  pw.SizedBox(height: 5),
                  pw.Text('Kawran Bazar, Dhaka-1215',),
                  pw.Divider(
                    color: PdfColors.black,
                  )
                ]
              ),

              pw.SizedBox(height: 10),
              pw.Row(
                children: [
                  pw.Column(
                    children: [
                      pw.Text('testtest_designation'),
                      pw.SizedBox(height: 5),
                      pw.Text('ID: SZT-0001'),
                    ]
                  ),
                  pw.Spacer(),
                  pw.Image(
                      pdfImage,
                    width: 75,
                    height: 100,
                    fit: pw.BoxFit.contain
                  ),
                ]
              ),
              pw.SizedBox(height: 10),

              // General Information
              pw.SizedBox(height: 20),
              pw.Text('General Information',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 5),
              pw.Row(
                  children: [
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Father Name :'),
                          pw.Text('Mother Name :'),
                          pw.Text('Gender :'),
                          pw.Text('Date Of Birth :'),
                          pw.Text('Nationality :'),
                          pw.Text('NID :'),
                          pw.Text('Present Address :'),
                          pw.Text('Permanent Address :'),
                        ]
                    ),
                    // pw.SizedBox(width: 20,),
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Father'),
                          pw.Text('Mother'),
                          pw.Text('Male'),
                          pw.Text('07/05/2024'),
                          pw.Text('Bangladesh'),
                          pw.Text('15523322311'),
                          pw.Text('Dhaka'),
                          pw.Text('Dhaka'),
                        ]
                    ),
                  ]
              ),

              // Education

              pw.SizedBox(height: 20),
              pw.Text('Education',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 5),
              pw.Row(
                  children: [
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Father Name :'),
                          pw.Text('Mother Name :'),
                          pw.Text('Gender :'),
                          pw.Text('Date Of Birth :'),
                          pw.Text('Nationality :'),
                          pw.Text('NID :'),
                          pw.Text('Present Address :'),
                          pw.Text('Permanent Address :'),
                        ]
                    ),
                    // pw.SizedBox(width: 20,),
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Father'),
                          pw.Text('Mother'),
                          pw.Text('Male'),
                          pw.Text('07/05/2024'),
                          pw.Text('Bangladesh'),
                          pw.Text('15523322311'),
                          pw.Text('Dhaka'),
                          pw.Text('Dhaka'),
                        ]
                    ),
                  ]
              ),
              pw.SizedBox(height: 20),
              pw.Text('Employee',style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 5),
              pw.Row(
                  children: [
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Father Name :'),
                          pw.Text('Mother Name :'),
                          pw.Text('Gender :'),
                          pw.Text('Date Of Birth :'),
                          pw.Text('Nationality :'),
                          pw.Text('NID :'),
                          pw.Text('Present Address :'),
                          pw.Text('Permanent Address :'),
                        ]
                    ),
                    // pw.SizedBox(width: 20,),
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Father'),
                          pw.Text('Mother'),
                          pw.Text('Male'),
                          pw.Text('07/05/2024'),
                          pw.Text('Bangladesh'),
                          pw.Text('15523322311'),
                          pw.Text('Dhaka'),
                          pw.Text('Dhaka'),
                        ]
                    ),
                  ]
              ),
              pw.Spacer(),
              pw.Container(
                color: PdfColors.greenAccent,
                width: double.infinity,
                height: 2, // Adjust border thickness as needed
                margin: const pw.EdgeInsets.all(0.0), // Remove gap from right side
              ),
            ],
          );
        },
      ),
    );




    // Save and share the PDF
    final Uint8List bytes = await pdf.save();
    final directory = await getApplicationDocumentsDirectory();
    final String path = '${directory.path}/users.pdf';
    final File file = File(path);
    await file.writeAsBytes(bytes);

    // Open the PDF
    // Printing.sharePdf(bytes: bytes, filename: 'users.pdf');
  }

  Future<Uint8List> _getImageBytes(String imagePath) async {
    final ByteData data = await rootBundle.load(imagePath);
    return data.buffer.asUint8List();
  }

}
