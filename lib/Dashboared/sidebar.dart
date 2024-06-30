

import 'package:flutter/material.dart';
import 'package:myproject/Dashboared/Chat%20room/dashbored_chat.dart';
import 'package:myproject/Dashboared/Employee/employess_screen.dart';
import 'package:myproject/Dashboared/Dashboared/Screens/Home_screen.dart';
import 'package:myproject/Authentication/login_screen.dart';
import 'package:myproject/Dashboared/Pump%20Card%20Dahsboared/account_request_screen.dart';
import 'package:myproject/Dashboared/Pump%20Card%20Dahsboared/petrol_price.dart';
import 'package:myproject/Dashboared/Pump%20Reg/pump_reg.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.teal, // Changed background color
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white, // Changed header background color
              ),
              child: Image.asset(
                "assets/splashLogo.jpg", // Your logo image
                fit: BoxFit.contain,
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.dashboard,
                color: Colors.white, // Changed icon color
              ),
              title: const Text(
                'Dashboard',
                style: TextStyle(color: Colors.white), // Changed text color
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DashboardOwnerScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.perm_data_setting,
                color: Colors.white,
              ),
              title: const Text(
                'Employee Management',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EmployeeScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.price_change,
                color: Colors.white,
              ),
              title: const Text(
                'Petrol Price',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PetrolPriceScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.account_box,
                color: Colors.white,
              ),
              title: const Text(
                'Requested Accounts',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountRequested()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.chat,
                color: Colors.white,
              ),
              title: const Text(
                'Chat Room',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DashbordChat()),
                );
              },
            ),
              ListTile(
              leading: const Icon(
                Icons.chat,
                color: Colors.white,
              ),
              title: const Text(
                'Register a Pump',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PumpRegScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
