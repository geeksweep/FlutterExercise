import 'package:acmebank/Utils/acmetheme.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PDFViewer extends StatefulWidget {

const PDFViewer({super.key});

  @override
  PDFViewerState createState() => PDFViewerState();
}

class PDFViewerState extends State<PDFViewer> {
  late PdfControllerPinch pdfControllerPinch;

  @override
  void initState() {
    super.initState();
    pdfControllerPinch = PdfControllerPinch(
      document: PdfDocument.openAsset("assets/statementsample.pdf")
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Viewer"),
        backgroundColor: AcmeTheme.blueberry,
      ),
      body: Column(
        children: [
          Expanded(
            child: PdfViewPinch(controller: pdfControllerPinch)
            )
        ],
      ),
    );
  }

}
  
