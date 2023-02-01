import 'package:cashier_app_ui/const.dart';
import 'package:cashier_app_ui/model/menu.dart';
import 'package:cashier_app_ui/pages/home_page.dart';
import 'package:cashier_app_ui/size_config.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentMenu = 0;
  Widget body(int c) {
    switch (c) {
      case 0:
        return HomePage();

      case 1:
        return const Center(
          child: Text('Transaction'),
        );
      case 2:
        return const Center(
          child: Text('Value'),
        );

      default:
        return const Center(
          child: Text('End'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: darkBlue,
      body: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: SizeConfig.screenWidth! * 0.15,
            height: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
              // color: blue,
            ),
            child: Column(
              children: [
                ...List.generate(
                    menus.length,
                    (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentMenu = index;
                            });
                          },
                          child: MenuItem(
                            menu: menus[index],
                            active: _currentMenu == index,
                          ),
                        )),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 20, 20),
            width: SizeConfig.screenWidth! * 0.85 - 20,
            // height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: bgColor,
            ),
            child: body(_currentMenu),
          )
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final Menu menu;
  final bool active;
  const MenuItem({
    super.key,
    required this.menu,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: active ? white : Colors.transparent,
          borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.all(5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            menu.icon,
            color: active == true ? blue : white,
          ),
          Text(
            menu.text,
            style: roboto.copyWith(
                color: active == true ? red : white,
                fontWeight: FontWeight.bold),
          ),
          // const SizedBox(width: 10),
        ],
      ),
    );
  }
}
