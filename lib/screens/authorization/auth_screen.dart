import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:noname/tools/router/app_router.gr.dart';

@RoutePage()
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FocusNode _phoneFocusNode = FocusNode();
  final TextEditingController _phoneController = TextEditingController();
  final MaskTextInputFormatter _phoneFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  String? _phoneError;
  bool _isLoading = false;

  static const int _expectedDigitsCount = 10;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_clearErrorOnChange);
  }

  @override
  void dispose() {
    _phoneController.removeListener(_clearErrorOnChange);
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  void _clearErrorOnChange() {
    if (_phoneError != null) {
      setState(() => _phoneError = null);
    }
  }

  bool _validatePhoneFormat() {
    final rawPhone = _phoneFormatter.getUnmaskedText();

    if (rawPhone.length < _expectedDigitsCount || rawPhone.isEmpty) {
      setState(() => _phoneError = 'Номер телефона введён не полностью');
      return false;
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(rawPhone)) {
      setState(() => _phoneError = 'Номер должен содержать только цифры');
      return false;
    }

    setState(() => _phoneError = null);
    return true;
  }

  Future<bool> _checkPhoneExists(String fullPhone) async {
    await Future.delayed(const Duration(seconds: 1));
    return fullPhone == '+79994443825';
  }

  Future<void> _login() async {
    _phoneFocusNode.unfocus();

    if (!_validatePhoneFormat()) return;

    setState(() => _isLoading = true);

    try {
      final rawPhone = _phoneFormatter.getUnmaskedText();
      final fullPhone = '+7$rawPhone';
      final exists = await _checkPhoneExists(fullPhone);

      if (!exists) {
        if (!mounted) return;
        setState(() => _phoneError = 'Номер телефона не найден');
        return;
      }

      if (!mounted) return;
      context.router.push(AuthCodeOtpRoute());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actionsPadding: EdgeInsetsGeometry.only(right: 25, top: 15),
        actions: [
          if (_isLoading) ...[
            CircularProgressIndicator(
              color: Color.fromARGB(255, 182, 142, 226),
            ),
          ],
        ],
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
          _GradientPhoneInput(
            focusNode: _phoneFocusNode,
            controller: _phoneController,
            formatter: _phoneFormatter,
            errorMessage: _phoneError,
          ),
          const SizedBox(height: 20),
          _LoginButton(
            isLoading: _isLoading,
            onPressed: _isLoading ? null : _login,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Нет аккаунта?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () => context.router.push(RegistrationRoute()),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: ShaderMask(
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
                    'Зарегистрироваться',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GradientPhoneInput extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final MaskTextInputFormatter formatter;
  final String? errorMessage;

  const _GradientPhoneInput({
    required this.focusNode,
    required this.controller,
    required this.formatter,
    this.errorMessage,
  });

  @override
  State<_GradientPhoneInput> createState() => _GradientPhoneInputState();
}

class _GradientPhoneInputState extends State<_GradientPhoneInput> {
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(covariant _GradientPhoneInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      oldWidget.focusNode.removeListener(_onFocusChange);
      widget.focusNode.addListener(_onFocusChange);
      _isFocused = widget.focusNode.hasFocus;
    }
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    setState(() => _isFocused = widget.focusNode.hasFocus);
  }

  bool get _hasError => widget.errorMessage != null;

  @override
  Widget build(BuildContext context) {
    final Gradient? borderGradient = _hasError
        ? const LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 0, 0),
              Color.fromARGB(255, 255, 0, 0),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : (_isFocused
              ? const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 146, 228, 194),
                    Color.fromARGB(255, 182, 142, 226),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null);

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Text(
              'Введи номер телефона',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.03,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(94, 255, 255, 255),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              gradient: borderGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(2),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(221, 43, 43, 43),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                focusNode: widget.focusNode,
                controller: widget.controller,
                keyboardType: TextInputType.phone,
                inputFormatters: [widget.formatter],
                decoration: const InputDecoration(
                  hintText: '+7 (999) 444 38 25',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(height: 20),
            secondChild: Padding(
              padding: const EdgeInsets.only(left: 3, top: 6),
              child: Text(
                widget.errorMessage ?? '',
                style: const TextStyle(
                  color: Color.fromARGB(255, 220, 70, 70),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            crossFadeState: _hasError
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;

  const _LoginButton({required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Opacity(
        opacity: onPressed == null ? 0.6 : 1.0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 146, 228, 194),
                Color.fromARGB(255, 182, 142, 226),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            'Войти',
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.04,
            ),
          ),
        ),
      ),
    );
  }
}
