// import 'package:flutter/material.dart';
// import 'package:myproject/Common/constant.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints constraints) {
//           return Center(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const Image(
//                     fit: BoxFit.fill,
//                     image: AssetImage("assets/splashLogo.jpg"),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(top: 20),
//                     child: Text(
//                       'Welcome to PetroLink',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.black,
//                         fontWeight: FontWeight.w300,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 50),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       fixedSize: const Size(330, 60),
//                       backgroundColor: AppColor.dashbordBlueColor,
//                     ),
//                     onPressed: () {
//                       // Navigate to the login screen
//                       Navigator.pushReplacementNamed(context, '/login');
//                     },
//                     child: const Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Continue",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20),
//                         ),
//                         Icon(
//                           Icons.arrow_forward_outlined,
//                           color: Colors.white,
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myproject/Authentication/login_screen.dart';
import 'package:myproject/Common/constant.dart';
import 'package:myproject/Dashboared/Dashboared/Screens/Home_screen.dart';
import 'package:myproject/Pump/pump_dashboared_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Future<void> _navigate() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  //   if (isLoggedIn) {
  //     SharedPreferences rolePref = await SharedPreferences.getInstance();
  //     String? userRole = rolePref.getString('userRole');

  //     if (userRole != null) {
  //       if (userRole == 'Owner') {
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => const DashboardOwnerScreen(),
  //           ),
  //         );
  //       } else if (userRole == 'Pump') {
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => PumpDashboardScreen(context: context),
  //           ),
  //         );
  //       } else {
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => const LoginScreen(),
  //           ),
  //         );
  //       }
  //     } else {
  //       // If userRole is not set, navigate to login screen
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const LoginScreen(),
  //         ),
  //       );
  //     }
  //   } else {
  //     // If user is not logged in, navigate to login screen
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) => const LoginScreen(),
  //       ),
  //     );
  //   }
  // }
  Future<void> _navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    SharedPreferences rolePref = await SharedPreferences.getInstance();

    String? userRole = rolePref.getString('userRole');
    print('<<<<< IsLoggedIn >>>>>>$isLoggedIn');
    if (isLoggedIn) {
      print('<<<<< UserRole  >>>>>>>$userRole');
      if (userRole != null) {
        if (userRole == 'Owner') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardOwnerScreen(),
            ),
          );
        } else if (userRole == 'Pump') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PumpDashboardScreen(context: context),
            ),
          );
        } else {
          // Handle unknown user roles here
          // For example, you might show an error message or log out the user
          _handleUnknownUserRole(context);
        }
      } else {
        // If userRole is not set, navigate to login screen
        _navigateToLoginScreen(context);
      }
    } else {
      // If user is not logged in, navigate to login screen
      _navigateToLoginScreen(context);
    }
  }

  void _handleUnknownUserRole(BuildContext context) {
    // Handle unknown user roles here
    // For example, you might show an error message or log out the user
  }

  void _navigateToLoginScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/splashLogo.jpg"),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'Welcome to PetroLink',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(330, 60),
                      backgroundColor: AppColor.dashbordBlueColor,
                    ),
                    onPressed: () {
                      _navigate();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Continue",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
