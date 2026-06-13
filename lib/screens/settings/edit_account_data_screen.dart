import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:variable_blur/variable_blur.dart';

@RoutePage()
class EditAccountDataScreen extends StatefulWidget {
  const EditAccountDataScreen({super.key});

  @override
  State<EditAccountDataScreen> createState() => _EditAccountDataScreenState();
}

// TickerProviderStateMixin нужен для создания Ticker, который будет
// управлять инерцией после отпускания пальца
class _EditAccountDataScreenState extends State<EditAccountDataScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late final Ticker _flingTicker;

  Simulation? _flingSimulation;
  double _lastSimPosition = 0;

  double _minOffsetTop = 0;
  double _maxOffsetTop = 0;
  double _minOffsetTopForUsername = 0;
  double _offsetTop = 0;
  double _offsetBlur = 0.4;
  double _usernameOffsetTop = 0;

  int _usernameDuration = 0;

  bool _isTop = false;
  bool _isTopUsername = false;

  @override
  void initState() {
    super.initState();
    _flingTicker = createTicker(_onFlingTick);
  }

  @override
  void dispose() {
    _stopFling();
    _flingTicker.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final double screenHeight = MediaQuery.of(context).size.height;

    _offsetTop = screenHeight * 0.5;
    _usernameOffsetTop = _offsetTop - 60;
    _minOffsetTop = 0;
    _minOffsetTopForUsername = screenHeight * 0.2;
    _maxOffsetTop = screenHeight * 0.5;
  }

  // --- Логика инерции (fling) ---

  void _stopFling() {
    if (_flingTicker.isActive) {
      _flingTicker.stop();
    }
    _flingSimulation = null;
  }

  void _onFlingTick(Duration elapsed) {
    if (_flingSimulation == null) return;

    final t = elapsed.inMilliseconds / 1000.0;
    final position = _flingSimulation!.x(t);
    final velocity = _flingSimulation!.dx(t);

    final delta = position - _lastSimPosition;
    _lastSimPosition = position;

    _applyDelta(delta);

    // Останавливаем, когда скорость близка к нулю или прошло много времени
    if (velocity.abs() < 1.0 || t > 5.0) {
      _stopFling();
    }
  }

  // --- Ядро логики скролла ---
  // Применяет delta к кастомному блоку ИЛИ к списку, в зависимости от текущего состояния
  void _applyDelta(double delta) {
    if (delta > 0) {
      // Свайп ВНИЗ: хотим видеть то, что ВЫШЕ
      if (_scrollController.hasClients && _scrollController.offset > 0) {
        // Список уже прокручен — прокручиваем его обратно к началу
        final available = _scrollController.offset;
        final used = delta.clamp(0.0, available);
        _scrollController.jumpTo(_scrollController.offset - used);
        final remaining = delta - used;
        if (remaining > 0) {
          // Список доскроллился до верха, теперь опускаем кастомный блок
          _offsetTop = (_offsetTop + remaining).clamp(
            _minOffsetTop,
            _maxOffsetTop,
          );
          _updateOffsetDependencies();
        }
      } else {
        // Список в начале — просто опускаем кастомный блок
        _offsetTop = (_offsetTop + delta).clamp(_minOffsetTop, _maxOffsetTop);
        _updateOffsetDependencies();
      }
    } else {
      // Свайп ВВЕРХ: хотим видеть то, что НИЖЕ
      final absDelta = -delta;
      if (_offsetTop > _minOffsetTop) {
        // Есть куда поднимать кастомный блок — поднимаем его
        final available = _offsetTop - _minOffsetTop;
        final used = absDelta.clamp(0.0, available);
        _offsetTop -= used;
        _updateOffsetDependencies();
        final remaining = absDelta - used;
        if (remaining > 0 && _scrollController.hasClients) {
          // Блок полностью поднят — передаём остаток в список
          final maxScroll = _scrollController.position.maxScrollExtent;
          final newScroll = (_scrollController.offset + remaining).clamp(
            0.0,
            maxScroll,
          );
          _scrollController.jumpTo(newScroll);
        }
      } else {
        // Блок уже наверху — скроллим только список
        if (_scrollController.hasClients) {
          final maxScroll = _scrollController.position.maxScrollExtent;
          final newScroll = (_scrollController.offset + absDelta).clamp(
            0.0,
            maxScroll,
          );
          _scrollController.jumpTo(newScroll);
        }
      }
    }

    // Остановка fling при достижении обеих границ
    if (_flingTicker.isActive) {
      final atOffsetBottom = _offsetTop >= _maxOffsetTop;
      final atOffsetTop = _offsetTop <= _minOffsetTop;
      final atScrollStart =
          !_scrollController.hasClients || _scrollController.offset <= 0;
      final atScrollEnd =
          _scrollController.hasClients &&
          _scrollController.offset >=
              _scrollController.position.maxScrollExtent;

      if ((delta > 0 && atOffsetBottom && atScrollStart) ||
          (delta < 0 && atOffsetTop && atScrollEnd)) {
        _stopFling();
        return;
      }
    }

    _updateUsernameState();
    setState(() {});
  }

  void _updateOffsetDependencies() {
    _usernameOffsetTop = _offsetTop - 60;
    _updateBlur();
  }

  void _updateBlur() {
    if (_offsetTop <= _minOffsetTop) {
      _offsetBlur = 1.0;
    } else if (_offsetTop >= _maxOffsetTop) {
      _offsetBlur = 0.4;
    } else {
      final progress =
          (_maxOffsetTop - _offsetTop) / (_maxOffsetTop - _minOffsetTop);
      _offsetBlur = 0.4 + (0.6 * progress);
    }
  }

  void _updateUsernameState() {
    final isTopUsername = _offsetTop < _minOffsetTopForUsername;
    int usernameDuration = 0;
    double usernameOffsetTop = _usernameOffsetTop;

    if (isTopUsername) {
      usernameDuration = 200;
      usernameOffsetTop = MediaQuery.of(context).padding.top + 25;
    } else {
      usernameDuration = 0;
      usernameOffsetTop = _offsetTop - 60;
    }

    _isTopUsername = isTopUsername;
    _usernameDuration = usernameDuration;
    _usernameOffsetTop = usernameOffsetTop;
    _isTop = _offsetTop <= _minOffsetTop;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: VariableBlur(
                sigma: 14.0,
                blurSides: BlurSides.vertical(top: 0.0, bottom: _offsetBlur),
                quality: BlurQuality.high,
                isYFlipNeed: true,
                child: Image.asset(
                  'assets/images/person.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 0),
              top: _offsetTop,
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildBody(),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 15,
              right: 15,
              left: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => context.router.pop(),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(100, 0, 0, 0),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        'assets/images/arrow_back.svg',
                        height: 40,
                      ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(100, 0, 0, 0),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        'Изм.',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: _usernameDuration),
              top: _usernameOffsetTop,
              left: 0,
              right: 0,
              child: _buildMenu(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return GestureDetector(
      // При новом касании прерываем текущую инерцию
      onPanDown: (_) => _stopFling(),
      onPanUpdate: (details) {
        _applyDelta(details.delta.dy);
      },
      onPanEnd: (details) {
        final velocity = details.velocity.pixelsPerSecond.dy;
        // Запускаем инерцию только если скорость достаточно велика
        if (velocity.abs() < 10) return;

        // 0.135 — стандартный коэффициент трения Flutter
        _flingSimulation = FrictionSimulation(0.135, 0.0, velocity);
        _lastSimPosition = 0.0;
        _flingTicker.start();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: double.infinity,
        color: Colors.black,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const NeverScrollableScrollPhysics(),
          child: Column(children: List.generate(20, (_) => _button())),
        ),
      ),
    );
  }

  Widget _buildMenu() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Алексей Грумцин',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.width * 0.065,
                        height: 1,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: _isTopUsername
                          ? TextAlign.center
                          : TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: SizedBox(
              height: _isTopUsername ? 0.0 : null,
              child: AnimatedOpacity(
                opacity: _isTopUsername ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: IgnorePointer(
                  ignoring: _isTopUsername,
                  child: Text(
                    '+7 (996) 445 2928',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _button() {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      width: MediaQuery.of(context).size.width - 30,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color.fromARGB(255, 34, 34, 34),
      ),
      child: const Row(),
    );
  }
}
