import 'dart:io';
//import 'package:alh_pdf_view/alh_pdf_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class TextToPdfConverter extends StatefulWidget {
  @override
  State<TextToPdfConverter> createState() => _TextToPdfConverterState();
}

class _TextToPdfConverterState extends State<TextToPdfConverter> {
  final TextEditingController _textEditingController = TextEditingController();
  bool isLoading = false;
  String? _pdfPath;
  String defaultText1 = "second page";
  String defaultText = '''Foreign airlines’ 323m stuck in Bangladesh
Says IATA; experts blame it on high ticket prices
Photo: Pixabay
The amount of foreign airlines' money stuck in Bangladesh has increased to 323 million from 214 million in less than a year, according to the International Air Transport Association (IATA).
The IATA, which represents 320 airlines responsible for 83 percent of the global air traffic, yesterday also said Pakistan was withholding 399 million from foreign carriers.
For all latest news, follow The Daily Star's Google News channel.
It called on the two countries to immediately release the funds that have been blocked in contravention of international agreements.
"The situation has become severe with airlines unable to repatriate over 720 million [399 million in Pakistan and 323 million in Bangladesh] of revenues earned in these markets," the IATA said.
It also said that the timely repatriation of revenues to their countries is critical for payment of dollar-denominated expenses such as lease agreements, spare parts, overflight fees, and fuel.
About Bangladesh, the IATA said the country has more standardised processes, but aviation needs a higher priority from the central bank to facilitate access to foreign exchange.''';

  List<List<String>> data = [
    ["ID", "Name", "Employee Code", "Gender"],
    ["1", "Tanay Syed", "007", "Male"],
    ["2", "Bkash Nahid", "008", "Male"],
    ["3", "Saklain", "009", "Male"],
  ];

  Future<void> _generatePdf() async {
    final pdf = pw.Document();
    FocusScope.of(context).unfocus();
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Center(
          child: pw.Text(defaultText /* _textEditingController.text */,
              textScaleFactor: 2, style: pw.TextStyle(font: pw.Font.times())),
        ),
      ),
    );
    pdf.addPage(
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
    );

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
  Widget build(BuildContext context) {
    var scSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Text to PDF Converter'),
      ),
      body: Container(
        height: scSize.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              /* Container(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _textEditingController,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Enter your text...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ), */
              ElevatedButton(
                onPressed: _generatePdf,
                child: Text('Generate PDF'),
              ),
              if (_pdfPath != null)
                Container(
                  height: scSize.height * 1,
                  //color: Colors.red,
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
      ),
    );
  }
}
