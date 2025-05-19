import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


/// Represents Pdfpage for Navigation
class OpenPdfPage extends StatefulWidget {
  final pathfile;
  final action;
  const OpenPdfPage({super.key, required this.pathfile,required this.action});
  @override
  _OpenPdfPage createState() => _OpenPdfPage();
}

class _OpenPdfPage extends State<OpenPdfPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter PDF Viewer'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body:
      SfPdfViewer.network(widget.pathfile, key: _pdfViewerKey,),
    );
  }
}