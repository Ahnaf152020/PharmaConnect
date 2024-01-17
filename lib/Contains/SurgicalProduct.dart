import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmaconnectbyturjo/Contains/PopularProduct.dart';
import 'package:pharmaconnectbyturjo/Contains/Categories.dart';



class SurgicalProduct extends StatefulWidget {
  const SurgicalProduct({Key? key}) : super(key: key);

  @override
  State<SurgicalProduct> createState() => _SurgicalProductState();
}

class _SurgicalProductState extends State<SurgicalProduct> {
  final List<Map<String, dynamic>> SurgicalProduct = [
    {
      "product_id": 26,
      "title": "Surgical Face Mask Type IBeximco Health",
      "product_type": "Beximco Pharmaceuticals Ltd.",
      "price": "\u09f3340.00",
      "images": "assets/Medicine/26.png"
    },
    {
      "product_id": 27,
      "title": "Medical Surgical Head Cap Mop Clip Head Cover/Caps-Sky Blue",
      "product_type": "Surgical Kit",
      "price": "\u09f32.70",
      "images": "assets/Medicine/27.png"
    },
    {
      "product_id": 80,
      "title": "Sepnil Face Mask Skin ColorSkin Color",
      "product_type": "Square Toiletries Limited",
      "price": "\u09f3280.00",
      "images": "assets/Medicine/80.png"
    },
    {
      "product_id": 86,
      "title": "Thermometer Digital Flexible Tip(Bioband)",
      "product_type": "Bioband Safetymatics Co",
      "price": "\u09f3198.00",
      "images": "assets/Medicine/86.png"
    },
    {
      "product_id": 96,
      "title": "Fashionable Face Mask For MenColor Family-Black (Free Size)",
      "product_type": "Surgical Kit",
      "price": "\u09f3110.00",
      "images": "assets/Medicine/96.png"
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
        itemCount: SurgicalProduct.length,
        itemBuilder: (_, index) {
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
                        SurgicalProduct.elementAt(index)['images'],
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
                          "${SurgicalProduct.elementAt(index)['title']}",
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
                          "${SurgicalProduct.elementAt(index)['price']}",
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

