import 'package:app_mobile/data/stocks_data.dart';
import 'package:app_mobile/presentation/journey/home/stock_bloc/stock_bloc.dart';
import 'package:app_mobile/presentation/journey/home/stock_bloc/stock_event.dart';
import 'package:app_mobile/presentation/journey/home/stock_bloc/stock_state.dart';
import 'package:app_mobile/presentation/journey/home/widgets/constants.dart';
import 'package:app_mobile/common/injector/injector.dart';
import 'package:flutter/material.dart';

class Stocks extends StatefulWidget {
  const Stocks({Key key}) : super(key: key);

  @override
  _StocksState createState() => _StocksState();
}

class _StocksState extends State<Stocks> {
  // final List<Map<String, dynamic>> _allUsers = [
  //   {"id": 1, "name": "Andy", "age": 29},
  //   {"id": 2, "name": "Aragon", "age": 40},
  //   {"id": 3, "name": "Bob", "age": 5},
  //   {"id": 4, "name": "Barbara", "age": 35},
  //   {"id": 5, "name": "Candy", "age": 21},
  //   {"id": 6, "name": "Colin", "age": 55},
  //   {"id": 7, "name": "Audra", "age": 30},
  //   {"id": 8, "name": "Banana", "age": 14},
  //   {"id": 9, "name": "Caversky", "age": 100},
  //   {"id": 10, "name": "Becky", "age": 32},
  // ];

  StockBloc stockBloc;

  final List<Map<String, dynamic>> _sampleStock = stockMock;

  List<Map<String, dynamic>> _stockFiltered = [];

  @override
  void initState() {
    // TODO: implement initState
    // _foundUsers = _allUsers;
    stockBloc = Injector.resolve<StockBloc>();
    super.initState();
  }

  @override
  dispose(){
    stockBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _buildBody(context);

  Widget _buildBody(BuildContext context) {
    stockBloc.add(StockInitEvent());
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
        labelText: StockConstants.searchText,
        suffixIcon: Icon(Icons.search),
      ),
    );
  }

  Widget _buildStockHeader(BuildContext context) {}

  Widget _buildStockTable(BuildContext context) {
    return Expanded(
      child: _stockFiltered.isNotEmpty
          ?  ListView.builder(
              itemCount: _sampleStock.length,
              itemBuilder: (context, index) => Card(
                key: ValueKey(_sampleStock[index]['id']),
                color: Colors.white70,
                // elevation: 2,
                margin: const EdgeInsets.symmetric(
                  vertical: 1,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ..._buildListRow(context, index),
                  ],
                ),
              ),
            )
          : const Text(
              StockConstants.resultNotFoundText,
              style: TextStyle(fontSize: 24),
            ),
    );
  }

  List<Widget> _buildListRow(BuildContext context, index) {
    return [
      Container(
        width: 30,
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(
          left: 15,
        ),
        child: Text(
          (index + 1).toString(),
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ),
      Container(
        height: 50,
        width: 10,
        alignment: Alignment.centerLeft,
        child: const Icon(
          Icons.star_border,
        ),
      ),
      Container(
        height: 50,
        margin: const EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Text(
          _sampleStock[index]['currency'],
          style: const TextStyle(
              color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        height: 50,

        width: 150,
        margin: const EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Text(
          _sampleStock[index]['description'],
        ),
      ),
      Container(
        height: 50,
        margin: const EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Text(
          _sampleStock[index]['displaySymbol'],
        ),
      ),
      // Container(
      //   height: 50,
      //   alignment: Alignment.centerLeft,
      //   child: T
      //
      // )
    ];
  }

  // void _toogleWatchList();

  void _runFilter(String searchKeyword) {
    List<Map<String, dynamic>> results = [];
    debugPrint('Keyword Hit $searchKeyword');
    if (searchKeyword.isEmpty) {
      results = _sampleStock;
    } else {
      results = _sampleStock
          .where((stock) =>
              stock['description'].toLowerCase().contains(searchKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _stockFiltered = results;
    });
  }
}
