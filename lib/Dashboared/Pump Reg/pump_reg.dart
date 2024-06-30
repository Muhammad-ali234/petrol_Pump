import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:crypto/crypto.dart';
import 'package:myproject/Dashboared/sidebar.dart';

class PumpRegScreen extends StatefulWidget {
  const PumpRegScreen({super.key});

  @override
  _PumpRegScreenState createState() => _PumpRegScreenState();
}

class _PumpRegScreenState extends State<PumpRegScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int nextId = 101; // Initial starting ID
  List<Map<String, dynamic>> registeredPumps =
      []; // List to store registered pumps

  @override
  void initState() {
    super.initState();
    _getNextEmployeeId();
    _fetchRegisteredPumps();
  }

  void _getNextEmployeeId() async {
    final lastEmpSnapshot = await _firestore
        .collection('pumpReg')
        .orderBy('id', descending: true)
        .limit(1)
        .get();

    setState(() {
      if (lastEmpSnapshot.docs.isNotEmpty) {
        nextId = lastEmpSnapshot.docs.first['id'] + 1;
      } else {
        nextId = 101; // Default starting ID if no employees exist
      }
    });
  }

  void _fetchRegisteredPumps() async {
    final pumpsSnapshot = await _firestore.collection('pumpReg').get();

    setState(() {
      registeredPumps = pumpsSnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  void _register() async {
    final name = _nameController.text.trim();
    final address = _addressController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty || address.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final newId = nextId;

    try {
      await _firestore.collection('pumpReg').doc(newId.toString()).set({
        'id': newId,
        'name': name,
        'address': address,
        'password': password,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pump registered with ID: $newId')),
      );

      _fetchRegisteredPumps();

      _getNextEmployeeId();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );

      _getNextEmployeeId();
    }
  }

  void _deletePump(int id) async {
    try {
      await _firestore.collection('pumpReg').doc(id.toString()).delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pump with ID $id deleted')),
      );

      _fetchRegisteredPumps();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting pump: $e')),
      );
    }
  }

  void _resetPassword(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: ResetPasswordScreen(pumpId: id),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Pump Register',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: MediaQuery.of(context).size.width < 600
            ? Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              )
            : null,
      ),
      drawer:
          MediaQuery.of(context).size.width < 600 ? const CustomDrawer() : null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return _buildMobileLayout();
          } else {
            return _buildWebLayout();
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pump ID: $nextId',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _getNextEmployeeId,
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _addressController,
            decoration: const InputDecoration(
              labelText: 'Address',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.teal)),
                  onPressed: _register,
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Registered Pumps:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: _buildPumpsTable(),
          ),
        ],
      ),
    );
  }

  Widget _buildWebLayout() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomDrawer(),
          VerticalDivider(
            thickness: 1,
            color: Colors.grey.shade600,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pump ID: $nextId',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: _getNextEmployeeId,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.teal)),
                      onPressed: _register,
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Registered Pumps:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _buildPumpsTable(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPumpsTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Address')),
        DataColumn(label: Text('Actions')),
      ],
      rows: registeredPumps.map((pump) {
        return DataRow(
          cells: [
            DataCell(Text('${pump['id']}')),
            DataCell(Text('${pump['name']}')),
            DataCell(Text('${pump['address']}')),
            DataCell(
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deletePump(pump['id']),
                  ),
                  IconButton(
                    icon: const Icon(Icons.lock_reset),
                    onPressed: () => _resetPassword(pump['id']),
                  ),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

class ResetPasswordScreen extends StatefulWidget {
  final int pumpId;

  const ResetPasswordScreen({super.key, required this.pumpId});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _resetPassword() async {
    final newPassword = _newPasswordController.text.trim();

    if (newPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a new password')),
      );
      return;
    }

    try {
      await _firestore
          .collection('pumpReg')
          .doc(widget.pumpId.toString())
          .update({'password': newPassword});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset successful')),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Reset Password',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _newPasswordController,
            decoration: const InputDecoration(
              labelText: 'New Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.teal)),
              onPressed: _resetPassword,
              child: const Text(
                'Reset',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
