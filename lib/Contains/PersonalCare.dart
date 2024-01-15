import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmaconnectbyturjo/Contains/PopularProduct.dart';
import 'package:pharmaconnectbyturjo/Contains/Categories.dart';


class PersonalProduct extends StatefulWidget {
  const PersonalProduct({Key? key}) : super(key: key);

  @override
  State<PersonalProduct> createState() => _PersonalProductState();
}

class _PersonalProductState extends State<PersonalProduct> {
  final List<Map<String, dynamic>> PersonalCare = [
    {
      "product_id": 41,
      "title": "Dettol Handwash Re-Energize Bottle With Push-Pull Cap200ml",
      "product_type": "Reckitt Benckiser Bangladesh Ltd.",
      "price": "\u09f3104.50",
      "images": "assets/Medicine/41.png"
    },
    {
      "product_id": 42,
      "title": "Sepnil Sanitizing Hand Wash(Marigold)200ml",
      "product_type": "Square Toiletries Limited",
      "price": "\u09f394.50",
      "images": "assets/Medicine/42.png"
    },

    {
      "product_id": 48,
      "title": "Dettol Handwash Skincare Liquid Soap Refill170ml",
      "product_type": "Reckitt Benckiser Bangladesh Ltd.",
      "price": "\u09f371.25",
      "images": "assets/Medicine/48.png"
    },
    {
      "product_id": 49,
      "title": "Lizol Floor Cleaner Floral Disinfectant Surface Cleaner500ml",
      "product_type": "Reckitt Benckiser Bangladesh Ltd.",
      "price": "\u09f3152.00",
      "images": "assets/Medicine/49.png"
    },
    {
      "product_id": 50,
      "title": "Dettol Handwash Re-Energize Liquid Refill(2 in 1 Box) Combo170ml",
      "product_type": "Reckitt Benckiser Bangladesh Ltd.",
      "price": "\u09f3142.50",
      "images": "assets/Medicine/50.png"
    },
    {
      "product_id": 51,
      "title": "Sepnil Sanitizing Hand Wash (Tea Oil) Refill170ml",
      "product_type": "Square Toiletries Limited",
      "price": "\u09f367.50",
      "images": "assets/Medicine/51.png"
    },
    {
      "product_id": 58,
      "title": "Dettol Handwash Aloe Vera Bottle With Push-Pull Cap",
      "product_type": "Reckitt Benckiser Bangladesh Ltd.",
      "price": "\u09f3104.50",
      "images": "assets/Medicine/58.png"
    },
    {
      "product_id": 59,
      "title": "Savlon Mild Antiseptic Soap 75gm75gm",
      "product_type": "ACI Consumer",
      "price": "\u09f347.50",
      "images": "assets/Medicine/59.png"
    },
    {
      "product_id": 60,
      "title": "Sepnil Sanitizing Hand Wash (Apple)Flavor:Apple",
      "product_type": "Square Toiletries Limited",
      "price": "\u09f394.05",
      "images": "assets/Medicine/60.png"
    },
    {
      "product_id": 61,
      "title": "Dettol Liquid 50ml50ml",
      "product_type": "Reckitt Benckiser Bangladesh Ltd.",
      "price": "\u09f342.75",
      "images": "assets/Medicine/61.png"
    },
    {
      "product_id": 62,
      "title": "Sepnil Sanitizing Hand Wash(Tea Oil)200ml",
      "product_type": "Square Toiletries Limited",
      "price": "\u09f389.10",
      "images": "assets/Medicine/62.png"
    },



  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          mainAxisExtent: 270,
        ),
        itemCount: PersonalCare.length,
        itemBuilder: (_, index) {
          print(PersonalCare.elementAt(index)['images']);
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
                        PersonalCare.elementAt(index)['images'],
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
                          "${PersonalCare.elementAt(index)['title']}",
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
                          "${PersonalCare.elementAt(index)['price']}",
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

