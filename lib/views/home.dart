import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yemen_travel_guid/views/screens/guide_page.dart';
import 'package:yemen_travel_guid/views/screens/home_page.dart';
import 'package:yemen_travel_guid/views/screens/map_page.dart';
import 'package:yemen_travel_guid/views/screens/trips/trips_page.dart';
import 'package:yemen_travel_guid/views/screens/users/profile_page.dart';

class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(()  {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _selectedIndex==0 ? Homepage():
      _selectedIndex==1 ? GuidePage():
      _selectedIndex==2 ? MapPage():
      _selectedIndex==3 ? TripsPage():
      _selectedIndex==4 ? ProfilePage():
      Homepage(),


      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        height: 55,
        color: Color(0xFFECE0D9),
        backgroundColor: Color(0x47FFFFFF),
        items: <Widget>[
          SvgPicture.asset(
            height: 30,
            width: 30,
            'assets/images/home/home.svg',
            fit: BoxFit.cover,
          ),
          SvgPicture.asset(
            height: 30,
            width: 30,
            'assets/images/home/search.svg',
            fit: BoxFit.cover,
          ),
          SvgPicture.asset(

            'assets/images/home/mapappbar.svg',
            fit: BoxFit.cover,
          ),
          SvgPicture.asset(
            height: 30,
            width: 30,
            'assets/images/home/pakeg.svg',
            fit: BoxFit.cover,
          ),
          SvgPicture.asset(
            height: 30,
            width: 30,
            'assets/images/home/acount.svg',
            fit: BoxFit.cover,
          ),
        ],
        onTap: (index) {
          _onItemTapped(index);
        },
      ),
    );
  }
}