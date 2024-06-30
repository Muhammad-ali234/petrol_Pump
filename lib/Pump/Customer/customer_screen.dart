import 'package:flutter/material.dart';
import 'package:myproject/Pump/Customer/add_customer.dart';
import 'package:myproject/Pump/Customer/customer_detaile.dart';
import 'package:myproject/Pump/Customer/service.dart';
import 'package:myproject/Pump/common/screens/drawer_meue_item.dart';
import 'package:myproject/Pump/common/widgets/save_button.dart';
import 'package:myproject/Pump/common/screens/app_drawer.dart';
import 'package:myproject/Pump/common/screens/sidebar.dart';
import 'package:myproject/Pump/common/widgets/sidebar_menue_item.dart';
import 'package:myproject/Pump/Customer/customer_data.dart';
import 'package:myproject/Common/constant.dart';

class CustomerScreen extends StatefulWidget {
  final BuildContext context;
  const CustomerScreen({super.key, required this.context});

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  List<Customer> customers = [];
  bool _isSearching = false;
  late TextEditingController _searchController;
  final CustomerService _customerService = CustomerService();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      print("Fetching customers...");
      List<Customer> fetchedUsers = await _customerService.getCustomers();
      print("Fetched customers: $fetchedUsers");

      setState(() {
        customers = fetchedUsers;
      });
    } catch (e) {
      print("Error fetching customers: $e");
    }
  }

  void _updateCustomer(int index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? _buildSearchField()
            : Text(
                'Customer Screen',
                style: TextStyle(color: AppColor.dashbordWhiteColor),
              ),
        centerTitle: true,
        backgroundColor: AppColor.dashbordBlueColor,
        // actions: _buildAppBarActions(),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: MediaQuery.of(context).size.width < 600
          ? AppDrawer(
              username: 'Petrol Pump Station 1',
              drawerItems: getDrawerMenuItems(context),
            )
          : null,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return _buildMobileLayout();
        } else {
          return _buildWebLayout();
        }
      },
    );
  }

  Widget _buildWebLayout() {
    return Row(
      children: [
        SideBar(
          menuItems: getMenuItems(context),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: customers.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CustomerDetailsScreen(user: customers[index]),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      customers[index].name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      'Email: ${customers[index].email}\nContact: ${customers[index].contact}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddCustomer(
                                                  customer: customers[index],
                                                  onDelete: () {
                                                    setState(() {
                                                      fetchUsers();
                                                    });
                                                  },
                                                  onUpdate: () {
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            await _customerService
                                                .deleteCustomer(
                                                    customers[index].id);
                                            setState(() {
                                              customers.removeAt(
                                                  index); // Remove from local list
                                            });
                                          },
                                          icon: const Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SaveButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddCustomer(),
                      ),
                    );
                  },
                  buttonText: "Add User",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: customers.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CustomerDetailsScreen(user: customers[index]),
                    ),
                  );
                },
                child: Card(
                  elevation: 4,
                  margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                customers[index].name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColor.dashbordBlueColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Email: ${customers[index].email}\nContact: ${customers[index].contact}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddCustomer(
                                      customer: customers[index],
                                      onDelete: () {
                                        setState(() {
                                          fetchUsers();
                                        });
                                      },
                                      onUpdate: () {
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit),
                              color: Colors.blue,
                            ),
                            const SizedBox(height: 8),
                            IconButton(
                              onPressed: () async {
                                await _customerService
                                    .deleteCustomer(customers[index].id);
                                setState(() {
                                  customers.removeAt(
                                      index); // Remove from local list
                                });
                              },
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: SaveButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddCustomer(),
                ),
              );
            },
            buttonText: "Add User",
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              setState(() {
                _searchController.clear();
              });
            },
          ),
          prefixIcon: const Icon(Icons.search),
        ),
        style: const TextStyle(color: Colors.black),
        onChanged: (value) {
          // Implement search logic here
          setState(() {
            // Update the list of users based on the search query
          });
        },
      ),
    );
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: () {
            setState(() {
              _isSearching = false;
              // Clear the search query when cancelling the search
              _searchController.clear();
            });
          },
        ),
      ];
    } else {
      return [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () {
            // Handle list icon click
          },
        ),
      ];
    }
  }
}
