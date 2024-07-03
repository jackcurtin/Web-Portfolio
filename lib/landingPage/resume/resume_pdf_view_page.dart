import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class ResumePDFViewPage extends StatefulWidget {
  const ResumePDFViewPage({super.key});

  @override
  State<ResumePDFViewPage> createState() => _ResumePDFViewPageState();
}

class _ResumePDFViewPageState extends State<ResumePDFViewPage> {
  final pdfController = PdfController(
    document: PdfDocument.openAsset('cv.pdf'));
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Center(
        child: PdfView(
          controller: pdfController,
        )
      ),
    );
  }
}