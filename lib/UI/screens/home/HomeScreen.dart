import 'package:evently/UI/provider/AuthenticationProvider.dart';
import 'package:evently/UI/screens/tabs/home_tab.dart';
import 'package:evently/UI/screens/tabs/maps_tab.dart';
import 'package:evently/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../tabs/favorite_tab.dart';
import '../tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentBottomNavIndex = 0;
  late List<Widget> taps;

  @override
  void initState() {
    super.initState();
    taps = [
      HomeTab(),
      MapsTab(),
      Container(),
      FavoriteTab(),
      ProfileTab()
    ];
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider provider = Provider.of<AuthenticationProvider>(
      context,
    );
    var user = provider.getUser();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        automaticallyImplyLeading: false,
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .primary,
        foregroundColor: Colors.white,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (user?.name?.isEmpty == false) ...[
              //separated operator
              Text(
                "Welcome Back ✨",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  fontFamily: GoogleFonts
                      .inter()
                      .fontFamily,
                  color: Colors.white,
                ),
              ),
              Text(
                user?.name ?? "",
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),

              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Cairo , Egypt",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      fontFamily: GoogleFonts
                          .inter()
                          .fontFamily,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ] else
              CircularProgressIndicator(),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              provider.logout();
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.OnboardingScreen.routeName,
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(child: taps[currentBottomNavIndex])
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: currentBottomNavIndex,
        onTap: (index) {
          setState(() {
            currentBottomNavIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            activeIcon: Icon(Icons.location_on),
            label: "Map",
          ), BottomNavigationBarItem(
            icon: SizedBox(),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_rounded),
            activeIcon: Icon(Icons.favorite),
            label: "Love",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.AddEventScreen.routeName);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(360),
            side: BorderSide(
                color: Colors.white,
                width: 4
            )
        ),
        elevation: 0,
        child: Icon(Icons.add),
      ),
    );
  }
}

//SvgPicture.asset( AppIcons.home ,
// colorFilter : ColorFilter.mode(color , blend mode)
// color , blendMode.scrIn
