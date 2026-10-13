
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

const bg = Color(0xFF070A16);
const panel = Color(0xFF11172B);
const purple = Color(0xFF9B6DFF);
const cyan = Color(0xFF45D9F5);
const muted = Color(0xFFADB5D1);

void main() => runApp(const GopikaPortfolio());

class GopikaPortfolio extends StatelessWidget {
  const GopikaPortfolio({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'K.Gopika | Portfolio',
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: bg,
          colorScheme: ColorScheme.fromSeed(
            seedColor: purple,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          fontFamily: 'Arial',
        ),
        home: const WelcomePage(),
      );
}

// ======================= BACKGROUND =======================

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  const AnimatedBackground({super.key, required this.child});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: controller,
        builder: (_, child) => Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(
                -0.8 + controller.value * 1.6,
                -0.8 + controller.value * 0.9,
              ),
              radius: 1.4,
              colors: const [
                Color(0xFF20204A),
                Color(0xFF10132B),
                bg,
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 80 + controller.value * 60,
                right: 50,
                child: _glow(150, purple),
              ),
              Positioned(
                bottom: 80,
                left: 20 + controller.value * 70,
                child: _glow(120, cyan),
              ),
              child!,
            ],
          ),
        ),
        child: widget.child,
      );

  Widget _glow(double size, Color color) => IgnorePointer(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.15),
                blurRadius: 100,
                spreadRadius: 30,
              ),
            ],
          ),
        ),
      );
}

// ======================= GLASS CARD =======================

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
  });

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.045),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.12),
              ),
            ),
            child: child,
          ),
        ),
      );
}

// ======================= GRADIENT BUTTON =======================

class GradientButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
        onEnter: (_) => setState(() => hovering = true),
        onExit: (_) => setState(() => hovering = false),
        child: AnimatedScale(
          scale: hovering ? 1.04 : 1,
          duration: const Duration(milliseconds: 200),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [purple, Color(0xFF536DFF), cyan],
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: purple.withValues(
                    alpha: hovering ? 0.4 : 0.15,
                  ),
                  blurRadius: hovering ? 25 : 12,
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: widget.onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 19,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon, size: 19),
                    const SizedBox(width: 10),
                  ],
                  Text(
                    widget.text,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

// ======================= PROFILE PHOTO =======================

class ProfilePhoto extends StatelessWidget {
  final double size;
  const ProfilePhoto({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(colors: [purple, cyan]),
          boxShadow: [
            BoxShadow(
              color: purple.withValues(alpha: 0.3),
              blurRadius: 28,
            ),
          ],
        ),
        child: ClipOval(
          child: Image.asset(
            'assets/images/profile.jpg',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: panel,
              child: Icon(
                Icons.person_rounded,
                size: size * 0.55,
                color: cyan,
              ),
            ),
          ),
        ),
      );
}

