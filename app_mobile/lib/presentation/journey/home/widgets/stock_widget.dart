import 'package:flutter/material.dart';

class Stocks extends StatefulWidget {
  const Stocks({Key key}) : super(key: key);

  @override
  _StocksState createState() => _StocksState();
}

class _StocksState extends State<Stocks> {
  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Andy", "age": 29},
    {"id": 2, "name": "Aragon", "age": 40},
    {"id": 3, "name": "Bob", "age": 5},
    {"id": 4, "name": "Barbara", "age": 35},
    {"id": 5, "name": "Candy", "age": 21},
    {"id": 6, "name": "Colin", "age": 55},
    {"id": 7, "name": "Audra", "age": 30},
    {"id": 8, "name": "Banana", "age": 14},
    {"id": 9, "name": "Caversky", "age": 100},
    {"id": 10, "name": "Becky", "age": 32},
  ];

  List<Map<String, dynamic>> _foundUsers = [];

  @override
  void initState() {
    // TODO: implement initState
    _foundUsers = _allUsers;
    super.initState();
    ;
  }

  @override
  Widget build(BuildContext context) => _buildBody(context);

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        _buildSearchTable(context),
        const SizedBox(
          height: 20,
        ),
        _buildStockTable(context)
      ],
    );
  }

  Widget _buildSearchTable(BuildContext context) {
    return TextField(
      onChanged: _runFilter,
      decoration: const InputDecoration(
          labelText: 'Search', suffixIcon: Icon(Icons.search)),
    );
  }

  Widget _buildStockTable(BuildContext context) {
    return Expanded(
      child: _foundUsers.isNotEmpty
          ? ListView.builder(
              itemCount: _foundUsers.length,
              itemBuilder: (context, index) => Card(
                key: ValueKey('stock_id_$index'),
                color: Colors.amberAccent,
                // elevation: 2,
                margin: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                child: ListTile(
                  leading: Text(
                    _foundUsers[index]['id'].toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  title: Text(_foundUsers[index]['name']),
                  subtitle:
                      Text('${_foundUsers[index]["age"].toString()} years'),
                ),
              ),
            )
          : const Text(
              'No result found',
              style: TextStyle(fontSize: 24),
            ),
    );
  }

  void _runFilter(String searchKeyword) {
    List<Map<String, dynamic>> results = [];
    if (searchKeyword.isEmpty) {
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user['name'].toLowerCase().contains(searchKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundUsers = results;
    });
  }
}
