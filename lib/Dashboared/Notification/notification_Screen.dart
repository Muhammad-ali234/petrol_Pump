import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      content: SizedBox(
        width: double.maxFinite,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('notifications')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();

            return ListView(
              shrinkWrap: true,
              children: snapshot.data!.docs.map((doc) {
                // Convert Firestore timestamp to DateTime
                DateTime timestamp = (doc['timestamp'] as Timestamp).toDate();
                String formattedDate =
                    DateFormat.yMMMd().add_jm().format(timestamp);

                bool seen = doc['seen'];

                return ListTile(
                  leading: Icon(
                    seen ? Icons.visibility : Icons.visibility_off,
                    color: seen ? Colors.green : Colors.red,
                  ),
                  title: Text(doc['pumpName']),
                  subtitle: Text(
                    'Stock added: ${doc['stockAdded']} (${doc['stockCategory']})\n'
                    'Time: $formattedDate',
                  ),
                  onTap: () {
                    // Mark as seen
                    FirebaseFirestore.instance
                        .collection('notifications')
                        .doc(doc.id)
                        .update({'seen': true});
                  },
                );
              }).toList(),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
