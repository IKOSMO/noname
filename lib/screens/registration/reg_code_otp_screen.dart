import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noname/tools/router/app_router.gr.dart';

@RoutePage()
class RegCodeOtpScreen extends StatefulWidget {
  const RegCodeOtpScreen({super.key});

  @override
  State<RegCodeOtpScreen> createState() => _RegCodeOtpScreenState();
}

class _RegCodeOtpScreenState extends State<RegCodeOtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: InkWell(
          onTap: () => context.router.pop(),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.only(left: 15, top: 20),
            child: SvgPicture.asset('assets/images/arrow_back.svg'),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShaderMask(
            shaderCallback: ((Rect bounds) {
              return const LinearGradient(
                colors: [
                  Color.fromARGB(255, 146, 228, 194),
                  Color.fromARGB(255, 182, 142, 226),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            }),
            child: Text(
              'noname'.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.15,
                fontFamily: 'Title',
              ),
            ),
          ),
          _OtpInput(),
          SizedBox(height: 120),
        ],
      ),
    );
  }
}

class _OtpInput extends StatefulWidget {
  const _OtpInput();

  @override
  State<_OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<_OtpInput> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  bool _isFocused = false;
  String? _errorMessage;
  String? _clipboardCode;
  @override
  void initState() {
    super.initState();
    for (var focusNode in _focusNodes) {
      focusNode.addListener(_handleFocusChange);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
      _checkClipboard();
    });
  }

  Future<void> _checkClipboard() async {
    try {
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      if (clipboardData?.text != null) {
        final text = clipboardData!.text!.trim();
        if (RegExp(r'^[0-9]{6}$').hasMatch(text)) {
          setState(() {
            _clipboardCode = text;
          });
          _showPasteSuggestion();
        }
      }
    } catch (e) {
      log('Ошибка проверки буфера: $e');
    }
  }

  void _showPasteSuggestion() {
    final snackBar = SnackBar(
      content: Text(
        'Обнаружен код в буфере обмена',
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(221, 43, 43, 43),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
        label: 'ВСТАВИТЬ',
        textColor: const Color.fromARGB(255, 146, 228, 194),
        onPressed: () {
          if (_clipboardCode != null) {
            _pasteCode(_clipboardCode!);
          }
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _pasteCode(String code) {
    for (int i = 0; i < 6; i++) {
      _controllers[i].text = code[i];
    }
    _focusNodes[5].requestFocus();
    _verifyCode(code);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNodes.any((node) => node.hasFocus);
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.removeListener(_handleFocusChange);
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    setState(() {
      _errorMessage = null;
    });

    if (value.isNotEmpty) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _verifyFullCode();
      }
    }
  }

  void _onKeyEvent(KeyEvent event, int index) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      if (_controllers[index].text.isEmpty && index > 0) {
        _focusNodes[index - 1].requestFocus();
        _controllers[index - 1].clear();
      }
    }
  }

  void _verifyFullCode() {
    final code = _controllers.map((c) => c.text).join();
    if (code.length == 6) {
      _verifyCode(code);
    }
  }

  void _verifyCode(String code) {
    if (code == '000000') {
      setState(() {
        _errorMessage = 'Неверный код';
      });
    } else {
      log('Код подтвержден: $code');
      setState(() {
        _errorMessage = null;
      });
      context.router.push(RegCloudPasswordRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Text(
              "Введите код подтверждения",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.03,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(94, 255, 255, 255),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(6, (index) => _buildOtpField(index)),
          ),
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 3),
              child: Text(
                _errorMessage!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOtpField(int index) {
    return Container(
      width: 40,
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 19, 19, 19),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _errorMessage != null
              ? Colors.red
              : Colors.grey.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (event) => _onKeyEvent(event, index),
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: '',
          ),
          onChanged: (value) => _onChanged(value, index),
        ),
      ),
    );
  }
}
