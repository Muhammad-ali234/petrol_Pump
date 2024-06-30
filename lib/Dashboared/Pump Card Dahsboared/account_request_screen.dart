// import 'package:flutter/material.dart';
// import 'package:myproject/Authentication/service.dart';
// import 'package:myproject/Dashboared/sidebar.dart';

// class AccountRequested extends StatefulWidget {
//   const AccountRequested({super.key});

//   @override
//   State<AccountRequested> createState() => _AccountRequestedState();
// }

// class _AccountRequestedState extends State<AccountRequested> {
//   FirestoreService firebaseService = FirestoreService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Requested Accounts',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.teal,
//         centerTitle: true,
//         leading: MediaQuery.of(context).size.width < 600
//             ? Builder(
//                 builder: (BuildContext context) {
//                   return IconButton(
//                     icon: const Icon(Icons.menu,
//                         color: Colors.white), // Drawer icon with white color
//                     onPressed: () {
//                       Scaffold.of(context).openDrawer(); // Open the drawer
//                     },
//                   );
//                 },
//               )
//             : null,
//       ),
//       drawer:
//           MediaQuery.of(context).size.width < 600 ? const CustomDrawer() : null,
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           if (constraints.maxWidth > 600) {
//             // For tablets and larger screens
//             return _buildWebLayout(context);
//           } else {
//             // For mobile devices
//             return _buildMobileLayout(context);
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildWebLayout(BuildContext context) {
//     return Row(
//       children: [
//         const CustomDrawer(),
//         VerticalDivider(
//           thickness: 1,
//           color: Colors.grey.shade600,
//         ),
//         Expanded(
//           // Ensure the ListView takes up remaining space
//           child: ListView(
//             children: [
//               _buildRequestItem(
//                   context, 'Jane Smith', 'jane.smith@example.com'),
//               // Add more request items as needed
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildMobileLayout(BuildContext context) {
//     return SingleChildScrollView(
//       child: ListView(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         children: [
//           _buildRequestItem(context, 'John Doe', 'john.doe@example.com'),
//           _buildRequestItem(context, name, email, uid)

//           // Add more request items as needed
//         ],
//       ),
//     );
//   }

//   Widget _buildRequestItem(
//       BuildContext context, String name, String email, uid) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: ListTile(
//         title: Text(
//           name,
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 16.0,
//           ),
//         ),
//         subtitle: Text(email),
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _buildActionButton(context, 'Confirm', Colors.green, () {
//               // Add functionality for confirm button

//               firebaseService.confirmAccount(uid);
//             }),
//             const SizedBox(width: 8.0),
//             _buildActionButton(context, 'Cancel', Colors.red, () {
//               // Add functionality for cancel button
//                firebaseService.cancelAccount(uid);
//             }),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildActionButton(BuildContext context, String label, Color color,
//       void Function() onPressed) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//         child: Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:myproject/Dashboared/sidebar.dart';

// class AccountRequested extends StatefulWidget {
//   const AccountRequested({super.key});

//   @override
//   State<AccountRequested> createState() => _AccountRequestedState();
// }

// class _AccountRequestedState extends State<AccountRequested> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   List<Map<String, dynamic>> requestedAccounts = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadRequestedAccounts();
//   }

//   Future<void> _loadRequestedAccounts() async {
//     try {
//       QuerySnapshot querySnapshot = await _firestore
//           .collection('pumps_registration')
//           .where('status', isEqualTo: 'pending')
//           .get();

//       for (var doc in querySnapshot.docs) {
//         Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
//         userData['uid'] = doc.id; // Add uid to userData
//         setState(() {
//           requestedAccounts.add(userData);
//         });
//       }
//     } catch (error) {
//       print("Error fetching requested accounts: $error");
//     }
//   }

//   Future<void> _confirmAccount(String uid) async {
//     try {
//       await _firestore
//           .collection('pumps_registration')
//           .doc(uid)
//           .update({'status': 'confirmed'});
//       print('Account confirmed successfully');
//       // Optionally, you can reload the requested accounts list here
//     } catch (error) {
//       print("Error confirming account: $error");
//     }
//   }

//   Future<void> _cancelAccount(String uid) async {
//     try {
//       await _firestore
//           .collection('pumps_registration')
//           .doc(uid)
//           .update({'status': 'cancelled'});
//       print('Account cancelled successfully');
//       // Optionally, you can reload the requested accounts list here
//     } catch (error) {
//       print("Error cancelling account: $error");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Requested Accounts',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.teal,
//         centerTitle: true,
//         leading: MediaQuery.of(context).size.width < 600
//             ? Builder(
//                 builder: (BuildContext context) {
//                   return IconButton(
//                     icon: const Icon(Icons.menu,
//                         color: Colors.white), // Drawer icon with white color
//                     onPressed: () {
//                       Scaffold.of(context).openDrawer(); // Open the drawer
//                     },
//                   );
//                 },
//               )
//             : null,
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           if (constraints.maxWidth > 600) {
//             // For tablets and larger screens
//             return _buildWebLayout();
//           } else {
//             // For mobile devices
//             return _buildMobileLayout();
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildWebLayout() {
//     return Row(
//       children: [
//         const CustomDrawer(),
//         VerticalDivider(
//           thickness: 1,
//           color: Colors.grey.shade600,
//         ),
//         Expanded(
//           // Ensure the ListView takes up remaining space
//           child: ListView.builder(
//             itemCount: requestedAccounts.length,
//             itemBuilder: (context, index) {
//               return _buildRequestItem(context, requestedAccounts[index]);
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildMobileLayout() {
//     return ListView.builder(
//       itemCount: requestedAccounts.length,
//       itemBuilder: (context, index) {
//         return _buildRequestItem(context, requestedAccounts[index]);
//       },
//     );
//   }

//   Widget _buildRequestItem(
//       BuildContext context, Map<String, dynamic> userData) {
//     String name = userData['name'] ?? '';
//     String email = userData['email'] ?? '';
//     String uid = userData['uid'] ?? '';

//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
//       child: ListTile(
//         title: Text(
//           name,
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 14.0,
//           ),
//         ),
//         subtitle: Text(
//           email,
//           style: const TextStyle(fontSize: 12),
//         ),
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _buildActionButton(context, 'Confirm', Colors.green, () {
//               _confirmAccount(uid);
//             }),
//             const SizedBox(width: 8.0),
//             _buildActionButton(context, 'Cancel', Colors.red, () {
//               _cancelAccount(uid);
//             }),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildActionButton(BuildContext context, String label, Color color,
//       void Function() onPressed) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//         child: Text(
//           label,
//           style: const TextStyle(
//               fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myproject/Dashboared/sidebar.dart';

class AccountRequested extends StatefulWidget {
  const AccountRequested({super.key});

  @override
  State<AccountRequested> createState() => _AccountRequestedState();
}

class _AccountRequestedState extends State<AccountRequested> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late StreamController<List<Map<String, dynamic>>> _streamController;
  List<Map<String, dynamic>> requestedAccounts = [];

  @override
  void initState() {
    super.initState();
    _streamController =
        StreamController<List<Map<String, dynamic>>>.broadcast();
    _loadRequestedAccounts();

    // Listen for changes to the documents in the collection
    _firestore.collection('pumps_registration').snapshots().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.removed) {
          // Remove the record from requestedAccounts if the document is removed
          setState(() {
            requestedAccounts
                .removeWhere((account) => account['uid'] == change.doc.id);
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  Future<void> _loadRequestedAccounts() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('pumps_registration')
          .where('status', isEqualTo: 'pending')
          .get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
        userData['uid'] = doc.id; // Add uid to userData
        setState(() {
          requestedAccounts.add(userData);
          _streamController.add(requestedAccounts);
        });
      }
    } catch (error) {
      print("Error fetching requested accounts: $error");
    }
  }

  Future<void> _confirmAccount(String uid) async {
    try {
      await _firestore
          .collection('pumps_registration')
          .doc(uid)
          .update({'status': 'confirmed'});
      print('Account confirmed successfully');
      // Optionally, you can reload the requested accounts list here
      setState(() {
        requestedAccounts.removeWhere((account) => account['uid'] == uid);
        _streamController.add(requestedAccounts);
      });
    } catch (error) {
      print("Error confirming account: $error");
    }
  }

  Future<void> _cancelAccount(String uid) async {
    try {
      await _firestore
          .collection('pumps_registration')
          .doc(uid)
          .update({'status': 'cancelled'});
      print('Account cancelled successfully');
      // Optionally, you can reload the requested accounts list here
      setState(() {
        requestedAccounts.removeWhere((account) => account['uid'] == uid);
        _streamController.add(requestedAccounts);
      });
    } catch (error) {
      print("Error cancelling account: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Requested Accounts',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
        leading: MediaQuery.of(context).size.width < 600
            ? Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.menu,
                        color: Colors.white), // Drawer icon with white color
                    onPressed: () {
                      Scaffold.of(context).openDrawer(); // Open the drawer
                    },
                  );
                },
              )
            : null,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // For tablets and larger screens
            return _buildWebLayout();
          } else {
            // For mobile devices
            return _buildMobileLayout();
          }
        },
      ),
    );
  }

  Widget _buildWebLayout() {
    return Row(
      children: [
        const CustomDrawer(),
        VerticalDivider(
          thickness: 1,
          color: Colors.grey.shade600,
        ),
        Expanded(
          // Ensure the ListView takes up remaining space
          child: StreamBuilder<List<Map<String, dynamic>>>(
            stream: _streamController.stream,
            initialData: requestedAccounts,
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return _buildRequestItem(context, snapshot.data![index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _streamController.stream,
      initialData: requestedAccounts,
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return _buildRequestItem(context, snapshot.data![index]);
          },
        );
      },
    );
  }

  Widget _buildRequestItem(
      BuildContext context, Map<String, dynamic> userData) {
    String name = userData['name'] ?? '';
    String email = userData['email'] ?? '';
    String uid = userData['uid'] ?? '';

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
      child: ListTile(
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
        subtitle: Text(
          email,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildActionButton(context, 'Confirm', Colors.green, () {
              _confirmAccount(uid);
            }),
            const SizedBox(width: 8.0),
            _buildActionButton(context, 'Cancel', Colors.red, () {
              _cancelAccount(uid);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String label, Color color,
      void Function() onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Text(
          label,
          style: const TextStyle(
              fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
