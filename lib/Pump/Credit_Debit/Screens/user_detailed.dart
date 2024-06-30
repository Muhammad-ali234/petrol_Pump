// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:myproject/Pump/Credit_Debit/Screens/Transaction_histry.dart';
// import 'package:myproject/Pump/Credit_Debit/Screens/service.dart';
// import 'package:myproject/Pump/Credit_Debit/Widgets/add_creditdebit.dart';
// import 'package:myproject/Pump/Customer/customer_data.dart';
// import 'package:myproject/Pump/common/screens/app_drawer.dart';
// import 'package:myproject/Pump/common/screens/drawer_meue_item.dart';
// import 'package:myproject/Common/constant.dart';
// import 'package:pdf/pdf.dart';
// import 'package:printing/printing.dart';

// class UserDetailsScreen extends StatefulWidget {
//   final Customer user;

//   const UserDetailsScreen({super.key, required this.user});

//   @override
//   _UserDetailsScreenState createState() => _UserDetailsScreenState();
// }

// class _UserDetailsScreenState extends State<UserDetailsScreen> {
//   final CreditDebitService _creditDebitService = CreditDebitService();
//   double totalCredits = 0.0;

//   Future<void> _generatePdfReport(
//       String customerId, BuildContext context) async {
//     try {
//       final File? file;
//       if (kIsWeb) {
//         await Printing.layoutPdf(
//           onLayout: (PdfPageFormat format) => _creditDebitService
//               .generatePDFForWeb(customerId, context, format),
//         );
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('PDF opened in web viewer')),
//         );
//       } else {
//         file = await _creditDebitService.generatePDF(customerId, context);
//         if (file != null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('PDF saved at ${file.path}')),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('PDF generation canceled')),
//           );
//         }
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to generate PDF: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     totalCredits = widget.user.credit ?? 0.0;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.user.name,
//           style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//               color: AppColor.dashbordWhiteColor),
//         ),
//         centerTitle: true,
//         backgroundColor: AppColor.dashbordBlueColor,
//       ),
//       drawer: MediaQuery.of(context).size.width < 600
//           ? AppDrawer(
//               username: 'Petrol Pump Station 1',
//               drawerItems: getDrawerMenuItems(context),
//             )
//           : null,
//       body: _buildMobileLayout(),
//     );
//   }

//   Widget _buildMobileLayout() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildInfoTile('Name', widget.user.name, Icons.person),
//             _buildInfoTile('Email', widget.user.email, Icons.email),
//             _buildInfoTile('Contact', widget.user.contact, Icons.phone),
//             const SizedBox(height: 16),
//             _buildTotalTile('Total Credits', widget.user.credit!,
//                 Icons.arrow_upward, Colors.green),
//             const SizedBox(height: 16),
//             _buildTotalTile('Total Debits', widget.user.debit!,
//                 Icons.arrow_downward, Colors.red),
//             const SizedBox(height: 32),
//             _buildActionButtons('mob', widget.user.id),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildActionButtons(String platform, String customerId) {
//     if (platform == 'web') {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           _buildActionButton(
//               'Add Debit', 'Debit', Icons.remove, Colors.red, 200),
//           const SizedBox(height: 16),
//           _buildActionButton(
//               'Add Credit', 'Credit', Icons.add, Colors.green, 200),
//           const SizedBox(height: 16),
//           _buildActionButton(
//               'View Credits/Debits', 'View', Icons.list, Colors.blue, 200),
//           const SizedBox(height: 16),
//           SizedBox(
//             width: 200,
//             child: ElevatedButton(
//               onPressed: () async {
//                 _generatePdfReport(customerId, context);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.amber,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//               ),
//               child: const Text('Generate PDF Report'),
//             ),
//           ),
//         ],
//       );
//     } else {
//       return Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _buildActionButton(
//                   'View Credits/Debits', 'View', Icons.list, Colors.blue, 170),
//               const SizedBox(height: 16),
//               _buildActionButton(
//                   'Add Credit', 'Credit', Icons.add, Colors.green, 120),
//             ],
//           ),
//           const SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               ElevatedButton(
//                 onPressed: () async {
//                   await _creditDebitService.generatePDF(customerId, context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.amber,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                 ),
//                 child: const Row(
//                   children: [
//                     SizedBox(
//                       width: 5,
//                     ),
//                     Icon(
//                       Icons.insert_drive_file,
//                       color: Colors.white,
//                     ),
//                     Text(
//                       'Generate PDF Report  ',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//               _buildActionButton(
//                   'Add Debit', 'Debit', Icons.remove, Colors.red, 120),
//             ],
//           )
//         ],
//       );
//     }
//   }

//   Widget _buildInfoTile(String title, String subtitle, IconData icon) {
//     return ListTile(
//       leading: Icon(icon, color: AppColor.dashbordBlueColor),
//       title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//       subtitle: Text(subtitle),
//     );
//   }

//   Widget _buildTotalTile(
//       String title, double total, IconData icon, Color iconColor) {
//     return ListTile(
//       leading: Icon(
//         icon,
//         color: iconColor,
//       ),
//       title: Text('$title: $total'),
//     );
//   }

