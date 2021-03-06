import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:portfolio/src/masonry.dart';
import 'package:portfolio/src/pages.dart';
import 'package:portfolio/src/widgets.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:url_launcher/url_launcher.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PJH's Portfolio",
      theme: ThemeData(
        dividerColor: Colors.grey[800],
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _header = GlobalKey();
  final _aboutMe = GlobalKey();
  final _skills = GlobalKey();
  final _archiving = GlobalKey();
  final _projects = GlobalKey();
  final _career = GlobalKey();

  final _scrollController = ScrollController();
  var _showUpwardButton = false;
  var _headerOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final showUpwardButton = _scrollController.offset > 300;
      final headerOpacity =
          ((_scrollController.offset - 50) / 100.0).clamp(0.0, 1.0);

      if (_showUpwardButton != showUpwardButton ||
          _headerOpacity != headerOpacity) {
        setState(() {
          _showUpwardButton = showUpwardButton;
          _headerOpacity = headerOpacity;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    List<Widget> actions;
    if (width < 500) {
      actions = [
        PopupMenuButton(itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: const Text('About me'),
              onTap: () {
                _scrollTo(_aboutMe);
              },
            ),
            PopupMenuItem(
              child: const Text('Skills'),
              onTap: () {
                _scrollTo(_skills);
              },
            ),
            PopupMenuItem(
              child: const Text('Archiving'),
              onTap: () {
                _scrollTo(_archiving);
              },
            ),
            PopupMenuItem(
              child: const Text('Projects'),
              onTap: () {
                _scrollTo(_projects);
              },
            ),
            PopupMenuItem(
              child: const Text('Career'),
              onTap: () {
                _scrollTo(_career);
              },
            ),
          ];
        }),
      ];
    } else {
      actions = [
        MyLinkButton('About me', linkKey: _aboutMe),
        MyLinkButton('Skills', linkKey: _skills),
        MyLinkButton('Archiving', linkKey: _archiving),
        MyLinkButton('Projects', linkKey: _projects),
        MyLinkButton('Career', linkKey: _career),
      ];
    }
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverOverlapAbsorber(
            handle: SliverOverlapAbsorberHandle(),
            sliver: SliverAppBar(
              pinned: true,
              title: InkWell(
                child: const Text("PJH's Portfolio????"),
                onTap: () {
                  _scrollTo(_header);
                },
              ),
              actions: actions,
              backgroundColor: Colors.blue.withOpacity(_headerOpacity),
              elevation: _headerOpacity * 4.0,
            ),
          ),
          Header(
            key: _header,
            linkKey: _aboutMe,
          ),
          AboutMe(key: _aboutMe),
          Skills(key: _skills),
          Archiving(key: _archiving),
          Projects(key: _projects),
          Career(key: _career),
          const Footer(),
        ],
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _showUpwardButton ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 250),
        child: IgnorePointer(
          ignoring: !_showUpwardButton,
          child: FloatingActionButton(
            child: const Icon(Icons.arrow_upward),
            onPressed: () {
              _scrollTo(_header);
            },
          ),
        ),
      ),
    );
  }

  void _scrollTo(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 250),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key, required this.linkKey}) : super(key: key);
  final GlobalKey linkKey;
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 500 + padding.top,
            child: Image.asset(
              'assets/images/banner.jpg',
              fit: BoxFit.cover,
              scale: 2,
            ),
          ),
          Positioned(
            left: 8,
            right: 8,
            bottom: 50,
            child: Column(
              children: [
                DefaultTextStyle(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 3,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  child: Column(
                    children: const [
                      Text('- ????????? -'),
                      Text(
                        '????????? ???????????????',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: Center(
                    child: Container(
                      height: 4,
                      decoration: ShapeDecoration(
                        color: Colors.orange[800],
                        shape: const StadiumBorder(),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: const [
                    Text(
                      '????????? ????????? ?????????\n'
                      '??????????????? ????????? ?????????\n'
                      '???????????? ????????? ?????? ?????? ???????????? ???????????? ?????????',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.3,
                        color: Colors.white,
                        fontSize: 20,
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 5,
                            color: Colors.black,
                          ),
                          Shadow(
                            offset: Offset(-1, -1),
                            blurRadius: 5,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: Material(
                    elevation: 4,
                    shape: const StadiumBorder(),
                    color: Colors.orange[800],
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            '??? ????????????',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.arrow_downward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      onTap: () {
                        Scrollable.ensureVisible(
                          linkKey.currentContext!,
                          duration: const Duration(milliseconds: 250),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AboutMe extends StatelessWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        vertical: 60,
      ),
      sliver: MultiSliver(
        children: [
          SliverToBoxAdapter(
            child: MyLinkTitle(
              'ABOUT ME',
              parent: context,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(
              left: 48,
              right: 48,
              bottom: 32,
            ),
            sliver: SliverCrossAxisConstrained(
              maxCrossAxisExtent: 1000,
              child: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 350,
                  mainAxisExtent: 50,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildListDelegate.fixed(
                  [
                    _item(Icons.person, '??????', '?????????'),
                    _item(Icons.today, '????????????', '87.4.1'),
                    _item(Icons.person, '?????????', '?????? ?????????'),
                    _item(Icons.phone, '?????????', '010-2882-7458'),
                    _item(Icons.email, '?????????', 'chinjja@gmail.com'),
                    _item(Icons.person, '??????', '?????????????????? (??????)'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(IconData icon, String title, String subtitle) {
    return Center(
      child: SizedBox(
        width: 200,
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon, size: 32),
          title: Text(title),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }
}

class Skills extends StatelessWidget {
  const Skills({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.yellow[700],
        padding: const EdgeInsets.symmetric(
          vertical: 60,
        ),
        child: Center(
          child: SizedBox(
            width: 1000,
            child: Column(
              children: [
                MyLinkTitle(
                  'SKILLS',
                  parent: context,
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Masonry(
                    horizontalExtent: 250,
                    horizontalSpacing: 32,
                    verticalSpacing: 16,
                    children: [
                      _skill(title: 'Mobile App', children: [
                        _flutterLogo(),
                        _androidLogo(),
                        _javaLogo(),
                      ]),
                      _skill(title: 'Desktop App', children: [
                        _javaLogo(),
                      ]),
                      _skill(title: 'Backend', children: [
                        _springLogo(),
                        _javaLogo(),
                      ]),
                      _skill(title: 'FrontEnd', children: [
                        _flutterLogo(),
                      ]),
                      _skill(title: 'Database', children: [
                        _sqliteLogo(),
                      ]),
                      _skill(title: 'Version Control', children: [
                        _gitLogo(),
                        _githubLogo(),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _springLogo() {
    return Row(
      children: [
        Image.asset(
          'assets/logos/spring.png',
          height: 70,
        ),
        const SizedBox(width: 8),
        const Text(
          'Spring\nBoot',
          style: TextStyle(fontSize: 26),
        )
      ],
    );
  }

  Widget _flutterLogo() {
    return Row(
      children: const [
        FlutterLogo(size: 70),
        Text(
          'Flutter',
          style: TextStyle(fontSize: 30),
        )
      ],
    );
  }

  Widget _androidLogo() {
    return Image.asset(
      'assets/logos/android.png',
      width: double.infinity,
      height: 70,
      fit: BoxFit.cover,
    );
  }

  Widget _sqliteLogo() {
    return Image.asset(
      'assets/logos/sqlite.png',
      width: double.infinity,
      height: 70,
      fit: BoxFit.cover,
    );
  }

  Widget _javaLogo() {
    return Image.asset(
      'assets/logos/java.png',
      width: 160,
      height: 70,
      fit: BoxFit.cover,
    );
  }

  Widget _gitLogo() {
    return Row(
      children: [
        Image.asset(
          'assets/logos/git.png',
          height: 70,
        ),
        const SizedBox(width: 8),
        const Text(
          'Git',
          style: TextStyle(fontSize: 30),
        )
      ],
    );
  }

  Widget _githubLogo() {
    return Row(
      children: [
        Image.asset(
          'assets/logos/github.png',
          height: 70,
        ),
        const SizedBox(width: 8),
        const Text(
          'GitHub',
          style: TextStyle(fontSize: 30),
        )
      ],
    );
  }

  Widget _skill({required String title, required List<Widget> children}) {
    return Center(
      child: MyHOverWidget(
        child: MyCard(
          child: Container(
            width: 250,
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide()),
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.orange[700],
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: children
                      .map(
                        (e) => Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: e,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Archiving extends StatelessWidget {
  const Archiving({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverStack(
      children: [
        SliverPositioned.fill(
          child: Container(
            color: Colors.grey[900],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 60,
          ),
          sliver: MultiSliver(
            children: [
              SliverToBoxAdapter(
                child: MyLinkTitle(
                  'ARCHIVING',
                  color: Colors.white,
                  parent: context,
                ),
              ),
              SliverCrossAxisConstrained(
                maxCrossAxisExtent: 1000,
                child: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 700,
                    crossAxisSpacing: 30,
                    mainAxisExtent: 230,
                    mainAxisSpacing: 20,
                  ),
                  delegate: SliverChildListDelegate.fixed(
                    [
                      _github(),
                      _boj(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _base({
    required String image,
    required String imageLabel,
    required String url,
    required Widget summary,
    required List<String> texts,
  }) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: 400,
        height: double.infinity,
        child: MyHOverWidget(
          child: MyCard(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        image,
                        height: 40,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        imageLabel,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Linkify(
                    text: url,
                    onOpen: (link) async {
                      if (await canLaunch(link.url)) {
                        await launch(link.url);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  summary,
                  const SizedBox(height: 12),
                  ...texts.map(
                    (text) => TextWithCircle(text: text),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _github() {
    return _base(
      image: 'assets/logos/github.png',
      imageLabel: 'GitHub',
      url: 'http://github.com/chinjja',
      summary: RichText(
        text: const TextSpan(
          text: '?????? ?????? ?????????',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: '?????????.',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
      texts: [
        '?????? ????????????, ????????????, ?????? ?????? ??????',
        '????????? ?????? ????????? ?????? ???????????? ?????? ??????',
      ],
    );
  }

  Widget _boj() {
    return _base(
      image: 'assets/logos/boj.png',
      imageLabel: 'BOJ',
      url: 'http://www.acmicpc.net/user/chinjja',
      summary: RichText(
        text: const TextSpan(
          text: '?????? ?????? ?????????',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: '?????????.',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
      texts: [
        '???????????? ?????? ??????',
      ],
    );
  }
}

class Projects extends StatelessWidget {
  const Projects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final slivers = [
      _item(
        context,
        title: '???????????? ????????????',
        subtitle: '2011 ~ ??????',
        readme: 'assets/projects/dtk/README.md',
        images: [
          'assets/projects/dtk/1.png',
          'assets/projects/dtk/2.png',
          'assets/projects/dtk/3.png',
          'assets/projects/dtk/4.png',
          'assets/projects/dtk/5.png',
          'assets/projects/dtk/6.png',
          'assets/projects/dtk/7.png',
          'assets/projects/dtk/8.png',
          'assets/projects/dtk/9.png',
        ],
        description: '?????? ????????? ???????????? ??????????????????.',
        features: {
          '????????????': '?????? ???????????? ??? ??????, ?????? ????????? ??????',
          'Stack': 'Java, Swing, JDBC',
          'Database': 'SQLite',
          'Deployment': 'NSIS, Gradle',
        },
      ),
      _item(
        context,
        title: 'V-Calendar',
        subtitle: '2022.03 (1??? ?????? ????????????)',
        readme: 'assets/projects/calendar/README.md',
        images: [
          'assets/projects/calendar/month.png',
          'assets/projects/calendar/drawer.png',
          'assets/projects/calendar/day1.png',
          'assets/projects/calendar/day2.png',
          'assets/projects/calendar/viewer.png',
          'assets/projects/calendar/editor.png',
          'assets/projects/calendar/today.png',
        ],
        description: '?????????????????? ?????? ????????? ????????? ???????????? ????????? ?????????????????????.\n\n'
            '?????? ???????????? ????????? Flutter ???????????? ??????????????? ????????? ?????? ?????????.',
        features: {
          '????????????': '?????? ?????? ????????? ???????????? ?????? ?????????, ????????? ??????/?????? ??????',
          'Github': 'https://github.com/chinjja/flutter_calendar_app',
          'Google Play':
              'https://play.google.com/store/apps/details?id=com.chinjja.calendar',
          'Stack': 'Flutter, Provider + RxDart',
        },
      ),
      _item(
        context,
        title: 'Delayed Auditory Feedback',
        subtitle: '2018??? (1??? ?????? ????????????)',
        readme: 'assets/projects/daf/README.md',
        images: [
          'assets/projects/daf/3.png',
          'assets/projects/daf/2.png',
          'assets/projects/daf/1.png',
          'assets/projects/daf/4.png',
          'assets/projects/daf/5.png',
          'assets/projects/daf/6.png',
          'assets/projects/daf/7.png',
        ],
        description: '?????? ?????? ???????????? ????????? ??????????????? ????????? ?????? ?????? ???????????? ?????? ??????????????????.\n\n'
            '???????????? ?????? ???????????? ??? ????????? ????????? ????????? ????????? ?????? ????????????.\n'
            '???????????? ???????????? ????????? ?????? ????????? NDK??? ??????????????????.',
        features: {
          '????????????': '?????? ?????? ?????? ????????? & Low Latency',
          'Google Play':
              'https://play.google.com/store/apps/details?id=com.chinjja.app.daf',
          'Stack': 'Android, NDK',
        },
      ),
      _item(
        context,
        title: 'Instagram ????????????',
        subtitle: '2022.04 (1??? ?????? ????????????)',
        readme: 'assets/projects/instagram/README.md',
        images: [
          'assets/projects/instagram/1.jpg',
          'assets/projects/instagram/2.jpg',
          'assets/projects/instagram/3.jpg',
          'assets/projects/instagram/4.jpg',
          'assets/projects/instagram/5.jpg',
          'assets/projects/instagram/6.jpg',
          'assets/projects/instagram/7.jpg',
          'assets/projects/instagram/8.jpg',
          'assets/projects/instagram/9.jpg',
          'assets/projects/instagram/10.jpg',
          'assets/projects/instagram/11.jpg',
        ],
        description: 'Firebase ????????? ??? ?????????????????????.\n\n'
            '????????? ???????????? ??????????????? ????????????????????????.\n'
            'Web, iOS, Android?????? ?????? ???????????????.',
        features: {
          'Stack': 'Flutter, Firestore, Bloc',
          '????????????': '?????????, ??????, ??????, ?????????, ?????? ??????',
          'Github': 'https://github.com/chinjja/instagram',
          'Web URL': 'https://chinjja.github.io/instagram/',
          'Frontend': 'Flutter, iOS, Android',
        },
      ),
      _item(
        context,
        title: '??????????????? ????????????',
        subtitle: '2022.03 (1??? ?????? ????????????)',
        readme: 'assets/projects/portfolio/README.md',
        images: [
          'assets/projects/portfolio/1.png',
          'assets/projects/portfolio/2.png',
          'assets/projects/portfolio/3.png',
          'assets/projects/portfolio/4.png',
          'assets/projects/portfolio/5.png',
        ],
        description: '??????????????? ????????? ????????? ?????????????????????. ?????? ?????? ?????? ?????? ??? ??????????????? ???????????????.\n\n'
            'Flutter ?????? ??? ??????????????? ?????? ??? ??????????????????.',
        features: {
          '????????????': '????????? ????????????, ?????? ??????, ?????? ??????, ???????????? ??????, ?????? ??????',
          'Github': 'https://github.com/chinjja/portfolio_flutter',
          'URL': 'https://chinjja.github.io/portfolio_flutter/',
          'Frontend': 'Flutter',
        },
      ),
    ];

    return SliverStack(
      children: [
        SliverPositioned.fill(
          child: Container(
            color: Colors.cyan[800],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 60,
          ),
          sliver: MultiSliver(
            children: [
              SliverToBoxAdapter(
                child: MyLinkTitle(
                  'PROJECTS',
                  color: Colors.white,
                  parent: context,
                ),
              ),
              SliverCrossAxisConstrained(
                maxCrossAxisExtent: 1000,
                child: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => slivers[index],
                    childCount: slivers.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _item(
    BuildContext context, {
    required String title,
    required String subtitle,
    required List<String> images,
    required String readme,
    required String description,
    required Map<String, String> features,
  }) {
    return LayoutBuilder(builder: (context, constraints) {
      final children = [
        Flexible(
          child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(8),
            width: 500,
            height: 440,
            child: MyImagePagenation(
              images: images,
            ),
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(8),
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(description),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      MyMarkdownPage.push(
                        context,
                        readme,
                      );
                    },
                    child: const Text('????????? ??????'),
                  ),
                ),
                const Divider(),
                Column(
                  children: features.entries
                      .map((e) => TextWithCircle(summary: e.key, text: e.value))
                      .toList(),
                )
              ],
            ),
          ),
        ),
      ];

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: MyCard(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(subtitle),
                  ],
                ),
                const SizedBox(height: 24),
                if (constraints.maxWidth < 800)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: children,
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class Career extends StatelessWidget {
  const Career({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverStack(
      children: [
        SliverPositioned.fill(
          child: Container(
            color: Colors.grey[200],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 60,
          ),
          sliver: MultiSliver(
            children: [
              SliverToBoxAdapter(
                child: MyLinkTitle(
                  'CAREER',
                  color: Colors.black,
                  parent: context,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate.fixed(
                  [
                    _dtk(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dtk() {
    return Center(
      child: SizedBox(
        width: 600,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '(???) ????????????',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '2006 ~ ??????',
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 16),
            const Text('????????? ?????? ?????? ???????????????. ?????? ????????? ????????? ???????????????.'),
            const SizedBox(height: 16),
            const Text(
                '?????????????????? Java??? ???????????? ????????????????????? ????????? ?????? ??????(??????, UI, DB, ?????? ?????? ????????? ??????)??? ?????? ???????????? ?????????, ???????????? ??? ??????????????? ????????? Flutter ??? ???????????? ????????? ???????????? ?????? ???????????? ?????? ?????? ??????????????? ???????????? ????????????.'),
            const SizedBox(height: 16),
            _block(
              title: '?????? ?????? ?????? ??? ??????',
              subtitle: '2006??? ~ 2011???',
              texts: [
                '???????????? ?????? ??? ??????',
                'PLC ???????????? ??????',
              ],
            ),
            _block(
              title: '???????????? ?????? ?????? ?????? ??????',
              subtitle: '2012??? ~ ??????',
              texts: [
                'Java Swing ???????????? UI ??????',
                '?????? ???????????? ?????? ??? ???????????? ?????? ??????',
                '????????? ??? ????????? ???????????? ?????? DB ??????',
                'NSIS??? Gradle, Git ???????????? ?????? ???????????? ????????? ???????????? ?????? ??????',
                '?????????????????? ?????? ??????',
                '??????/????????? ?????? Tree ???????????? UI ?????? ????????? ??? ?????? ??????',
                'Windows Service ???????????? ???????????? ???????????? ??????????????? ???????????? ?????? ??????',
                '?????? ?????? ???????????? ???????????? ??????',
                '?????? ?????? ????????? ?????? ??????',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _block({
    required String title,
    required String subtitle,
    required List<String> texts,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          ...texts
              .map(
                (e) => TextWithCircle(text: e),
              )
              .toList()
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(bottom: padding.bottom),
        height: 80 + padding.bottom,
        color: Colors.grey[900],
        child: const Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            child: Text(
              '2022. Chinjja. All rights reserved',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
