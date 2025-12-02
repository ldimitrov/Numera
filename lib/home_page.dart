import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'logic/calculator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final Calculator _calculator = Calculator();
  final ScrollController _textScrollController = ScrollController();
  final ScrollController _resultScrollController = ScrollController();

  List<String?> _results = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);

    // Sync scrolling
    _textScrollController.addListener(() {
      if (_textScrollController.offset != _resultScrollController.offset) {
        _resultScrollController.jumpTo(_textScrollController.offset);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _textScrollController.dispose();
    _resultScrollController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _results = _calculator.processText(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine the number of lines to render.
    // We use the max of text lines or result lines to ensure alignment.
    // Actually, results length should match text lines length from processText.

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E), // Dark background
      body: SafeArea(
        child: Row(
          children: [
            // Input Area
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  top: 16.0,
                  bottom: 16.0,
                ),
                child: TextField(
                  controller: _controller,
                  scrollController: _textScrollController,
                  maxLines: null,
                  expands: true,
                  style: GoogleFonts.firaCode(
                    color: Colors.white,
                    fontSize: 18,
                    height: 1.5,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type math or unit conversions...',
                    hintStyle: TextStyle(color: Colors.white24),
                  ),
                  cursorColor: Colors.greenAccent,
                ),
              ),
            ),

            // Divider
            Container(width: 1, color: Colors.white10),

            // Results Area
            Expanded(
              flex: 1,
              child: Container(
                color: const Color(0xFF252526),
                child: ListView.builder(
                  controller: _resultScrollController,
                  physics:
                      const NeverScrollableScrollPhysics(), // Scroll via text field
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    bottom: 16.0,
                    right: 16.0,
                  ),
                  itemCount: _results.length,
                  itemBuilder: (context, index) {
                    final result = _results[index];
                    return SizedBox(
                      height: 18.0 * 1.5, // Match font size * height
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          result ?? '',
                          style: GoogleFonts.firaCode(
                            color: Colors.greenAccent,
                            fontSize: 18,
                            height: 1.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
