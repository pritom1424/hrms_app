import 'dart:io';
import 'dart:typed_data';
//import 'package:alh_pdf_view/alh_pdf_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hrms_app/controller/employee_edit_data_controller.dart';
import 'package:hrms_app/model/hrms_employee_edit_model.dart';
import 'package:hrms_app/utils/app_variables/api_links.dart';
import 'package:hrms_app/utils/app_variables/app_vars.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';

import 'package:dio/dio.dart';

class TextToPdfConverter extends StatefulWidget {
  final int id;

  const TextToPdfConverter({super.key, required this.id});

  @override
  State<TextToPdfConverter> createState() => _TextToPdfConverterState();
}

class _TextToPdfConverterState extends State<TextToPdfConverter> {
  String imgPlaceHolder = "assets/images/propic_placeholder.png";
  final TextEditingController _textEditingController = TextEditingController();
  bool isLoading = false;
  String? _pdfPath;
  bool isInit = false;
  bool _isPDFCreated = false;
  Future<Uint8List> _getImageBytes(String imagePath) async {
    final ByteData data = await rootBundle.load(imagePath);
    return data.buffer.asUint8List();
  }

  Future<void> _generatePdf(HrmsEmployeeEditModel hrmsEmployeeEditModel) async {
    final pw.MemoryImage pdfImage;
    double columnSpaceHeight = 5;

    final theme = pw.PageTheme(
      margin: pw.EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      theme: pw.ThemeData(
          defaultTextStyle: pw.TextStyle(fontSize: 18),
          paragraphStyle: pw.TextStyle(fontSize: 15)),
      pageFormat: PdfPageFormat.a4, // Background color
      buildBackground: (pw.Context context) {
        // Draw a rectangle with the background color
        return pw.Container(
          width: PdfPageFormat.a4.width,
          height: PdfPageFormat.a4.height,
          color: PdfColor.fromInt(0xFFE2E1E1),
        );
      },

      // Optionally, you can also define other properties of the page theme
      // such as margins, padding, etc.
    );
    if (_isPDFCreated) {
      // PDF has already been created, no need to create again
      return;
    }
    // Set _isPDFCreated to true to indicate that PDF creation has started
    _isPDFCreated = true;
    // Create a table header
    // final List<String> headers = ["ID", "Name", "Employee Code", "Father's Name", "Gender", "Date of Birth", "Nationality", "Image"];

    // Split the data into chunks (each chunk represents data for a page)
    // const int chunkSize = 10; // Adjust the chunk size as needed
    // final List<List<Map<String, dynamic>>> chunks = List.generate((users.length / chunkSize).ceil(), (index) {
    // final int start = index * chunkSize;
    // final int end = (index + 1) * chunkSize;
    // return users.sublist(start, end > users.length ? users.length : end);
    // });
    final pdf = pw.Document();
    FocusScope.of(context).unfocus();
/*     final Uint8List imageBytes = await _getImageBytes(
        (hrmsEmployeeEditModel.image == null)
            ? imgPlaceHolder
            : (hrmsEmployeeEditModel.image.toString().isEmpty)
                ? imgPlaceHolder
                : widget.user!['image']
                    .toString()); //'assets/images/profile_pic.png'
    final pdfImage = pw.MemoryImage(imageBytes); */
    Dio dio = Dio();
    if (hrmsEmployeeEditModel.image != null) {
      final imageResponse = await dio.get(
          "https://hrms.szamantech.com/storage/employee/${hrmsEmployeeEditModel.image}",
          options: Options(responseType: ResponseType.bytes));

      if (imageResponse.statusCode == 200) {
        final Uint8List imageBytes = imageResponse.data;

        pdfImage = pw.MemoryImage(imageBytes);
      } else {
        final Uint8List imageBytes = await _getImageBytes(imgPlaceHolder);
        pdfImage = pw.MemoryImage(imageBytes);
      }
    } else {
      final Uint8List imageBytes = await _getImageBytes(imgPlaceHolder);
      pdfImage = pw.MemoryImage(imageBytes);
    }

    pdf.addPage(
      pw.Page(
        pageTheme: theme,
        //  theme: pw.ThemeData(defaultTextStyle: pw.TextStyle(fontSize: 18)),
        // pageFormat: PdfPageFormat.a4,
        build:
            (context) /* pw.Center(
          child: pw.Text(defaultText /* _textEditingController.text */,
              textScaleFactor: 2, style: pw.TextStyle(font: pw.Font.times())),
        ), */
            {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                color: PdfColors.blueAccent, //PdfColors.red,
                width: double.infinity,
                height: 5, // Adjust border thickness as needed
                margin:
                    const pw.EdgeInsets.all(0.0), // Remove gap from right side
              ),
              pw.SizedBox(height: columnSpaceHeight),
              pw.Container(
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text('SZamanTech',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 25)),
                      pw.SizedBox(height: 5),
                      pw.Text(
                          'Phone:+8801713694070, Address: 93, Kazi Nazrul Islam Avenue, (5th Floor),',
                          style: pw.Theme.of(context).paragraphStyle),
                      pw.SizedBox(height: 5),
                      pw.Text('Kawran Bazar, Dhaka-1215',
                          style: pw.Theme.of(context).paragraphStyle),
                      pw.Divider(
                        color: PdfColors.black,
                      )
                    ]),
              ),

              pw.SizedBox(height: 10),
              pw.Container(
                padding: pw.EdgeInsets.symmetric(horizontal: 20),
                child: pw.Row(children: [
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                            (hrmsEmployeeEditModel.employeeName == null)
                                ? "Name"
                                : hrmsEmployeeEditModel.employeeName.toString(),
                            style: pw.TextStyle(
                                fontSize: 18, fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(height: 5),
                        pw.Text(
                            (hrmsEmployeeEditModel
                                        .officeInformation?.designation ==
                                    null)
                                ? "Designation"
                                : hrmsEmployeeEditModel
                                        .officeInformation?.designation
                                        .toString() ??
                                    "Designation",
                            style: pw.TextStyle(
                                fontWeight: pw
                                    .FontWeight.bold)), //'testtest_designation'
                        pw.SizedBox(height: 5),
                        pw.Text(
                            (hrmsEmployeeEditModel.employeeCode == null)
                                ? "ID"
                                : "ID: ${hrmsEmployeeEditModel.employeeCode.toString()}",
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ]),
                  pw.Spacer(),
                  pw.Container(
                      width: 100,
                      height: 100,
                      child: pw.ClipRRect(
                        horizontalRadius: 50,
                        verticalRadius: 50,
                        child: pw.Image(pdfImage, fit: pw.BoxFit.cover),
                      ))
                  /*  pw.ClipRRect(
                  child: pw.Image(pdfImage,
                      width: 75, height: 100, fit: pw.BoxFit.contain),
                  horizontalRadius: 60,
                  verticalRadius: 60) */
                ]),
              ),

              pw.SizedBox(height: 10),
              pw.Divider(color: PdfColors.black, indent: 20, endIndent: 20),
              // General Information
              pw.SizedBox(height: 20),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 20),
                child: pw.Text('General Information',
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 22)),
              ),

              pw.SizedBox(height: 5),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 20),
                child: pw.Row(children: [
                  pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Father Name :'),
                        pw.SizedBox(
                          height: columnSpaceHeight,
                        ),
                        pw.Text('Mother Name :'),
                        pw.SizedBox(
                          height: columnSpaceHeight,
                        ),
                        pw.Text('Gender :'),
                        pw.SizedBox(
                          height: columnSpaceHeight,
                        ),
                        pw.Text('Date Of Birth :'),
                        pw.SizedBox(
                          height: columnSpaceHeight,
                        ),
                        pw.Text('Nationality :'),
                        pw.SizedBox(
                          height: columnSpaceHeight,
                        ),
                        pw.Text((hrmsEmployeeEditModel.idType == null)
                            ? "Id"
                            : hrmsEmployeeEditModel.idType.toString() + ' :'),
                        pw.SizedBox(
                          height: columnSpaceHeight,
                        ),
                        pw.Text('Present Address :'),
                        pw.SizedBox(
                          height: columnSpaceHeight,
                        ),
                        pw.Text('Permanent Address :'),
                      ]),
                  pw.SizedBox(
                    width: 20,
                  ),
                  pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text((hrmsEmployeeEditModel.employeeFather == null)
                            ? "Father"
                            : hrmsEmployeeEditModel.employeeFather.toString()),
                        pw.SizedBox(
                          height: columnSpaceHeight,
                        ),
                        pw.Text((hrmsEmployeeEditModel.employeeMother == null)
                            ? "Mother"
                            : hrmsEmployeeEditModel.employeeFather.toString()),
                        pw.SizedBox(
                          height: columnSpaceHeight,
                        ),
                        pw.Text((hrmsEmployeeEditModel.gender == null)
                            ? "Gender"
                            : hrmsEmployeeEditModel.gender.toString()),
                        pw.SizedBox(
                          height: columnSpaceHeight,
                        ),
                        pw.Text((hrmsEmployeeEditModel.dateOfBirth == null)
                            ? "BirthDate"
                            : hrmsEmployeeEditModel.dateOfBirth.toString()),
                        pw.SizedBox(
                          height: columnSpaceHeight,
                        ),
                        pw.Text((hrmsEmployeeEditModel.nationality == null)
                            ? "Bangladesh"
                            : hrmsEmployeeEditModel.nationality.toString()),
                        pw.SizedBox(
                          height: columnSpaceHeight,
                        ),
                        pw.Text((hrmsEmployeeEditModel.idNumber == null)
                            ? ""
                            : hrmsEmployeeEditModel.idNumber.toString()),
                        pw.Text((hrmsEmployeeEditModel.permanentAddress == null)
                            ? "permanent address"
                            : hrmsEmployeeEditModel.permanentAddress
                                .toString()),
                        pw.SizedBox(
                          height: columnSpaceHeight,
                        ),
                        pw.Text((hrmsEmployeeEditModel.presentAddress == null)
                            ? "present address"
                            : hrmsEmployeeEditModel.presentAddress.toString()),
                      ]),
                ]),
              ),

              // Education

              /* pw.SizedBox(height: 20),
            pw.Text('Education',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 5),
            pw.Row(children: [
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
                  ]),
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
                  ]),
            ]),
            pw.SizedBox(height: 20),
            pw.Text('Employee',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 5),
            pw.Row(children: [
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
                  ]),
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
                  ]),
            ]), */
              pw.Spacer(),
              pw.Container(
                color: PdfColors.red,
                width: double.infinity,
                height: 5, // Adjust border thickness as needed
                margin:
                    const pw.EdgeInsets.all(0.0), // Remove gap from right side
              ),
            ],
          );
        },
      ),
    );
    pdf.addPage(
      pw.Page(
        pageTheme: theme,
        //  theme: pw.ThemeData(defaultTextStyle: pw.TextStyle(fontSize: 18)),
        // pageFormat: PdfPageFormat.a4,
        build:
            (context) /* pw.Center(
          child: pw.Text(defaultText /* _textEditingController.text */,
              textScaleFactor: 2, style: pw.TextStyle(font: pw.Font.times())),
        ), */
            {
          return pw.Center(child: pw.Text("This page is intentionally blank"));
        },
      ),
    );
    /* pdf.addPage(
      pw.Page(
          build: (context) => pw.Table(
              border: pw.TableBorder.all(width: 1, color: PdfColors.black),
              children: List.generate(
                  4,
                  (index) => pw.TableRow(
                      children: List.generate(
                          4,
                          (ind) => pw.Text(data[index][ind],
                              textScaleFactor: 2,
                              textAlign: pw.TextAlign.center)))))
          /* pw.Container(
          child: pw.Text(defaultText1 /* _textEditingController.text */,
              textScaleFactor: 2, style: pw.TextStyle(font: pw.Font.times())),
        ), */
          ),
    ); */

    final output = await getDownloadsDirectory(); //
    //final Directory directory = Directory('hrms');

    print("pdf path before:${output?.path}");
    /* await directory.create(recursive: true);
    print("pdf path: file check done"); */
    final file = File("${output!.path}/example.pdf");

    //'${output?.path ?? "/hrms pdf"}/example.pdf'
    await file.writeAsBytes(await pdf.save());
    setState(() {
      _pdfPath = file.path;
      print("pdf path: $_pdfPath");
    });
  }

  @override
  void initState() {
    isInit = true;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var scSize = MediaQuery.of(context).size;
    EmployeeEditDataController employeeEditDataController =
        Provider.of<EmployeeEditDataController>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text('Text to PDF Converter'),
        ),
        body: (isInit)
            ? FutureBuilder(
                future: employeeEditDataController.getEmployeeCurrentInfo(
                    ApiLinks.employeeInfoLink, widget.id),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: AppVars.screenSize.height,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    if (!snapshot.hasData) {
                      return Container(
                        height: AppVars.screenSize.height,
                        child: const Center(
                          child: Text("No data available"),
                        ),
                      );
                    } else {
                      isInit = false;
                      _generatePdf(snapshot.data!);
                      return mainPdfForm(scSize);
                    }
                  }
                })
            : mainPdfForm(scSize));
  }

  Widget mainPdfForm(Size scSize) {
    return (_pdfPath == null)
        ? SizedBox.shrink()
        : PDFView(
            fitPolicy: FitPolicy.BOTH,
            filePath: _pdfPath,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: true,
            pageFling: true,
            pageSnap: false,
          );

    /* Container(
      height: scSize.height * 1,
      width: double.infinity,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (_pdfPath != null)
              Container(
                height: scSize.height * 1,
                //         color: Colors.red,
                width: double.infinity,
                child: PDFView(
                  fitPolicy: FitPolicy.BOTH,
                  filePath: _pdfPath,
                  enableSwipe: true,
                  swipeHorizontal: true,
                  autoSpacing: true,
                  pageFling: true,
                  pageSnap: false,
                ),
              ),
          ],
        ),
      ),
    ); */
  }
}
