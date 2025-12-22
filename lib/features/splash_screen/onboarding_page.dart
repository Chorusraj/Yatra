import 'package:flutter/material.dart';
import 'package:yatra/core/constants/app_color.dart';
import 'package:yatra/core/constants/app_string.dart';
import 'package:yatra/features/auth/pages/login_page.dart';
import 'package:yatra/features/splash_screen/onboard_screen.dart';
import 'package:yatra/features/widgets/custom_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: Column(
          children: [
            // Expanded PageView area
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() => currentIndex = index);
                },
                children: [
                  OnboardScreen(
                    image: "assets/images/yatra1.png",
                    title: onboardingLabel,
                    highLightWord: highLightWordLabel,
                    subtitle: subtitleLabel,
                  ),
                  OnboardScreen(
                    image: "assets/images/yatra1.png",
                    title: onboarding1Label,
                    highLightWord: highLightWord1Label,
                    subtitle: subtitle1Label,
                  ),
                  OnboardScreen(
                    image: "assets/images/yatra1.png",
                    title: onboarding2Label,
                    highLightWord: highLightWord2Label,
                    subtitle: subtitle1Label,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Page indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: currentIndex == index ? 18 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? primaryColor
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            // Button
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 25),
              child: CustomButton(
                backgroundColor: primaryColor,
                borderRadius: 8,
                onPressed: () {
                  if (currentIndex == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  } else {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Text(
                  currentIndex == 2 ? getStartedLabel : nextLabel,
                  style: TextStyle(fontSize: 16, color: secondaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
