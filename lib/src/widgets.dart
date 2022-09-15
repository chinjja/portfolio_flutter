import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:portfolio/src/pages.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MyCard extends StatelessWidget {
  const MyCard({Key? key, this.child}) : super(key: key);
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 200,
        maxWidth: 300,
      ),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: child,
      ),
    );
  }
}

class MyLinkButton extends StatelessWidget {
  const MyLinkButton(
    this.title, {
    Key? key,
    required this.linkKey,
  }) : super(key: key);
  final String title;
  final GlobalKey linkKey;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Scrollable.ensureVisible(
          linkKey.currentContext!,
          duration: const Duration(milliseconds: 250),
        );
      },
    );
  }
}

class MyLinkTitle extends StatelessWidget {
  const MyLinkTitle(
    this.title, {
    Key? key,
    required this.parent,
    this.color = Colors.black,
  }) : super(key: key);

  final String title;
  final Color color;
  final BuildContext parent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0, right: 52),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: Icon(
              Icons.link,
              color: color,
              size: 40,
            ),
            onTap: () {
              Scrollable.ensureVisible(
                parent,
                duration: const Duration(milliseconds: 250),
              );
            },
          ),
          const SizedBox(width: 12),
          Container(
            child: Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: color),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyHOverWidget extends StatefulWidget {
  const MyHOverWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<MyHOverWidget> createState() => _MyHOverWidgetState();
}

class _MyHOverWidgetState extends State<MyHOverWidget>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
    reverseDuration: const Duration(milliseconds: 100),
  );

  late final Animation<double> _animation;
  var _mat = Matrix4.identity();

  @override
  void initState() {
    super.initState();
    final curve = CurvedAnimation(parent: _controller, curve: Curves.ease);

    _animation = Tween(begin: 0.0, end: 8.0).animate(curve);
    _animation.addListener(() {
      setState(() {
        _mat = Matrix4.translationValues(0, _animation.value, 0);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        _controller.forward();
      },
      onExit: (event) {
        _controller.reverse();
      },
      child: Transform(
        transform: _mat,
        child: widget.child,
      ),
    );
  }
}

class MyUrlWidget extends StatelessWidget {
  final String name;
  final String url;

  const MyUrlWidget({
    Key? key,
    required this.name,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Linkify(
            text: url,
            onOpen: (link) async {
              if (await canLaunchUrlString(link.url)) {
                await launchUrlString(link.url);
              } else {
                throw 'Could not launch $link';
              }
            },
          )
        ],
      ),
    );
  }
}

class MyImagePagenation extends StatefulWidget {
  const MyImagePagenation({
    Key? key,
    required this.images,
    this.enableTap = true,
    this.initialIndex = 0,
  }) : super(key: key);
  final List<String> images;
  final int initialIndex;
  final bool enableTap;

  @override
  State<MyImagePagenation> createState() => _MyImagePagenationState();
}

class _MyImagePagenationState extends State<MyImagePagenation> {
  late final _controller = PageController(initialPage: widget.initialIndex);
  late var _currentPage = widget.initialIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: MouseRegion(
            cursor:
                widget.enableTap ? SystemMouseCursors.click : MouseCursor.defer,
            child: GestureDetector(
              onTap: widget.enableTap
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenPage(
                            images: widget.images,
                            initialIndex: _controller.page?.toInt() ?? 0,
                          ),
                        ),
                      );
                    }
                  : null,
              child: Container(
                color: Colors.black54,
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemCount: widget.images.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      widget.images[index],
                      fit: BoxFit.contain,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _prev,
              icon: const Icon(Icons.arrow_left),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text('${_currentPage + 1}/${widget.images.length}'),
            ),
            IconButton(
              onPressed: _next,
              icon: const Icon(Icons.arrow_right),
            ),
          ],
        ),
      ],
    );
  }

  void _prev() async {
    await _controller.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.ease,
    );
  }

  void _next() async {
    await _controller.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.ease,
    );
  }
}

class TextWithCircle extends StatelessWidget {
  const TextWithCircle({
    Key? key,
    this.lineSpacing = 2,
    this.spacing = 12,
    this.summary,
    this.summaryWidth = 100,
    required this.text,
  }) : super(key: key);
  final double lineSpacing;
  final double spacing;
  final String? summary;
  final double summaryWidth;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: lineSpacing),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: SizedBox(
              height: 24,
              child: Icon(Icons.circle, size: 6),
            ),
          ),
          SizedBox(width: spacing),
          if (summary != null)
            SizedBox(
              width: summaryWidth,
              child: Text(
                summary!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: Linkify(
              text: text,
              onOpen: (link) async {
                if (await canLaunchUrlString(link.url)) {
                  await launchUrlString(link.url);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
