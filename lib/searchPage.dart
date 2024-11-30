import 'package:flutter/material.dart';
import 'package:pharmacy_store/RepositorySingleton.dart';
import 'package:pharmacy_store/widgets/ProductListWidget.dart';

class searchPage extends StatefulWidget {
  const searchPage({Key? key}) : super(key: key);

  @override
  _searchPageState createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  late FocusNode _focusNode;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Map<String, dynamic>> search = [];

  void fetchedSearchData(String searchWord) async {
    try {
      List<Map<String, dynamic>> fetchedSearch =
          await RepositorySingleton.instance.fetchSearchData(searchWord);
      setState(() {
        search = fetchedSearch;
      });
    } catch (e) {
      print('Error fetching Search data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    _focusNode.requestFocus();
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textEditingController,
              onChanged: (value) {
                setState(() {
                  fetchedSearchData(_textEditingController.text);
                });
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
                child: ListView(children: [
              ProductListWidget(productList: search, context: context)
            ])),
          ],
        ),
      ),
    );
  }
}
