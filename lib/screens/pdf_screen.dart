import 'package:flemingo_pdfreader/constants/size_configuration.dart';
import 'package:flemingo_pdfreader/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PDFscreen extends StatefulWidget {
  final String? path;
  final String fileName;

  const PDFscreen({
    super.key,
    this.path,
    required this.fileName,
  });

  @override
  State<PDFscreen> createState() => _PDFscreenState();
}

class _PDFscreenState extends State<PDFscreen> {
  late PdfControllerPinch pdfController;
  int _currentPage = 1;
  int _totalPages = 1;
  String? _error;

  @override
  void initState() {
    super.initState();
    loadController();
  }

  void loadController() async {
    try {
      pdfController = PdfControllerPinch(
        document: PdfDocument.openFile(widget.path!),
      );

      pdfController.addListener(() {
        setState(() {
          _currentPage = pdfController.page;
          _totalPages = pdfController.pagesCount ?? 1;
        });
      });
    } catch (error) {
      setState(() {
        _error = 'Error loading PDF: $error';
      });
    }
  }

  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black45,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.left_chevron,
            color: Colors.white,
          ),
        ),
        title: Text(
          widget.fileName,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                '$_currentPage / $_totalPages',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: SizeConfig.screenHeight,
        // Use SizeConfig for dynamic height
        width: SizeConfig.screenWidth,
        // Use SizeConfig for dynamic width
        padding: const EdgeInsets.only(top: 20),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/welcome_page.png"),
            colorFilter: ColorFilter.mode(
              Colors.black12,
              BlendMode.multiply,
            ),
          ),
        ),
        child: _error != null
            ? Center(
                child: Text(
                  _error!,
                  style: TextStyle(color: Colors.red, fontSize: Dimensions.font20),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: Center(
                      child: PdfViewPinch(
                        controller: pdfController,
                        scrollDirection: Axis.vertical,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
