import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopularProduct extends StatefulWidget {
  const PopularProduct({Key? key}) : super(key: key);

  @override
  State<PopularProduct> createState() => _PopularProductState();
}

class _PopularProductState extends State<PopularProduct> {
  final List<Map<String, dynamic>> PopularProduct = [
    {
      "title": "Medicine 1",
      "price": "\৳255",
      "images": "assets/Medicine/medicine (1).png",
    },
    {
      "title": "Medicine 2",
      "price": "\৳245",
      "images": "assets/Medicine/medicine (2).png",
    },
    {
      "title": "Medicine 3",
      "price": "\৳155",
      "images": "assets/Medicine/medicine (3).png",
    },
    {
      "title": "Medicine 4",
      "price": "\৳275",
      "images": "assets/Medicine/medicine (4).png",
    },
    {
      "title": "Medicine 5",
      "price": "\৳25",
      "images": "assets/Medicine/medicine (5).png",
    },
    {
      "title": "Medicine 6",
      "price": "\৳27",
      "images": "assets/Medicine/medicine (6).png",
    },
    {
      "title": "Medicine 7",
      "price": "\৳55",
      "images": "assets/Medicine/medicine (7).png",
    },
    {
      "title": "Medicine 8",
      "price": "\৳85",
      "images": "assets/Medicine/medicine (8).png",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          mainAxisExtent: 310,
        ),
        itemCount: PopularProduct.length,
        itemBuilder: (_, index) {
          print(PopularProduct.elementAt(index)['images']);
          return Container(
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
                      PopularProduct.elementAt(index)['images'],
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
                        "${PopularProduct.elementAt(index)['title']}",
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
                        "${PopularProduct.elementAt(index)['price']}",
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
          );
        },
      ),
    );
  }
}
