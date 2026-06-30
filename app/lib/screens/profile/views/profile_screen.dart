import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:core/l10n/app_localizations.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  double _minOffsetTop = 0;
  double _maxOffsetTop = 0;
  double _maxOffsetTabBar = 0;
  double _minOffsetTabBar = 0;

  double _offsetTop = 0;
  double _offsetTabBar = 0;
  double _offsetTabBarView = 0;
  double _offsetBlur = 0.4;
  double _scaleAccountInformation = 1;

  int _durationAccountInformation = 0;

  bool _accountInformationIsHidden = false;
  bool _menuIsHidden = false;
  bool _isTopForUsername = false;

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final double screenHeight = MediaQuery.of(context).size.height;

    _offsetTop = screenHeight * 0.5;
    _minOffsetTop = screenHeight * 0.21;
    _maxOffsetTop = screenHeight * 0.5;
    _maxOffsetTabBar = -screenHeight * 0.15;
    _minOffsetTabBar = 0;
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Image.asset('assets/images/person.png', fit: BoxFit.cover),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 0),
              top: _offsetTop - (_menuIsHidden ? 60 : 125),
              left: 0,
              right: 0,
              child: _buildMenu(),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 0),
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
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        // gradient: const LinearGradient(
                        //   colors: [
                        //     Color.fromARGB(120, 146, 228, 194),
                        //     Color.fromARGB(120, 182, 142, 226),
                        //   ],
                        //   begin: Alignment.topLeft,
                        //   end: Alignment.bottomRight,
                        // ),
                        color: const Color.fromARGB(100, 0, 0, 0),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        'assets/images/arrow_back.svg',
                        height: 40,
                      ),
                    ),
                  ),
                  InkWell(
                    // onTap: () => context.router.pop(),
                    child: Container(
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        // gradient: const LinearGradient(
                        //   colors: [
                        //     Color.fromARGB(120, 146, 228, 194),
                        //     Color.fromARGB(120, 182, 142, 226),
                        //   ],
                        //   begin: Alignment.topLeft,
                        //   end: Alignment.bottomRight,
                        // ),
                        color: const Color.fromARGB(100, 0, 0, 0),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        t.profile_edit,
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
          ],
        ),
      ),
    );
  }

  Widget _buttonMenu({
    required String text,
    required IconData icon,
    required double iconSize,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        margin: EdgeInsets.only(),
        decoration: BoxDecoration(
          color: const Color.fromARGB(71, 0, 0, 0),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: iconSize),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: MediaQuery.of(context).size.width * 0.03,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return GestureDetector(
      onPanUpdate: (details) {
        double newOffsetTop = _offsetTop + details.delta.dy;

        bool isTop = newOffsetTop < _minOffsetTop;
        bool isBottom = newOffsetTop > _maxOffsetTop;
        bool isTopForUsername = newOffsetTop < _minOffsetTop + 50;

        double newOffsetTabBar = _offsetTabBar;
        double newOffsetTabBarView = _offsetTabBarView;
        double newScaleAccount = _scaleAccountInformation;
        bool newIsHidden = _accountInformationIsHidden;
        bool newMenuIsHidden = _menuIsHidden;
        int newDuration = _durationAccountInformation;

        if (newOffsetTop < _minOffsetTop) {
          newOffsetTop = _minOffsetTop;
        } else if (newOffsetTop > _maxOffsetTop) {
          newOffsetTop = _maxOffsetTop;
        }

        if (isTop) {
          newOffsetTabBar = _offsetTabBar + (details.delta.dy / 5);

          if (newOffsetTabBar > _minOffsetTabBar) {
            newOffsetTabBar = _minOffsetTabBar;
          }

          if (newOffsetTabBar < _maxOffsetTabBar) {
            newOffsetTabBar = _maxOffsetTabBar;
          }

          if (newOffsetTabBar < -10) {
            newDuration = 200;
            newOffsetTabBar = _maxOffsetTabBar;
            newScaleAccount = 0.0;
            newIsHidden = true;
          } else {
            newIsHidden = false;
            newScaleAccount =
                ((_maxOffsetTabBar - newOffsetTabBar / 5) /
                        (_maxOffsetTabBar - 0))
                    .clamp(0.0, 1.0);
          }

          newOffsetTabBarView = newOffsetTabBar;
        } else {
          newOffsetTabBar = _minOffsetTabBar;
          newOffsetTabBarView = newOffsetTabBar;
          newScaleAccount = 1.0;
          newIsHidden = false;
        }

        double newOffsetBlur = _offsetBlur;
        if (!isTop && !isBottom) {
          double progress =
              (_maxOffsetTop - newOffsetTop) / (_maxOffsetTop - _minOffsetTop);
          newOffsetBlur = 0.4 + (0.6 * progress);
        }

        setState(() {
          _offsetTop = newOffsetTop;
          _offsetTabBar = newOffsetTabBar;
          _offsetTabBarView = newOffsetTabBarView;
          _scaleAccountInformation = newScaleAccount;
          _accountInformationIsHidden = newIsHidden;
          _durationAccountInformation = newDuration;
          _offsetBlur = newOffsetBlur;
          _isTopForUsername = isTopForUsername;
          _menuIsHidden = newMenuIsHidden;
        });
      },
      onPanEnd: (details) {},
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: Duration(
                      milliseconds: _durationAccountInformation,
                    ),
                    top: _offsetTabBar,
                    left: 0,
                    right: 0,
                    child: AnimatedScale(
                      scale: _scaleAccountInformation,
                      duration: Duration(
                        milliseconds: _durationAccountInformation,
                      ),
                      child: _buildAccountInformation(),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(
                      milliseconds: _durationAccountInformation,
                    ),
                    top:
                        _offsetTabBarView +
                        (_offsetTabBarView ==
                                -MediaQuery.of(context).size.height * 0.15
                            ? 120
                            : 160),
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: _buildTabBar(),
                        ),
                        Expanded(child: _buildTabBarView()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenu() {
    final t = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: _isTopForUsername
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          AnimatedSize(
            duration: Duration(milliseconds: 200),
            child: SizedBox(
              width:
                  MediaQuery.of(context).size.width *
                  (_isTopForUsername ? 0.4 : 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Алексей Грумцин',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize:
                            MediaQuery.of(context).size.width *
                            (_isTopForUsername ? 0.045 : 0.065),
                        height: 1,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: _isTopForUsername
                          ? TextAlign.center
                          : TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            'был(а) недавно',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: MediaQuery.of(context).size.width * 0.035,
              height: 1.2,
            ),
          ),
          SizedBox(height: 15),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: SizedBox(
              height: _menuIsHidden ? 0.0 : null,
              child: AnimatedOpacity(
                opacity: _menuIsHidden ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: IgnorePointer(
                  ignoring: _menuIsHidden,
                  child: Row(
                    children: [
                      Expanded(
                        child: _buttonMenu(
                          text: t.call.toLowerCase(),
                          icon: Icons.call,
                          onTap: () {},
                          iconSize: 25,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: _buttonMenu(
                          text: t.video_call.toLowerCase(),
                          icon: Icons.videocam,
                          onTap: () {},
                          iconSize: 25,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: _buttonMenu(
                          text: t.profile_volume.toLowerCase(),
                          icon: Icons.notifications,
                          onTap: () {},
                          iconSize: 25,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: _buttonMenu(
                          text: t.search.toLowerCase(),
                          icon: Icons.search,
                          onTap: () {},
                          iconSize: 25,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: _buttonMenu(
                          text: t.more.toLowerCase(),
                          icon: Icons.more_horiz,
                          onTap: () {},
                          iconSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountInformation() {
    final t = AppLocalizations.of(context)!;

    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      width: MediaQuery.of(context).size.width - 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color.fromARGB(255, 34, 34, 34),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            t.profile_phone_number,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: MediaQuery.of(context).size.width * 0.025,
            ),
          ),
          Text(
            '+7 963 849 1045',
            style: TextStyle(color: const Color.fromARGB(255, 182, 142, 226)),
          ),
          Divider(color: const Color.fromARGB(20, 255, 255, 255)),
          Text(
            t.username,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: MediaQuery.of(context).size.width * 0.025,
            ),
          ),
          Text(
            '@alekse',
            style: TextStyle(color: const Color.fromARGB(255, 182, 142, 226)),
          ),
          Divider(color: const Color.fromARGB(20, 255, 255, 255)),
          Text(
            t.date_of_birthday,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: MediaQuery.of(context).size.width * 0.025,
            ),
          ),
          Text(
            '25 апреля',
            style: TextStyle(color: const Color.fromARGB(255, 182, 142, 226)),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildTabBar() {
    final t = AppLocalizations.of(context)!;

    return TabBar(
      controller: _tabController,
      tabs: [
        Tab(text: t.media),
        Tab(text: t.files),
        Tab(text: t.music),
        Tab(text: t.voice_message),
        Tab(text: t.links),
        Tab(text: t.gif),
        Tab(text: t.groups),
      ],
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Colors.transparent, width: 0.0),
      ),
      labelStyle: TextStyle(
        color: Colors.white,
        fontSize: MediaQuery.of(context).size.width / 25,
        fontWeight: FontWeight.w800,
      ),
      labelPadding: EdgeInsets.only(left: 20, right: 20, bottom: 0),
      unselectedLabelStyle: TextStyle(
        color: const Color.fromARGB(118, 255, 255, 255),
        fontSize: MediaQuery.of(context).size.width / 25,
        fontWeight: FontWeight.w400,
      ),
      indicatorWeight: 0.0,
      indicatorPadding: EdgeInsets.zero,
      dividerColor: Colors.transparent,
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        _tabBarPagePreview(),
        _tabBarPagePreview(),
        _tabBarPagePreview(),
        _tabBarPagePreview(),
        _tabBarPagePreview(),
        _tabBarPagePreview(),
        _tabBarPagePreview(),
      ],
    );
  }

  Widget _tabBarPagePreview() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Icon(Icons.widgets_rounded, color: Colors.white, size: 100)],
    );
  }
}
