import 'package:befit_ai_app/view/auth/sign_up.dart';
import 'package:flutter/material.dart';
class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: "Physical Fitness",
      description: "Get fit, stay healthy, and enhance your life.",
      image: 'assets/img/n7fsk9h8.png',
    ),
    OnboardingPage(
      title: "Mental Well-being",
      description: "Focus on your mental health and find your balance.",
      image: 'assets/img/img_2.png',
    ),
    OnboardingPage(
      title: "Nutrition",
      description: "Fuel your body with the right nutrients.",
      image: 'assets/img/img_4.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemCount: _pages.length,
        itemBuilder: (context, index) {
          return OnboardingContent(page: _pages[index]);
        },
      ),
      bottomSheet: _currentIndex == _pages.length - 1
          ? ElevatedButton(

        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignUp()));
        },
        child: Text('Get Started'),
      )
          :
         ElevatedButton(
          onPressed: () {
            _controller.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          },
          child: Text('Next'),

      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final String image;

  OnboardingPage({required this.title, required this.description, required this.image});
}

class OnboardingContent extends StatelessWidget {
  final OnboardingPage page;

  const OnboardingContent({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          page.image,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              page.title,
              style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                page.description,
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}