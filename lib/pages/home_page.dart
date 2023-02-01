import 'package:cashier_app_ui/const.dart';
import 'package:cashier_app_ui/model/category.dart';
import 'package:cashier_app_ui/size_config.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

import '../model/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime now = DateTime.now();
  int newIndex = 0;
  PageController controller = PageController();
  int currentProductPage = 0;
  int currentCategoryPage = 0;
  bool moreCategory = false;
  AnimatedContainer indicator({int? index}) {
    return AnimatedContainer(
      duration: Duration(microseconds: 250),
      height: 5,
      width: currentProductPage == index ? 30 : 5,
      decoration: BoxDecoration(
          color: currentProductPage == index ? blue : white,
          borderRadius: BorderRadius.circular(10)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //product

        Container(
          width: SizeConfig.screenWidth! * 0.6,
          // height: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      style: roboto.copyWith(
                          fontSize: 24,
                          color: red,
                          fontWeight: FontWeight.bold),
                      children: [
                        const TextSpan(
                          text: 'OderNo',
                        ),
                        TextSpan(text: '5'.padLeft(3, '0')),
                      ],
                    ),
                  ),
                  Text(
                    DateFormat('EEE, d MMM y, hh:mm aa').format(now),
                    style: const TextStyle(color: grey),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: white),
                width: double.infinity,
                padding: const EdgeInsets.all(5),
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      border: InputBorder.none,
                      hintText: 'Enter item Code',
                      hintStyle: roboto.copyWith(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ...List.generate((products.length / 8).ceil(),
                          (index) => indicator(index: index)),
                    ],
                  ),
                  Text(
                    '${(currentProductPage + 1) * 8 > products.length ? products.length : (currentProductPage + 1) * 8} of ${products.length}',
                    style: roboto.copyWith(
                        fontSize: 16, fontWeight: FontWeight.bold, color: grey),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: PageView(
                  controller: controller,
                  onPageChanged: (value) {
                    setState(() => currentProductPage = value);
                  },
                  children: [
                    ...List.generate(
                      (products.length / 8).ceil(),
                      (indexPage) => Wrap(
                        runSpacing: 5,
                        spacing: 15,
                        children: [
                          ...List.generate(
                              indexPage == (products.length / 8).ceil() - 1
                                  ? products.length % 8
                                  : 8, (int index) {
                            newIndex = index + indexPage * 8;
                            return ProductItem(
                              product: products[newIndex],
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: SizeConfig.screenWidth! * 0.6,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(
                              !moreCategory ? 3 : categories.length,
                              (index) => Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        currentCategoryPage = index;
                                      });
                                    },
                                    child: CategoryItem(
                                        category: categories[index],
                                        active: index == currentCategoryPage),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          moreCategory = !moreCategory;
                        });
                      },
                      child: Center(
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(color: blue, boxShadow: [
                            BoxShadow(
                                color: lightBlue.withOpacity(0.5),
                                offset: const Offset(0, 10),
                                spreadRadius: 0,
                                blurRadius: 5),
                          ]),
                          child: moreCategory
                              ? const Icon(Icons.close)
                              : const Icon(Icons.more_horiz),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        //cart
        Container(
          width: SizeConfig.screenWidth! * 0.22,
          height: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Card(child: Text('adasda')),
        ),
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  final Categories category;
  final bool active;
  const CategoryItem({
    super.key,
    required this.category,
    required this.active,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: active ? blue : white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: active ? blue : white,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/${category.image}',
                ),
              ),
            ),
          ),
          Text(category.text!),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: white,
      ),
      height: 230,
      width: 180,
      child: Column(children: [
        Container(
          height: 180,
          width: 180,
          decoration: const BoxDecoration(
            color: white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 5),
                  spreadRadius: 0,
                  blurRadius: 1,
                  color: bgColor),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: DropShadow(
              child: Image.asset(
                'assets/${product.image}',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Text(
          product.name!,
          style: roboto.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }
}
