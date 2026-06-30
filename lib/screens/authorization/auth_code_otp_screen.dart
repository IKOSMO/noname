import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noname/tools/router/app_router.gr.dart';

@RoutePage()
class AuthCodeOtpScreen extends StatefulWidget {
  const AuthCodeOtpScreen({super.key});

  @override
  State<AuthCodeOtpScreen> createState() => _AuthCodeOtpScreenState();
}

class _AuthCodeOtpScreenState extends State<AuthCodeOtpScreen> {
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
  // 6 контроллеров для 6 полей
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  // 6 FocusNode для управления фокусом
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  // Отслеживание фокуса для градиентной рамки
  bool _isFocused = false;
  String? _errorMessage;
  String? _clipboardCode; // Код из буфера обмена

  @override
  void initState() {
    super.initState();
    // Слушаем фокус на всех полях
    for (var focusNode in _focusNodes) {
      focusNode.addListener(_handleFocusChange);
    }

    // Автофокус на первое поле и проверка буфера
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
      _checkClipboard();
    });
  }

  // Проверка буфера обмена
  Future<void> _checkClipboard() async {
    try {
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      if (clipboardData?.text != null) {
        final text = clipboardData!.text!.trim();
        // Проверяем, что текст состоит только из цифр и длина 6
        if (RegExp(r'^[0-9]{6}$').hasMatch(text)) {
          setState(() {
            _clipboardCode = text;
          });
          // Показываем SnackBar с предложением вставить
          _showPasteSuggestion();
        }
      }
    } catch (e) {
      log('Ошибка проверки буфера: $e');
    }
  }

  // Показ SnackBar с предложением вставить код
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

  // Вставка кода из буфера
  void _pasteCode(String code) {
    for (int i = 0; i < 6; i++) {
      _controllers[i].text = code[i];
    }
    // Фокус на последнее поле
    _focusNodes[5].requestFocus();
    // Проверяем код
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

  // Обработка ввода в поле
  void _onChanged(String value, int index) {
    setState(() {
      _errorMessage = null; // Сбрасываем ошибку при вводе
    });

    if (value.isNotEmpty) {
      // Если введена цифра, переходим к следующему полю
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        // Если это последнее поле, проверяем код
        _verifyFullCode();
      }
    }
  }

  // Обработка удаления (backspace)
  void _onKeyEvent(KeyEvent event, int index) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      if (_controllers[index].text.isEmpty && index > 0) {
        // Если поле пустое и нажат backspace, переходим к предыдущему
        _focusNodes[index - 1].requestFocus();
        _controllers[index - 1].clear();
      }
    }
  }

  // Проверка полного кода
  void _verifyFullCode() {
    final code = _controllers.map((c) => c.text).join();
    if (code.length == 6) {
      _verifyCode(code);
    }
  }

  // Проверка кода
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
      context.router.push(AuthCloudPasswordRoute());
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
          // Градиентная рамка с OTP полями
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(6, (index) => _buildOtpField(index)),
          ),
          // Сообщение об ошибке
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

  // Построение одного OTP поля
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