//   Widget _buildActionButton(
//       String text, String type, IconData icon, Color color, double width) {
//     final creditDebitService = CreditDebitService();
//     return SizedBox(
//       width: width,
//       child: ElevatedButton(
//         onPressed: () {
//           if (type == 'Debit') {
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AddCreditDialog(
//                   type: 'Debit',
//                   id: widget.user.id,
//                   onTransactionSaved: (double amount) async {
//                     await creditDebitService.updateCustomerTransaction(
//                       widget.user.id,
//                       amount,
//                       false,
//                     );
//                     setState(() {
//                       widget.user.credit = (widget.user.credit ?? 0) - amount;
//                     });
//                   },
//                 );
//               },
//             );
//           } else if (type == 'Credit') {
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AddCreditDialog(
//                   type: 'Credit',
//                   id: widget.user.id,
//                   onTransactionSaved: (double amount) async {
//                     await creditDebitService.updateCustomerTransaction(
//                       widget.user.id,
//                       amount,
//                       true,
//                     );
//                     setState(() {
//                       widget.user.credit = (widget.user.credit ?? 0) + amount;
//                     });
//                   },
//                 );
//               },
//             );
//           } else if (type == 'View') {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) =>
//                     TransactionHistoryScreen(customerId: widget.user.id),
//               ),
//             );
//           }
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: color,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               icon,
//               color: Colors.white,
//             ),
//             const SizedBox(width: 8),
//             Text(
//               text,
//               style: const TextStyle(color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myproject/Pump/Credit_Debit/Screens/Transaction_histry.dart';
import 'package:myproject/Pump/Credit_Debit/Screens/service.dart';
import 'package:myproject/Pump/Credit_Debit/Widgets/add_creditdebit.dart';
import 'package:myproject/Pump/Customer/customer_data.dart';
import 'package:myproject/Pump/common/screens/app_drawer.dart';
import 'package:myproject/Pump/common/screens/drawer_meue_item.dart';
import 'package:myproject/Common/constant.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class UserDetailsScreen extends StatefulWidget {
  final Customer user;

  const UserDetailsScreen({super.key, required this.user});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final CreditDebitService _creditDebitService = CreditDebitService();
  double totalCredits = 0.0;

  Future<void> _generatePdfReport(
      String customerId, BuildContext context) async {
    try {
      final File? file;
      if (kIsWeb) {
        await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) => _creditDebitService
              .generatePDFForWeb(customerId, context, format),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PDF opened in web viewer')),
        );
      } else {
        file = await _creditDebitService.generatePDF(customerId, context);
        if (file != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('PDF saved at ${file.path}')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('PDF generation canceled')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    totalCredits = widget.user.credit ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.user.name,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColor.dashbordWhiteColor),
        ),
        centerTitle: true,
        backgroundColor: AppColor.dashbordBlueColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: MediaQuery.of(context).size.width < 600
          ? AppDrawer(
              username: 'Petrol Pump Station 1',
              drawerItems: getDrawerMenuItems(context),
            )
          : null,
      body: _buildMobileLayout(),
    );
  }

  Widget _buildMobileLayout() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoTile('Name', widget.user.name, Icons.person),
            _buildInfoTile('Email', widget.user.email, Icons.email),
            _buildInfoTile('Contact', widget.user.contact, Icons.phone),
            const SizedBox(height: 16),
            _buildTotalTile('Total Credits', widget.user.credit!,
                Icons.arrow_upward, Colors.green),
            const SizedBox(height: 16),
            _buildTotalTile('Total Debits', widget.user.debit!,
                Icons.arrow_downward, Colors.red),
            const SizedBox(height: 32),
            _buildActionButtons('mob', widget.user.id),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String subtitle, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppColor.dashbordBlueColor),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }

  Widget _buildTotalTile(
      String title, double total, IconData icon, Color iconColor) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text('$title: $total'),
    );
  }

  Widget _buildActionButtons(String platform, String customerId) {
    if (platform == 'web') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildActionButton(
              'Add Debit', 'Debit', Icons.remove, Colors.red, 200),
          const SizedBox(height: 16),
          _buildActionButton(
              'Add Credit', 'Credit', Icons.add, Colors.green, 200),
          const SizedBox(height: 16),
          _buildActionButton(
              'View Credits/Debits', 'View', Icons.list, Colors.blue, 200),
          const SizedBox(height: 16),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () async {
                _generatePdfReport(customerId, context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Generate PDF Report'),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActionButton('View Cred/Debit', 'View', Icons.list,
                  Colors.blue.shade800, 150),
              const SizedBox(height: 16),
              _buildActionButton('Add Credit', 'Credit', Icons.add,
                  const Color.fromARGB(255, 68, 108, 69), 150),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await _creditDebitService.generatePDF(customerId, context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 65, 95, 119),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.insert_drive_file,
                      color: Colors.white,
                    ),
                    Text(
                      'Generate PDF Rep ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              _buildActionButton('Add Debit', 'Debit', Icons.remove,
                  const Color.fromARGB(255, 95, 73, 71), 150),
            ],
          )
        ],
      );
    }
  }

  Widget _buildActionButton(
      String text, String type, IconData icon, Color color, double width) {
    final creditDebitService = CreditDebitService();
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: () {
          if (type == 'Debit') {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddCreditDialog(
                  type: 'Debit',
                  id: widget.user.id,
                  onTransactionSaved: (double amount) async {
                    await creditDebitService.updateCustomerTransaction(
                      widget.user.id,
                      amount,
                      false,
                    );
                    setState(() {
                      widget.user.credit = (widget.user.credit ?? 0) - amount;
                    });
                  },
                );
              },
            );
          } else if (type == 'Credit') {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddCreditDialog(
                  type: 'Credit',
                  id: widget.user.id,
                  onTransactionSaved: (double amount) async {
                    await creditDebitService.updateCustomerTransaction(
                      widget.user.id,
                      amount,
                      true,
                    );
                    setState(() {
                      widget.user.credit = (widget.user.credit ?? 0) + amount;
                    });
                  },
                );
              },
            );
          } else if (type == 'View') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    TransactionHistoryScreen(customerId: widget.user.id),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
