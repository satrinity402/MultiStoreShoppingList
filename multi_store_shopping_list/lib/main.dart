import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<GroceryItem> items = [];

  final listEntriesCtrlr = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    listEntriesCtrlr.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Multi Store Shopping List')),
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: listEntriesCtrlr,
                    textInputAction: TextInputAction.go,
                    onEditingComplete: () {
                      setState(() {
                        items.add(GroceryItem(listEntriesCtrlr.text, false));
                        listEntriesCtrlr.clear();
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  child: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      items.add(GroceryItem(listEntriesCtrlr.text, false));
                      listEntriesCtrlr.clear();
                    });
                  },
                ),
              ),
            ],
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: UniqueKey(),
                  child: Card(
                    child: CheckboxListTile(
                      title: Text(items[index].item ?? ""),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: items[index].isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          items[index].isChecked = value;
                        });
                      },
                    ),
                  ),
                  onDismissed: (DismissDirection direction) {
                    setState(() {
                      items.removeAt(index);
                    });
                  },
                );
              }),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class GroceryItem {
  String? item;
  bool? isChecked;

  GroceryItem(this.item, this.isChecked);
}
