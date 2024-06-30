import 'package:flutter/material.dart';
import 'package:myproject/Common/chat_roam.dart';
import 'package:myproject/Dashboared/dashbored_styles.dart';
import 'package:myproject/Dashboared/sidebar.dart';

class DashbordChat extends StatelessWidget {
  const DashbordChat({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room', style: AppStyle.textWhiteColorHeader()),
        centerTitle: true,
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer:
          MediaQuery.of(context).size.width < 600 ? const CustomDrawer() : null,
      body: Row(
        children: [
          if (width >= 700) const CustomDrawer(),
          if (width >= 700)
            VerticalDivider(
              thickness: 1,
              color: Colors.grey.shade600,
            ),
          ChatScreen(
            name: 'Owner',
          ),
        ],
      ),
    );
  }
}
