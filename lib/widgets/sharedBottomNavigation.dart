import 'package:flutter/material.dart';

class SharedBottomNavigation extends StatefulWidget
    implements PreferredSizeWidget {
  SharedBottomNavigation({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _SharedBottomNavigationState createState() => _SharedBottomNavigationState();
}

class _SharedBottomNavigationState extends State<SharedBottomNavigation> {
  final Color inactiveMenuColor = Colors.black;
  final Color activeButtonColor = Colors.purple;

  final List routes = [
    {
      "name": 'Dashboard',
      "icon": Icons.dashboard,
    },
    {
      "name": 'People',
      "icon": Icons.people,
    },
    {
      "name": 'Events',
      "icon": Icons.star,
    },
    {
      "name": 'Comparision',
      "icon": Icons.history,
    },
    {
      "name": 'Settings',
      "icon": Icons.settings,
    }
  ];

  generateNavigationItems() {
    List items = [];
    for (int i = 0; i < routes.length; i++) {
      String name = '/' + routes[i]['name'];

      items.add(BottomNavigationBarItem(
          icon: IconButton(
            icon: Icon(
              routes[i]['icon'],
              color: ModalRoute.of(context).settings.name == name
                  ? activeButtonColor
                  : inactiveMenuColor,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, name);
            },
          ),
          title: Text(
            '',
            style: TextStyle(fontSize: 0),
          )));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    var navigationItems = this.generateNavigationItems();

    return SizedBox(
        height: 60,
//        backgroundColor: Colors.deepPurpleAccent,
        child: BottomNavigationBar(
          selectedFontSize: 0,
          items: [
            ...navigationItems,
          ],
        ));
  }
}
