import 'package:flutter/material.dart';
import 'package:pharmaconnectbyturjo/Contains/PopularProduct.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 40,
                //color: Colors.red,
                child: Row(children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    child: Image.asset(
                      "assets/icon/Notification.png",
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    child: Image.asset(
                      "assets/icon/chat.png",
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "New Products",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "See More",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                      )
                    ]),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFECDF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset("assets/icon/PersonalHygine.png"),
                        ),
                        const SizedBox(height: 4),
                        Text("Personal\nCare", textAlign: TextAlign.center)
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFECDF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset("assets/icon/BabyCare.png"),
                        ),
                        const SizedBox(height: 4),
                        Text("Baby\nCare", textAlign: TextAlign.center)
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFECDF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset("assets/icon/SurgicalProduct.png"),
                        ),
                        const SizedBox(height: 4),
                        Text("Surgical\nProduct", textAlign: TextAlign.center)
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFECDF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset("assets/icon/WomenCare.png"),
                        ),
                        const SizedBox(height: 4),
                        Text("Women \nCare", textAlign: TextAlign.center)
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFECDF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset("assets/icon/floss.png"),
                        ),
                        const SizedBox(height: 4),
                        Text("Detal\nCare", textAlign: TextAlign.center)
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFECDF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset("assets/icon/More.png"),
                        ),
                        const SizedBox(height: 4),
                        Text("More\n", textAlign: TextAlign.center)
                      ],
                    ),
                  ),
                ],
              ),
              PopularProduct(),
            ],
          ),
        ),
      ),
    );
  }
}
