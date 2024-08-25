import 'package:flutter/material.dart';
import 'package:newswave/pages/homepage.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            height: size.height / 1.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                    image: AssetImage('images/landpage.jpeg'),
                    fit: BoxFit.fill)),
          ),
          SizedBox(height: 15),
          Text(
            'Explore the Latest Global News for You',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Ideal moment for reading: take your time to delve deeper into this vast world.',
              style: TextStyle(
                  color: Colors.grey[600], fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.all(40),
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/home',
                  );
                },
                child: Text(
                  'Get Started',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                )),
          )
        ],
      ),
    );
  }
}
