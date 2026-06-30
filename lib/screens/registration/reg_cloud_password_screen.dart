import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noname/tools/router/app_router.gr.dart';

@RoutePage()
class RegCloudPasswordScreen extends StatefulWidget {
  const RegCloudPasswordScreen({super.key});

  @override
  State<RegCloudPasswordScreen> createState() => _RegCloudPasswordScreenState();
}

class _RegCloudPasswordScreenState extends State<RegCloudPasswordScreen> {
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
          _GradientUsernameInput(),
          SizedBox(height: 20),
          _GradientPasswordInput(),
          SizedBox(height: 20),
          InkWell(
            onTap: () => context.router.push(HomeRoute()),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
              decoration: BoxDecoration(
                gradient: LinearGradient(
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
                'Зарегистрироваться',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _GradientPasswordInput extends StatefulWidget {
  const _GradientPasswordInput();

  @override
  _GradientPasswordInputState createState() => _GradientPasswordInputState();
}

class _GradientPasswordInputState extends State<_GradientPasswordInput> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 3),
            child: Text(
              "Придумай облачный пароль",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.03,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(94, 255, 255, 255),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              gradient: _isFocused
                  ? const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 146, 228, 194),
                        Color.fromARGB(255, 182, 142, 226),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: _isFocused ? null : Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(2),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(221, 43, 43, 43),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                focusNode: _focusNode,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "********",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientUsernameInput extends StatefulWidget {
  const _GradientUsernameInput();

  @override
  _GradientUsernameInputState createState() => _GradientUsernameInputState();
}

class _GradientUsernameInputState extends State<_GradientUsernameInput> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 3),
            child: Text(
              "Придумай уникальное имя",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.03,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(94, 255, 255, 255),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              gradient: _isFocused
                  ? const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 146, 228, 194),
                        Color.fromARGB(255, 182, 142, 226),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: _isFocused ? null : Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(2),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(221, 43, 43, 43),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                focusNode: _focusNode,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "@username12343",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
