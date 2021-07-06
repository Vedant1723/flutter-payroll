import 'package:flutter/material.dart';
import 'package:payroll/components/Auth/LoginPage.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  PageController? _pageController;

  List imageContent = [
    "images/payroll.png",
    "images/employee.png",
    "images/attendance.png",
  ];

  List titleContent = [
    "Easy Salary Management",
    "Easy Employee Management",
    "Easy Attendance Management"
  ];

  List descriptionContnet = [
    "Payroll Application will help you to manage the Salary of Employee with so much ease",
    "Payroll Application will help you to manage the Employee and there data with so much ease",
    "Payroll Application will help you to manage the Attendance with so much ease"
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: _pageController,
                itemCount: 3,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Column(
                      children: [
                        Image(
                            image: AssetImage(imageContent[i]),
                            height: 300,
                            fit: BoxFit.fill),
                        Text(
                          titleContent[i],
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          descriptionContnet[i],
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  );
                }),
          ),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) => buildDots(index, context)),
          )),
          Container(
            height: 60,
            margin: EdgeInsets.all(40),
            width: double.infinity,
            color: Colors.black,
            child: MaterialButton(
              child: Text(currentIndex == 2 ? 'Continue' : "Next"),
              onPressed: () {
                if (currentIndex == 2) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()));
                }
                _pageController?.nextPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.bounceIn);
              },
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
            ),
          )
        ],
      ),
    );
  }

  Container buildDots(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
    );
  }
}
