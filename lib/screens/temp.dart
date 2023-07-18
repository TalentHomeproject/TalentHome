import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String btnName = "Click me";
  String btnName2 = "Click second";
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: _appbar(),
        body: Center(
          child: currentIndex == 0
              ? _homePage()
              : currentIndex == 1
                  ? _settingsPage()
                  : _profilePage(),
        ),
        bottomNavigationBar: _bottomNav(),
      ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      leading: Icon(
        Icons.list,
        size: 30.0,
      ),
      title: Text("App Title"),
    );
  }

  Container _homePage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromARGB(239, 227, 224, 224),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.orange,
            ),
            onPressed: () {
              setState(() {
                btnName = "Been clicked";
              });
            },
            child: Text(btnName),
          ),
          const SizedBox(
            height: 20,
            width: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
            ),
            onPressed: () {
              setState(() {
                btnName2 = "Clicked too";
              });
            },
            child: Text(btnName2),
          ),
        ],
      ),
    );
  }

  Container _profilePage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.lightBlue,
      child: Image.asset('assets/images/notes.jpg'),
    );
  }

  Container _settingsPage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.lightBlue,
      child: Image.asset('assets/images/yoda.png'),
    );
  }

  BottomNavigationBar _bottomNav() {
    return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              Icons.home,
              color: Colors.blue,
              size: 30.0,
            ),
          ),
          BottomNavigationBarItem(
            label: "Settings",
            icon: Icon(
              Icons.settings,
              color: Colors.green,
              size: 30.0,
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(
              Icons.favorite,
              color: Colors.pink,
              size: 30.0,
            ),
          ),
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        });
  }
}
