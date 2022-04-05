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
                child: const Text("PJH's Portfolio👋"),
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
                      Text('- 박정현 -'),
                      Text(
                        '개발자 포트폴리오',
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
                      '코드로 일하는 개발자\n'
                      '문제해결을 즐기는 개발자\n'
                      '사람들이 필요로 하는 것이 무엇인지 고민하는 개발자',
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
                            '더 알아보기',
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
                    _item(Icons.person, '이름', '박정현'),
                    _item(Icons.today, '생년월일', '87.4.1'),
                    _item(Icons.person, '주소지', '경남 창원시'),
                    _item(Icons.phone, '연락처', '010-2882-7458'),
                    _item(Icons.email, '이메일', 'chinjja@gmail.com'),
                    _item(Icons.person, '학력', '구미전자공고 (고졸)'),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: 800,
                child: Column(
                  children: const [
                    SizedBox(height: 8),
                    Text(
                      '저의 최대 장점은...',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '독학으로 시작하여 모든것을 혼자서 개발하엿습니다.\n정말 많은 길을 돌아 쌓인 시행착오들이 저의 최대 장점입니다.\n어떤 언어, Tool도 빠르게 적용하고, 신뢰도 또한 보장합니다.',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
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
          text: '소스 코드 저장소',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: '입니다.',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
      texts: [
        '개인 프로젝트, 프로그램, 앱의 소스 코드',
        '혼자서 코딩 연습을 위해 끄적이던 소스 코드',
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
          text: '소스 코드 저장소',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: '입니다.',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
      texts: [
        '알고리즘 풀이 코드',
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
        title: '재직회사 프로그램',
        subtitle: '2011 ~ 현재',
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
        description: '설비 제어용 데스크탑 어플리케이션.',
        features: {
          '주요기능': '설비 모니터링 및 제어, 각종 데이터 저장',
          'Stack': 'Java, Swing, JDBC',
          'Database': 'SQLite',
          'Deployment': 'NSIS, Gradle',
        },
      ),
      _item(
        context,
        title: 'V-Calendar',
        subtitle: '2022.03 (1人 개인 프로젝트)',
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
        description: '수직스크롤이 되는 캘린더 어플은 존재하지 않아서 제작하엿습니다.\n\n'
            '기존 데스크탑 앱들을 Flutter 기반으로 변경하고자 연습겸 만든 앱니다.',
        features: {
          '주요기능': '월간 또는 일간을 수직으로 무한 스크롤, 이벤트 생성/편집 기능',
          'Github': 'https://github.com/chinjja/flutter_calendar_app',
          'Google Play':
              'https://play.google.com/store/apps/details?id=com.chinjja.calendar',
          'Stack': 'Flutter, Provider + RxDart',
        },
      ),
      _item(
        context,
        title: 'Delayed Auditory Feedback',
        subtitle: '2018년 (1人 개인 프로젝트)',
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
        description: '기존 유사 어플들은 제대로 동작이되지 않아서 직접 구글 웹사이트 보고 개발했습니다.\n\n'
            '개발하는 김에 인앱결제 및 광고도 붙여서 소소히 용돈도 벌고 있습니다.\n'
            '저지연을 달성하기 위해서 핵심 로직에 NDK를 사용했습니다.',
        features: {
          '주요기능': '정밀 가변 지연 피드백 & Low Latency',
          'Google Play':
              'https://play.google.com/store/apps/details?id=com.chinjja.app.daf',
          'Stack': 'Android, NDK',
        },
      ),
      _item(
        context,
        title: 'Instagram 클론코딩',
        subtitle: '2022.04 (1人 개인 프로젝트)',
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
        description: 'Firebase 테스트 겸 제작하였습니다.\n\n'
            '모바일 환경에서 레이아웃이 최적화되었습니다.\n'
            'Web, iOS, Android에서 실행 가능합니다.',
        features: {
          '주요기능': '게시물, 댓글, 활동, 북마크, 채팅 기능',
          'Github': 'https://github.com/chinjja/instagram',
          'Web URL': 'https://chinjja.github.io/instagram/',
          'Frontend': 'Flutter, iOS, Android',
        },
      ),
      _item(
        context,
        title: '포트폴리오 웹사이트',
        subtitle: '2022.03 (1人 개인 프로젝트)',
        readme: 'assets/projects/portfolio/README.md',
        images: [
          'assets/projects/portfolio/1.png',
          'assets/projects/portfolio/2.png',
          'assets/projects/portfolio/3.png',
          'assets/projects/portfolio/4.png',
          'assets/projects/portfolio/5.png',
        ],
        description: '포트폴리오 용도로 제작한 웹사이트입니다. 지금 보고 있는 바로 이 웹사이트에 해당합니다.\n\n'
            'Flutter 학습 겸 포트폴리오 제작 겸 만들었습니다.',
        features: {
          '주요기능': '간단한 자기소개, 인적 사항, 기술 스택, 프로젝트 경험, 업무 경력',
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
                    child: const Text('자세히 보기'),
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
              '(주) 대호테크',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '2006 ~ 현재',
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 16),
            const Text('자동화 설비 전문 기업입니다. 주력 설비는 열성형 설비입니다.'),
            const SizedBox(height: 16),
            const Text(
                '기본적으로는 Java를 이용하여 프로그램적으로 필요한 모든 부분(통신, UI, DB, 각종 고객 커스텀 기능)을 총괄 담당하고 있으며, 원격제어 및 통합관리를 위해서 Flutter 및 스프링을 도입할 목적으로 시간 나는대로 여러 토이 프로젝트를 진행하고 있습니다.'),
            const SizedBox(height: 16),
            _block(
              title: '설비 제어 제작 및 설계',
              subtitle: '2006년 ~ 2011년',
              texts: [
                '전기회로 설계 및 제작',
                'PLC 프로그램 개발',
              ],
            ),
            _block(
              title: '프로그램 관련 모든 부분 담당',
              subtitle: '2012년 ~ 현재',
              texts: [
                'Java Swing 기반으로 UI 개발',
                '각종 디바이스 통신 및 네트워크 통신 개발',
                '레시피 및 트렌드 데이터에 관계 DB 도입',
                'NSIS와 Gradle, Git 도입하여 자동 버저닝이 반영된 인스톨러 생성 도입',
                '라이프사이클 개념 도입',
                '활성/비활성 조건 Tree 구조기반 UI 상태 눈관리 및 반응 도입',
                'Windows Service 마이크로 서비스를 개발하여 사용기간을 제한하는 기능 도입',
                '각종 사내 유틸리티 프로그램 개발',
                '각종 고객 커스텀 기능 개발',
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
