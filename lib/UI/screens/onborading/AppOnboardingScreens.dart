import 'package:evently/UI/design/design.dart';
import 'package:evently/UI/screens/onborading/CustomLayout.dart';
import 'package:evently/routes.dart';
import 'package:flutter/material.dart';

class AppOnboardingScreen extends StatefulWidget {
  const AppOnboardingScreen({super.key});

  @override
  State<AppOnboardingScreen> createState() => _AppOnboardingScreenState();
}

class _AppOnboardingScreenState extends State<AppOnboardingScreen> {
  late PageController _pageViewController;
  int _currentPageIndex = 0;

  final int _numPages = 3;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        PageView(
          controller: _pageViewController,
          onPageChanged: (index) {
            setState(() => _currentPageIndex = index);
          },
          children: <Widget>[
            CustomLayout(
              image: AppImages.onboarding01,
              mainText: "Find Events That Inspire You",
              subText:
                  "Dive into a world of events crafted to fit your unique interests. "
                  "Whether you're into live music, art workshops, professional networking, "
                  "or simply discovering new experiences, we have something for everyone. "
                  "Our curated recommendations will help you explore, "
                  "connect, and make the most of every opportunity around you.",
            ),

            CustomLayout(
              image: AppImages.onboarding02,
              mainText: "Effortless Event Planning",
              subText:
                  "Take the hassle out of organizing events with our all-in-one planning tools."
                  " From setting up invites and managing RSVPs to scheduling reminders and coordinating details,"
                  " we’ve got you covered. Plan with ease and focus on what matters –"
                  " creating an unforgettable experience for you and your guests.",
            ),

            CustomLayout(
              image: AppImages.onboarding03,
              mainText: "Connect with Friends & Share Moments",
              subText:
                  "Make every event memorable by sharing the experience with others."
                  " Our platform lets you invite friends, keep everyone in the loop,"
                  " and celebrate moments together. Capture and share the excitement with your network,"
                  " so you can relive the highlights and cherish the memories.",
            ),
          ],
        ),
        PageIndicator(
          currentPageIndex: _currentPageIndex,
          numPages: _numPages,
          onNext: () {
            if (_currentPageIndex == _numPages - 1) {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.RegisterScreen.routeName,
              );
            } else {
              _pageViewController.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            }
          },
          onBack: () {
            if (_currentPageIndex > 0) {
              _pageViewController.previousPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            }
          },
        ),
      ],
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.currentPageIndex,
    required this.numPages,
    required this.onNext,
    required this.onBack,
  });

  final int currentPageIndex;
  final int numPages;
  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Back button
          IconButton(
            onPressed: currentPageIndex == 0 ? null : onBack,
            icon: Icon(
              Icons.arrow_back,
              size: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          // Dots
          Row(
            children: List.generate(numPages, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentPageIndex == index
                      ? Theme.of(context).colorScheme.primary
                      : const Color(0XFF1C1C1C),
                ),
              );
            }),
          ),

          // Next / Finish button
          IconButton(
            onPressed: onNext,
            icon: Icon(
              Icons.arrow_forward,
              size: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
