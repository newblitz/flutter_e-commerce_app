import 'package:flutter/material.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/theme.dart';

import '../../constants.dart';
import '../sign_in/sign_in_screen.dart';
import 'components/splash_content.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  int currentPage = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Crux, Let's shop!",
      "image": "assets/images/splash_1.png"
    },
    {
      "text": "We help people connect with stores \naround the world",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": "assets/images/splash_3.png"
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: IconButton(
                    icon: Icon(
                      Theme.of(context).brightness == Brightness.dark
                          ? Icons.light_mode
                          : Icons.dark_mode,
                    ),
                    onPressed: () async {
                      final isDark = Theme.of(context).brightness == Brightness.dark;
                      await AppTheme.setDarkMode(!isDark);
                      if (mounted) {
                        final appState = context.findAncestorStateOfType<MyAppState>();
                        appState?.toggleTheme();
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => FadeTransition(
                    opacity: _animation,
                    child: SplashContent(
                      image: splashData[index]["image"],
                      text: splashData[index]['text'],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => AnimatedContainer(
                            duration: kAnimationDuration,
                            margin: const EdgeInsets.only(right: 5),
                            height: 6,
                            width: currentPage == index ? 20 : 6,
                            decoration: BoxDecoration(
                              color: currentPage == index
                                  ? kPrimaryColor
                                  : Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white70
                                      : const Color(0xFFD8D8D8),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 3),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SignInScreen.routeName);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "Continue",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
