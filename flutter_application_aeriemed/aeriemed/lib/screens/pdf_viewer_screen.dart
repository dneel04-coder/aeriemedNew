import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../models/protocol.dart';

class PdfViewerScreen extends StatelessWidget {
  final Protocol protocol;
  const PdfViewerScreen({super.key, required this.protocol});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(protocol.title)),
      body: PDFView(
        filePath: protocol.filePath,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: true,
        pageFling: true,
        pageSnap: true,
        defaultPage: 0,
        fitPolicy: FitPolicy.BOTH,
        preventOverflow: true,
      ),
    );
  }
}