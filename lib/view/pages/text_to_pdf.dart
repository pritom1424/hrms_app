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
import 'package:hrms_app/utils/app_variables/user_credential.dart';
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
  final pdf = pw.Document();
  final theme = pw.PageTheme(
    margin: pw.EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    theme: pw.ThemeData(
        defaultTextStyle: pw.TextStyle(fontSize: 18),
        paragraphStyle: pw.TextStyle(fontSize: 15)),
    pageFormat: PdfPageFormat.a4,
    buildBackground: (pw.Context context) {
      return pw.Container(
        width: PdfPageFormat.a4.width,
        height: PdfPageFormat.a4.height,
        color: PdfColor.fromInt(0xFFE2E1E1),
      );
    },
  );
  String imgPlaceHolder = "assets/images/propic_placeholder.png";
  final TextEditingController _textEditingController = TextEditingController();
  bool isLoading = false;
  String? _pdfPath;
  bool isInit = false;
  bool _isPDFCreated = false;

  List<String> currentPageContent = [];
  double currentPageHeight = 0;
  Future<Uint8List> _getImageBytes(String imagePath) async {
    final ByteData data = await rootBundle.load(imagePath);
    return data.buffer.asUint8List();
  }

  Future<void> _generatePdf(HrmsEmployeeEditModel hrmsEmployeeEditModel) async {
    final pw.MemoryImage pdfImage;
    double columnSpaceHeight = 5;

    if (_isPDFCreated) {
      return;
    }

    _isPDFCreated = true;

    FocusScope.of(context).unfocus();

    Dio dio = Dio();
    if (hrmsEmployeeEditModel.image != null) {
      final imageResponse = await dio.get(
          "https://hrms.szamantech.com/storage/employee/${hrmsEmployeeEditModel.image}",
          options: Options(responseType: ResponseType.bytes, headers: {
            'Authorization': 'Bearer ${UserCredential.usertoken}'
          }));

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
          return pw.Container(
              child: pw.Column(
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
                      ]),
                ]),
              ),
              pw.SizedBox(height: 5),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 20),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                        width: PdfPageFormat.a4.width * 0.2,
                        child: pw.Text('Present Address :')),
                    pw.SizedBox(
                      width: 20,
                    ),
                    pw.Container(
                        width: PdfPageFormat.a4.width * 0.3,
                        child: pw.Text(
                            (hrmsEmployeeEditModel.presentAddress == null)
                                ? "present address"
                                : hrmsEmployeeEditModel.presentAddress
                                    .toString(),
                            maxLines: 3,
                            overflow: pw.TextOverflow.clip,
                            softWrap: true)),
                  ],
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 20),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                        width: PdfPageFormat.a4.width * 0.2,
                        child: pw.Text('Permanent Address :')),
                    pw.SizedBox(
                      width: 20,
                    ),
                    pw.Container(
                        width: PdfPageFormat.a4.width * 0.3,
                        child: pw.Text(
                            (hrmsEmployeeEditModel.permanentAddress == null)
                                ? "permanent address"
                                : hrmsEmployeeEditModel.permanentAddress
                                    .toString(),
                            maxLines: 3,
                            overflow: pw.TextOverflow.clip,
                            softWrap: true)),
                  ],
                ),
              ),
              if (hrmsEmployeeEditModel.education.isNotEmpty)
                pw.SizedBox(height: 20),
              if (hrmsEmployeeEditModel.education.isNotEmpty)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 20),
                  child: pw.Text('Educational Information',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 22)),
                ),
              if (hrmsEmployeeEditModel.education.isNotEmpty)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 20),
                  child: pw.Row(children: [
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: List.generate(
                          hrmsEmployeeEditModel.education.length,
                          (index) => pw.Text(
                              '${hrmsEmployeeEditModel.education[index].instituteName} (${hrmsEmployeeEditModel.education[index].educationType}) :'),
                        )),
                    if (hrmsEmployeeEditModel.education.isNotEmpty)
                      pw.SizedBox(
                        width: 20,
                      ),
                    if (hrmsEmployeeEditModel.education.isNotEmpty)
                      pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: List.generate(
                            hrmsEmployeeEditModel.education.length,
                            (index) => pw.Text((hrmsEmployeeEditModel
                                        .education[index].cgpa ==
                                    null)
                                ? hrmsEmployeeEditModel.education[index].gpa ??
                                    ""
                                : hrmsEmployeeEditModel.education[index].cgpa ??
                                    ""),
                          )),
                  ]),
                ),
              if (hrmsEmployeeEditModel.experience.isNotEmpty)
                pw.SizedBox(height: 20),
              if (hrmsEmployeeEditModel.experience.isNotEmpty)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 20),
                  child: pw.Text('Experience Information',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 22)),
                ),
              if (hrmsEmployeeEditModel.experience.isNotEmpty)
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 20),
                  child: pw.Row(children: [
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: List.generate(
                          hrmsEmployeeEditModel.experience.length,
                          (index) => pw.Text(
                              '${hrmsEmployeeEditModel.experience[index].previousWorkplace} :'),
                        )),
                    if (hrmsEmployeeEditModel.experience.isNotEmpty)
                      pw.SizedBox(
                        width: 20,
                      ),
                    if (hrmsEmployeeEditModel.experience.isNotEmpty)
                      pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: List.generate(
                            hrmsEmployeeEditModel.experience.length,
                            (index) => pw.Text(durationDateinString(
                                hrmsEmployeeEditModel
                                    .experience[index].startDate,
                                hrmsEmployeeEditModel
                                    .experience[index].endDate)),
                          )),
                  ]),
                ),
              if (hrmsEmployeeEditModel.experience.isNotEmpty)
                pw.SizedBox(height: 20),

              pw.Spacer(),
              pw.Container(
                color: PdfColors.red,
                width: double.infinity,
                height: 5, // Adjust border thickness as needed
                margin:
                    const pw.EdgeInsets.all(0.0), // Remove gap from right side
              ),
            ],
          ));
        },
      ),
    );

    final output = await getDownloadsDirectory(); //

    final file =
        File("${output!.path}/${hrmsEmployeeEditModel.employeeName}_CV.pdf");

    await file.writeAsBytes(await pdf.save());
    setState(() {
      _pdfPath = file.path;
    });
  }

  String durationDateinString(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) {
      return "";
    }

    final difference = endDate.difference(startDate);

    int years = difference.inDays ~/ 365;
    int months = (difference.inDays % 365) ~/ 30;
    int days = difference.inDays % 30;
    return '$years Year, $months Month${months != 1 ? 's' : ''}, $days Day${days != 1 ? 's' : ''}';
  }

  // Function to add a new page with specified content
  void addPageWithContent(List<String> content) {
    pdf.addPage(
      pw.Page(
        pageTheme: theme,
        build: (context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: content
                .map((text) => pw.Container(
                      margin: const pw.EdgeInsets.symmetric(vertical: 5),
                      child: pw.Text(text),
                    ))
                .toList(),
          );
        },
      ),
    );
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