// ======================= WELCOME PAGE =======================

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void enterPortfolio() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (_, animation, __) => const PortfolioPage(),
        transitionsBuilder: (_, animation, __, child) => FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.05),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: AnimatedBackground(
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: FadeTransition(
                  opacity: controller,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.12),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: controller,
                        curve: Curves.easeOutCubic,
                      ),
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: GlassCard(
                        padding: const EdgeInsets.all(36),
                        child: Column(
                          children: [
                            const Text(
                              'PORTFOLIO / 2026',
                              style: TextStyle(
                                color: cyan,
                                letterSpacing: 5,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 32),
                            const ProfilePhoto(size: 150),
                            const SizedBox(height: 30),
                            const Text(
                              'Hello, I am',
                              style: TextStyle(color: muted, fontSize: 18),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'K.Gopika',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 43,
                                height: 1.15,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 18),
                            const Text(
                              'Computer Science Engineering Student',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: cyan,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              'Exploring technology, building projects, '
                              'and turning ideas into meaningful digital '
                              'experiences.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: muted, height: 1.8),
                            ),
                            const SizedBox(height: 32),
                            GradientButton(
                              text: 'Enter My Portfolio',
                              icon: Icons.arrow_forward_rounded,
                              onPressed: enterPortfolio,
                            ),
                            const SizedBox(height: 26),
                            const Text(
                              'LEARN  •  CREATE  •  EVOLVE',
                              style: TextStyle(
                                color: muted,
                                fontSize: 10,
                                letterSpacing: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

// ======================= MAIN PORTFOLIO =======================

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController scrollController = ScrollController();

  final Map<String, GlobalKey> keys = {
    for (final name in [
      'Home',
      'About',
      'Achievements',
      'Certificates',
      'Skills',
      'Projects',
      'Activities',
      'Contact',
    ])
      name: GlobalKey(),
  };

  final List<String> items = [
    'Home',
    'About',
    'Achievements',
    'Certificates',
    'Skills',
    'Projects',
    'Activities',
    'Contact',
  ];

  void goTo(String name) {
    final target = keys[name]?.currentContext;
    if (target != null) {
      Scrollable.ensureVisible(
        target,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
        alignment: 0.04,
      );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  IconData iconFor(String item) {
    switch (item) {
      case 'Home':
        return Icons.home_outlined;
      case 'About':
        return Icons.person_outline;
      case 'Achievements':
        return Icons.emoji_events_outlined;
      case 'Certificates':
        return Icons.workspace_premium_outlined;
      case 'Skills':
        return Icons.code;
      case 'Projects':
        return Icons.devices_outlined;
      case 'Activities':
        return Icons.groups_outlined;
      default:
        return Icons.mail_outline;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: Drawer(
          backgroundColor: panel,
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                  'K.Gopika',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: cyan,
                  ),
                ),
                const SizedBox(height: 25),
                for (final item in items)
                  ListTile(
                    leading: Icon(iconFor(item), color: purple),
                    title: Text(item),
                    onTap: () {
                      Navigator.pop(context);
                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) => goTo(item),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
        body: AnimatedBackground(
          child: SafeArea(
            child: Column(
              children: [
                _navigation(),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Column(
                            children: [
                              _hero(),
                              _about(),
                              _achievements(),
                              _certificates(),
                              _skills(),
                              _projects(),
                              _activities(),
                              _contact(),
                              const SizedBox(height: 35),
                              const Text(
                                'DESIGNED WITH CURIOSITY • BUILT WITH FLUTTER',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: muted,
                                  fontSize: 10,
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(height: 28),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _navigation() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        child: Row(
          children: [
            const Text(
              'C.',
              style: TextStyle(
                color: cyan,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'K.Gopika',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const Spacer(),
            if (MediaQuery.sizeOf(context).width > 950)
              Flexible(
                child: Wrap(
                  alignment: WrapAlignment.end,
                  spacing: 2,
                  children: [
                    for (final item in items)
                      TextButton(
                        onPressed: () => goTo(item),
                        child: Text(
                          item,
                          style: const TextStyle(
                            color: muted,
                            fontSize: 11,
                          ),
                        ),
                      ),
                  ],
                ),
              )
            else
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu_rounded, color: cyan),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
          ],
        ),
      );

  Widget section(String name, String subtitle, Widget content) =>
      Container(
        key: keys[name],
        padding: const EdgeInsets.symmetric(vertical: 55),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name.toUpperCase(),
              style: const TextStyle(
                color: cyan,
                fontSize: 11,
                letterSpacing: 4,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 28),
            content,
          ],
        ),
      );

  Widget _hero() => Container(
        key: keys['Home'],
        constraints: const BoxConstraints(minHeight: 520),
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 650;

            final intro = Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'HELLO, WORLD!',
                  style: TextStyle(
                    color: cyan,
                    letterSpacing: 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  "I'm K.Gopika.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Curious mind. Creative builder. Future engineer.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: purple,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'I am a Computer Science Engineering student interested '
                  'in software development, problem-solving, and exploring '
                  'how technology can make everyday experiences better.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: muted, height: 1.9),
                ),
                const SizedBox(height: 28),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    GradientButton(
                      text: 'Explore My Work',
                      icon: Icons.arrow_downward_rounded,
                      onPressed: () => goTo('Projects'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => goTo('Contact'),
                      icon: const Icon(Icons.mail_outline),
                      label: const Text('Contact Me'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: cyan,
                        side: const BorderSide(color: cyan),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 19,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );

            if (compact) {
              return Column(
                children: [
                  const ProfilePhoto(size: 165),
                  const SizedBox(height: 35),
                  intro,
                ],
              );
            }

            return Row(
              children: [
                Expanded(child: intro),
                const SizedBox(width: 45),
                const ProfilePhoto(size: 245),
              ],
            );
          },
        ),
      );

  Widget _about() => section(
        'About',
        'A little about me',
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Student by day. Problem-solver always.',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'I am pursuing a Bachelor of Technology in Computer '
                'Science Engineering at BVRIT Hyderabad College of '
                'Engineering for Women. I enjoy learning new technologies, '
                'writing code, experimenting with ideas, and collaborating '
                'on projects that challenge me to grow.',
                style: TextStyle(color: muted, height: 1.9),
              ),
              const SizedBox(height: 25),
              const Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  InfoChip(
                    icon: Icons.school_outlined,
                    text: 'B.Tech CSE',
                  ),
                  InfoChip(
                    icon: Icons.location_on_outlined,
                    text: 'Hyderabad',
                  ),
                  InfoChip(
                    icon: Icons.lightbulb_outline,
                    text: 'Always Learning',
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget _achievements() {
    final data = [
      (
        'Problem Solving',
        'Practising data structures and algorithms through coding challenges.',
        Icons.psychology_outlined,
      ),
      (
        'Project Building',
        'Exploring practical software projects and application development.',
        Icons.terminal_rounded,
      ),
      (
        'Continuous Learning',
        'Building knowledge through courses, experiments, and self-learning.',
        Icons.auto_awesome_outlined,
      ),
    ];

    return section(
      'Achievements',
      'Progress worth celebrating',
      LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth > 800
              ? 3
              : constraints.maxWidth > 500
                  ? 2
                  : 1;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              mainAxisExtent: 205,
            ),
            itemBuilder: (context, index) => HoverCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '0${index + 1}',
                    style: const TextStyle(
                      color: cyan,
                      fontSize: 12,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Icon(data[index].$3, color: purple, size: 30),
                  const SizedBox(height: 14),
                  Text(
                    data[index].$1,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data[index].$2,
                    style: const TextStyle(
                      color: muted,
                      height: 1.6,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _certificates() => section(
        'Certificates',
        'My learning journey',
        const CertificateGallery(),
      );

  Widget _skills() {
    final skills = [
      ('C', 0.70),
      ('Java', 0.65),
      ('Python', 0.55),
      ('HTML & CSS', 0.65),
      ('JavaScript', 0.45),
      ('SQL', 0.55),
      ('Problem Solving', 0.65),
      ('Regular LeetCode Practice', 0.70),
    ];

    return section(
      'Skills',
      'Tools I am learning and using',
      GlassCard(
        child: Column(
          children: [
            for (final skill in skills) ...[
              Row(
                children: [
                  Expanded(
                    child: Text(
                      skill.$1,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Text(
                    'Learning',
                    style: TextStyle(color: cyan, fontSize: 11),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: skill.$2),
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeOutCubic,
                builder: (context, value, _) => ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: value,
                    minHeight: 7,
                    backgroundColor: Colors.white10,
                    valueColor: const AlwaysStoppedAnimation(cyan),
                  ),
                ),
              ),
              const SizedBox(height: 23),
            ],
          ],
        ),
      ),
    );
  }

  Widget _projects() {
    final data = [
      (
        'ConnectThruCampus',
        'A campus platform concept connecting students with events, '
            'internships, resources, study groups, and communication tools.',
        'Web Development',
        Icons.school_outlined,
      ),
      (
        'TrustLens',
        'A prototype concept focused on transparent AI-assisted IT incident '
            'investigation, explanations, and human oversight.',
        'AI / UI Design',
        Icons.security_outlined,
      ),
      (
        'Flutter Portfolio',
        'An interactive personal portfolio with animated sections, '
            'glassmorphism, and a certificate presentation experience.',
        'Flutter',
        Icons.web_outlined,
      ),
    ];

    return section(
      'Projects',
      'Ideas becoming experiences',
      LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth > 800
              ? 3
              : constraints.maxWidth > 520
                  ? 2
                  : 1;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              mainAxisExtent: 265,
            ),
            itemBuilder: (context, index) => HoverCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(data[index].$4, size: 35, color: cyan),
                  const SizedBox(height: 18),
                  Text(
                    data[index].$1,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Text(
                      data[index].$2,
                      style: const TextStyle(
                        color: muted,
                        height: 1.7,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  InfoChip(
                    icon: Icons.category_outlined,
                    text: data[index].$3,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _activities() => section(
        'Activities',
        'Beyond the classroom',
        const GlassCard(
          child: Column(
            children: [
              ActivityTile(
                icon: Icons.groups_outlined,
                title: 'Cognitia',
                subtitle: 'Junior Member • College Club',
              ),
              Divider(color: Colors.white12, height: 32),
              ActivityTile(
                icon: Icons.code_rounded,
                title: 'Coding Practice',
                subtitle: 'Practising programming and problem-solving.',
              ),
              Divider(color: Colors.white12, height: 32),
              ActivityTile(
                icon: Icons.explore_outlined,
                title: 'Independent Learning',
                subtitle:
                    'Exploring software development and emerging technology.',
              ),
            ],
          ),
        ),
      );

  Widget _contact() => section(
        'Contact',
        "Let's connect",
        GlassCard(
          child: Column(
            children: [
              const Icon(
                Icons.mark_email_unread_outlined,
                color: cyan,
                size: 45,
              ),
              const SizedBox(height: 20),
              const Text(
                'Have an idea, opportunity, or project in mind?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'I would be happy to connect and learn from new experiences.',
                textAlign: TextAlign.center,
                style: TextStyle(color: muted, height: 1.7),
              ),
              const SizedBox(height: 25),
              const ActivityTile(
                icon: Icons.email_outlined,
                title: 'Email',
                subtitle: 'K.Gopika@gmail.com',
              ),
              const SizedBox(height: 20),
              const ActivityTile(
                icon: Icons.phone_outlined,
                title: 'Phone Number',
                subtitle: '8331817488',
              ),
              const SizedBox(height: 25),
              GradientButton(
                text: 'Back to Top',
                icon: Icons.arrow_upward_rounded,
                onPressed: () => goTo('Home'),
              ),
            ],
          ),
        ),
      );
}

// ======================= CERTIFICATE CAROUSEL =======================

class CertificateGallery extends StatefulWidget {
  const CertificateGallery({super.key});

  @override
  State<CertificateGallery> createState() =>
      _CertificateGalleryState();
}

class _CertificateGalleryState extends State<CertificateGallery> {
  final PageController controller = PageController(viewportFraction: 0.82);
  int currentIndex = 0;

  final certificates = [
    {
      'title': 'Certificate One',
      'issuer': 'Add your actual course or achievement',
      'image': 'assets/certificates/certificate1.png',
    },
    {
      'title': 'Certificate Two',
      'issuer': 'Add your actual course or achievement',
      'image': 'assets/certificates/certificate2.png',
    },
    {
      'title': 'Certificate Three',
      'issuer': 'Add your actual course or achievement',
      'image': 'assets/certificates/certificate3.png',
    },
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void changePage(int index) {
    controller.animateToPage(
      (index + certificates.length) % certificates.length,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'A visual journey through my learning',
                  style: TextStyle(color: muted),
                ),
              ),
              IconButton(
                onPressed: () => changePage(currentIndex - 1),
                icon: const Icon(Icons.arrow_back_ios_new, color: cyan),
              ),
              IconButton(
                onPressed: () => changePage(currentIndex + 1),
                icon: const Icon(Icons.arrow_forward_ios, color: cyan),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 330,
            child: PageView.builder(
              controller: controller,
              itemCount: certificates.length,
              onPageChanged: (index) => setState(() => currentIndex = index),
              itemBuilder: (context, index) {
                final certificate = certificates[index];

                return AnimatedScale(
                  scale: index == currentIndex ? 1 : 0.9,
                  duration: const Duration(milliseconds: 350),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () => _preview(context, certificate),
                      child: GlassCard(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  certificate['image']!,
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: double.infinity,
                                    color: panel,
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.workspace_premium_outlined,
                                          color: purple,
                                          size: 60,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Certificate image not found',
                                          style: TextStyle(color: muted),
                                        ),
                                        SizedBox(height: 6),
                                        Text(
                                          'Check the asset path and filename',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: muted,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              certificate['title']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              certificate['issuer']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: muted,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < certificates.length; i++)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: i == currentIndex ? 25 : 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: i == currentIndex ? cyan : Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 25),
          GradientButton(
            text: 'Start Certificate Presentation',
            icon: Icons.slideshow_rounded,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CertificatePresentation(
                  certificates: certificates,
                ),
              ),
            ),
          ),
        ],
      );

  void _preview(
    BuildContext context,
    Map<String, String> certificate,
  ) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: panel,
        insetPadding: const EdgeInsets.all(20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 850,
            maxHeight: 700,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        certificate['title']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Flexible(
                  child: Image.asset(
                    certificate['image']!,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Padding(
                      padding: EdgeInsets.all(50),
                      child: Text(
                        'Certificate image not found. Check the asset path.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ======================= CERTIFICATE PRESENTATION =======================

class CertificatePresentation extends StatefulWidget {
  final List<Map<String, String>> certificates;

  const CertificatePresentation({
    super.key,
    required this.certificates,
  });

  @override
  State<CertificatePresentation> createState() =>
      _CertificatePresentationState();
}

class _CertificatePresentationState
    extends State<CertificatePresentation> {
  int currentIndex = 0;
  bool playing = true;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _schedule();
  }

  void _schedule() {
    timer?.cancel();
    if (playing && widget.certificates.isNotEmpty) {
      timer = Timer.periodic(
        const Duration(seconds: 4),
        (_) {
          if (mounted && playing) {
            setState(() {
              currentIndex =
                  (currentIndex + 1) % widget.certificates.length;
            });
          }
        },
      );
    }
  }

  void _togglePlay() {
    setState(() => playing = !playing);
    _schedule();
  }

  void _next() => setState(() {
        currentIndex =
            (currentIndex + 1) % widget.certificates.length;
      });

  void _previous() => setState(() {
        currentIndex =
            (currentIndex - 1 + widget.certificates.length) %
                widget.certificates.length;
      });

  void _replay() {
    setState(() {
      currentIndex = 0;
      playing = true;
    });
    _schedule();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final certificate = widget.certificates[currentIndex];

    return Scaffold(
      body: AnimatedBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.auto_awesome, color: cyan),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'CERTIFICATE PRESENTATION',
                        style: TextStyle(
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Exit presentation',
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 650),
                      transitionBuilder: (child, animation) =>
                          FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: Tween<double>(
                            begin: 0.94,
                            end: 1,
                          ).animate(animation),
                          child: child,
                        ),
                      ),
                      child: GlassCard(
                        key: ValueKey(currentIndex),
                        padding: const EdgeInsets.all(22),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 950),
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  certificate['image']!,
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, __, ___) =>
                                      const Center(
                                    child: Icon(
                                      Icons.workspace_premium_outlined,
                                      size: 100,
                                      color: purple,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                certificate['title']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                certificate['issuer']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: muted),
                              ),
                              const SizedBox(height: 20),
                              LinearProgressIndicator(
                                value: (currentIndex + 1) /
                                    widget.certificates.length,
                                minHeight: 4,
                                backgroundColor: Colors.white12,
                                valueColor:
                                    const AlwaysStoppedAnimation(cyan),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    OutlinedButton.icon(
                      onPressed: _previous,
                      icon: const Icon(Icons.skip_previous_rounded),
                      label: const Text('Previous'),
                    ),
                    FilledButton.icon(
                      onPressed: _togglePlay,
                      icon: Icon(
                        playing
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                      ),
                      label: Text(playing ? 'Pause' : 'Play'),
                      style: FilledButton.styleFrom(backgroundColor: purple),
                    ),
                    OutlinedButton.icon(
                      onPressed: _next,
                      icon: const Icon(Icons.skip_next_rounded),
                      label: const Text('Next'),
                    ),
                    OutlinedButton.icon(
                      onPressed: _replay,
                      icon: const Icon(Icons.replay_rounded),
                      label: const Text('Replay'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.exit_to_app_rounded),
                      label: const Text('Exit'),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  '${currentIndex + 1} / ${widget.certificates.length}',
                  style: const TextStyle(
                    color: cyan,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ======================= REUSABLE WIDGETS =======================

class InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoChip({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        decoration: BoxDecoration(
          color: purple.withValues(alpha: 0.09),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: purple.withValues(alpha: 0.25),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: cyan),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(color: muted, fontSize: 11),
            ),
          ],
        ),
      );
}

class ActivityTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const ActivityTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: purple.withValues(alpha: 0.13),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: cyan),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  subtitle,
                  style: const TextStyle(color: muted, height: 1.6),
                ),
              ],
            ),
          ),
        ],
      );
}

class HoverCard extends StatefulWidget {
  final Widget child;

  const HoverCard({super.key, required this.child});

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
        onEnter: (_) => setState(() => hovering = true),
        onExit: (_) => setState(() => hovering = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, hovering ? -6 : 0, 0),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: panel.withValues(alpha: hovering ? 0.9 : 0.65),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: hovering
                  ? cyan.withValues(alpha: 0.5)
                  : Colors.white12,
            ),
            boxShadow: hovering
                ? [
                    BoxShadow(
                      color: cyan.withValues(alpha: 0.09),
                      blurRadius: 25,
                    ),
                  ]
                : [],
          ),
          child: widget.child,
        ),
      );
}
