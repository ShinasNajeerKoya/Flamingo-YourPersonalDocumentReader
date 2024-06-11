import 'package:file_picker/file_picker.dart';
import 'package:flemingo_pdfreader/constants/error_enum.dart';
import 'package:flemingo_pdfreader/screens/pdf_screen.dart';
import 'package:flemingo_pdfreader/utils/dimensions.dart';
import 'package:flemingo_pdfreader/widgets/error_screen.dart';
import 'package:flemingo_pdfreader/widgets/file_opener_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as path;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<String> recentPDFs = [];
  FilePickerResult? filePickerResult;

  Future<void> _openFile(List<String> allowedExtensions) async {
    try {
      filePickerResult = await FilePicker.platform.pickFiles(
        allowedExtensions: allowedExtensions,
        type: FileType.custom,
      );

      if (filePickerResult != null) {
        var filePath = filePickerResult!.files.single.path;
        var fileName = filePickerResult!.files.single.name;

        if (filePath != null && fileName.endsWith('.pdf')) {
          setState(() {
            recentPDFs.insert(0, filePath);
          });

          if (!mounted) return;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PDFscreen(
                path: filePath,
                fileName: fileName,
              ),
            ),
          );
        } else {
          throw PlatformException(
            code: 'INVALID_FORMAT',
            message: 'Selected file is not a PDF.',
          );
        }
      }
    } catch (e) {
      if (e is PlatformException) {
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ErrorScreen(
              errorType: ErrorType.notFound404,
            ),
          ),
        );
      } else {
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ErrorScreen(
              errorType: ErrorType.noInternet,
            ),
          ),
        );
      }
    }
  }

  void _openPDF(String filePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFscreen(
          path: filePath,
          fileName: path.basename(filePath),
        ),
      ),
    );
  }

  String _getLastThreeParts(String filePath) {
    List<String> parts = path.split(filePath);
    if (parts.length <= 3) {
      return filePath;
    }
    return path.join(parts[parts.length - 3], parts[parts.length - 2], parts[parts.length - 1]);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: const AssetImage("assets/images/welcome_page.png"),
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.6),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.poppins(
                    color: Colors.brown.shade800,
                    fontSize: 34,
                  ),
                  children: [
                    const TextSpan(text: "What are you \nreading "),
                    TextSpan(
                      text: "next?",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              height: Dimensions.imageHeight400,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      _openPDF(recentPDFs[index]);
                    },
                    leading: Image.asset("assets/images/pdf.png"),
                    title: Text(path.basename(recentPDFs[index])),
                    subtitle: Text(
                      _getLastThreeParts(recentPDFs[index]),
                      style: const TextStyle(fontSize: 13),
                      // overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          recentPDFs.removeAt(index);
                        });
                      },
                      icon: const Icon(Icons.cancel_outlined),
                    ),
                  );
                },
                itemCount: recentPDFs.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.brown.shade700,
                ),
              ),
            ),
            Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FileOpenerButton(
                    size: size,
                    image: "assets/images/doc.png",
                    title: "Open Word File",
                    onPressed: () async {
                      _openFile(['doc']);
                    },
                  ),
                  FileOpenerButton(
                    size: size,
                    image: "assets/images/pdf.png",
                    title: "Open PDF File",
                    onPressed: () async {
                      _openFile(['pdf']);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
