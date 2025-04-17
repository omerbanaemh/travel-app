import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yemen_travel_guid/views/screens/guide_page.dart';
import 'package:yemen_travel_guid/views/screens/home_page.dart';
import 'package:yemen_travel_guid/views/screens/map_page.dart';
import 'package:yemen_travel_guid/views/screens/search/search_page.dart';
import 'package:yemen_travel_guid/views/screens/trips/trips_page.dart';
import 'package:yemen_travel_guid/views/screens/login/profile_page.dart';

class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(()  {
      // unauthorizedLogout(context);
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex==0 ? const Homepage():
      _selectedIndex==1 ? const GuidePage():
      _selectedIndex==2 ? const MapPage():
      _selectedIndex==3 ? const TripsPage():
      _selectedIndex==4 ? const SearchPage():
      _selectedIndex==5 ? const ProfilePage() :
      const Homepage(),


      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        height: 55,
        color: const Color(0xFFECE0D9),
        backgroundColor: const Color(0x47FFFFFF),
        items: <Widget>[
          SvgPicture.asset(
            height: 30,
            width: 30,
            'assets/images/home/home.svg',
            fit: BoxFit.cover,
          ),
          Image.asset(
            height: 30,
            width: 30,
            'assets/images/home/learn.png',
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
          const Icon(
            Icons.search,
            color: Color(0xFF9B683F),
            size: 33,
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