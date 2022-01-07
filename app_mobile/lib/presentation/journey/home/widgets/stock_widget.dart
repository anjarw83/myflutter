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
  StockBloc stockBloc;

  final List<Map<String, dynamic>> _sampleStock = stockMock;

  List<Map<String, dynamic>> _stockFiltered = [];

  @override
  void initState() {
    stockBloc = Injector.resolve<StockBloc>();
    _stockFiltered = _sampleStock;
    super.initState();
  }

  @override
  void dispose() {
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

  Widget _buildStockTable(BuildContext context) => Expanded(
        child: _stockFiltered.isNotEmpty
            ? ListView.builder(
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
      GestureDetector(
        onTap: _toggleWatchList,
        child: Container(
          height: 50,
          width: 25,
          alignment: Alignment.center,
          child: const Icon(
            Icons.star_border,
          ),
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
    ];
  }

  void _toggleWatchList() {
    debugPrint('Screen Toggle Watchlist');
    stockBloc.add(FetchStockEvent(keyword: ''));
  }

  void _runFilter(String searchKeyword) {
    List<Map<String, dynamic>> results = [];
    debugPrint('Keyword Hit $searchKeyword');
    if (searchKeyword.isEmpty) {
      results = _sampleStock;
    } else {
      results = _sampleStock
          .where((stock) => stock['description']
              .toLowerCase()
              .contains(searchKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _stockFiltered = results;
    });
  }
}
