import 'package:flutter/material.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Map<String, String>> onboardingData = [
    {
      'title': 'Welcome to MondaeAI',
      'text': 'Your personal AI assistant',
      'image': 'assets/images/Group 11.png'
    },
    {
      'title': 'Generate Content',
      'text': 'Create images, text, and charts',
      'image': 'assets/images/Group 11.png'
    },
    {
      'title': 'Stay Organized',
      'text': 'Manage your archives and history',
      'image': 'assets/images/Group 11.png'
    },
  ];

  void _onNextPressed() {
    if (_currentPage == onboardingData.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _onBackPressed() {
    if (_currentPage == 0) {
      Navigator.pop(context);
    } else {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  _currentPage = value;
                });
              },
              itemCount: onboardingData.length,
              itemBuilder: (context, index) => OnboardingContent(
                title: onboardingData[index]['title']!,
                text: onboardingData[index]['text']!,
                image: onboardingData[index]['image']!,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingData.length,
                          (index) => buildDot(index: index),
                    ),
                  ),
                  const Spacer(flex: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_currentPage > 0)
                        ElevatedButton(
                          onPressed: _onBackPressed,
                          child: const Text('Back'),
                        ),
                      if (_currentPage < onboardingData.length - 1)
                        ElevatedButton(
                          onPressed: _onNextPressed,
                          child: const Text('Next'),
                        ),
                      if (_currentPage == onboardingData.length - 1)
                        ElevatedButton(
                          onPressed: _onNextPressed,
                          child: const Text('Start'),
                        ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: _currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String title, text, image;

  const OnboardingContent({
    super.key,
    required this.title,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        SizedBox(
          height: 400,  // Set the desired height
          width: double.infinity,
          child: Image(
            image: AssetImage(image),
            fit: BoxFit.cover,  // Adjust the fit as necessary
          ),
        ),
        const Spacer(),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: OnboardingScreen(),
  ));
}
