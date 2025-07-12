import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   _moveToNextPage();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFEFE),
        body: IntroductionScreen(
          pages: [
            PageViewModel(
                title: 'Welcome to Task Manager',
                body: 'Manage your tasks efficiently and stay organized.',
                image: Image.asset('assets/images/img_01.jpg')),
            PageViewModel(
                title: 'Boost Productivity',
                body:
                    'Track your daily tasks effortlessly and boost productivity.\nStay on top of your goals with ease.',
                image: Image.asset('assets/images/img_02.jpg')),
            PageViewModel(
                title: 'Stay Focused',
                body:
                    'Stay focused and achieve your goals effortlessly.\nYour tasks, your way, all in one place.',
                image: Image.asset('assets/images/img_03.jpg')),
          ],
          onDone: _moveToNextPage,
          done: const Text('Done'),
          showNextButton: true,
          next: const Text('Next'),
          showSkipButton: true,
          onSkip: _moveToNextPage,
          skip: const Text('Skip'),
          dotsDecorator: DotsDecorator(
              size: const Size(10.0, 10.0),
              color: Colors.grey,
              activeSize: const Size(22.0, 10.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
        ));
  }

  void _moveToNextPage() {
    Navigator.pushReplacementNamed(context, '/loginScreen');
  }
}
