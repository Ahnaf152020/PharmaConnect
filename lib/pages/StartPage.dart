import 'package:animate_do/animate_do.dart';
import 'package:pharma_connect/pages/loginPage.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(

          child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/getstart_page.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 450,
              ),
              FadeInUp(
                delay: Duration(milliseconds: 1000),
                duration: Duration(milliseconds: 1000),
                child: Text(
                  "Pharma \nConnect",
                  style: GoogleFonts.robotoSlab(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FadeInUp(
                delay: Duration(milliseconds: 1200),
                duration: Duration(milliseconds: 1000),
                child: Text(
                  "Are you ready to learn languages \neasily in the funniest way?",
                  style: GoogleFonts.robotoSlab(
                    fontSize: 16,
                    height: 1.8,
                    color: Colors.white70,
                  ),
                ),
              ),
              FadeInUp(
                delay: Duration(milliseconds: 1300),
                duration: Duration(milliseconds: 1000),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 00, vertical: 50),
                  child: Row(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding:
                            EdgeInsets.only(left: 25, right: 25, bottom: 4),
                        child: Container(
                          width: 300,
                          height: 55,
                          child: Center(
                            child: Text(
                              "Get Started",
                              style: GoogleFonts.robotoSlab(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      )
    );

  }
}
