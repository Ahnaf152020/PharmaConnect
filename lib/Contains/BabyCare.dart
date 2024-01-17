import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmaconnectbyturjo/Contains/PopularProduct.dart';
import 'package:pharmaconnectbyturjo/Contains/Categories.dart';


class BabyProduct extends StatefulWidget {
  const BabyProduct({Key? key}) : super(key: key);

  @override
  State<BabyProduct> createState() => _BabyProductState();
}

class _BabyProductState extends State<BabyProduct> {
  final List<Map<String, dynamic>> BabyCare = [
    {
      "product_id": 1,
      "title": "Clungene Covid-19 Rapid Antigen Test KitSARS-CoV-2",
      "product_type": "",
      "price": "\u09f3699.00",
      "images": "assets/Medicine/1.png"
    },
    {
      "product_id": 2,
      "title": "Alcohol Pad",
      "product_type": "Surgical Kit",
      "price": "\u09f372.00",
      "images": "assets/Medicine/2.png"
    },
    {
      "product_id": 3,
      "title": "Rossmax Fingertip Pulse Oximeter SB-100SB-100",
      "product_type": "",
      "price": "\u09f33080.00",
      "images": "assets/Medicine/3.png"
    },
    {
      "product_id": 4,
      "title": "Baby Face Mask1s",
      "product_type": "Surgical Kit",
      "price": 0,
      "images": "assets/Medicine/4.png"
    },
    {
      "product_id": 5,
      "title": "Thermometer Digital Flexible TipFlexible Tip",
      "product_type": "",
      "price": "\u09f3120.00",
      "images": "assets/Medicine/5.png"
    },
    {
      "product_id": 6,
      "title": "Sepnil Face MaskBlue Color",
      "product_type": "Square Toiletries Limited",
      "price": "\u09f3280.00",
      "images": "assets/Medicine/6.png"
    },
    {
      "product_id": 7,
      "title": "Turaag ProteX Three Layered Face Protection Mask For MenAntiviral High Performance Face Mask",
      "product_type": "Unimed Unihealth Pharmaceuticals Ltd.",
      "price": "\u09f3160.00",
      "images": "assets/Medicine/7.png"
    },
    {
      "product_id": 8,
      "title": "N95 Mask Particulate Respirator Face MaskModel-1860",
      "product_type": "Surgical Kit",
      "price": "\u09f3299.00",
      "images": "assets/Medicine/8.png"
    },
    {
      "product_id": 9,
      "title": "Paxovir150mg+100mg",
      "product_type": "Eskayef Pharmaceuticals Ltd.",
      "price": "\u09f33040.00",
      "images": "assets/Medicine/9.png"
    },
    {
      "product_id": 10,
      "title": "Face Shield Glass Type-Smart Protective Safety With Frame(1Pc)",
      "product_type": "Surgical Kit",
      "price": 0,
      "images": "assets/Medicine/10.png"
    },




  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:SingleChildScrollView(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          mainAxisExtent: 270,
        ),
        itemCount: BabyCare.length,
        itemBuilder: (_, index) {
          print(BabyCare.elementAt(index)['images']);
          return SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  16.0,
                ),
                color: const Color(0xFFFFECDF),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        BabyCare.elementAt(index)['images'],
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${BabyCare.elementAt(index)['title']}",
                          style: Theme.of(context).textTheme.subtitle1!.merge(
                            const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "${BabyCare.elementAt(index)['price']}",
                          style: Theme.of(context).textTheme.subtitle2!.merge(
                            TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 00, right: 00),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.heart,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.cart,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    )
    );
  }
}

