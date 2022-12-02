import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class Rohtak extends StatefulWidget {
  // Azadpur({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  _RohtakState createState() => _RohtakState();
}

class _RohtakState extends State<Rohtak> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: FutureBuilder(
        future: getProductDataSource(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.hasData
              ? SfDataGrid(source: snapshot.data, columns: getColumns())
              : Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                );
        },
      ),
    ));
  }

  Future<ProductDataGridSource> getProductDataSource() async {
    var productList = await generateProductList();
    return ProductDataGridSource(productList);
  }

  List<GridColumn> getColumns() {
    return <GridColumn>[
      GridColumn(
          columnName: 'Commodity',
          width: 100,
          label: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              color: Color(0xFF9BA3EB),
              // decoration: BoxDecoration(
              //     border: Border(
              //         right: BorderSide(
              //             color: Colors.grey.withOpacity(0.5), width: 0.5))),
              child: Text('Commodity',
                  overflow: TextOverflow.clip, softWrap: true))),
      GridColumn(
          columnName: 'Variety',
          width: 100,
          label: Container(
              padding: EdgeInsets.all(8),
              color: Color.fromARGB(255, 187, 191, 227),
              alignment: Alignment.centerLeft,
              child: Text('Variety',
                  overflow: TextOverflow.clip, softWrap: true))),
      GridColumn(
          columnName: 'Maximum Price',
          width: 100,
          label: Container(
              padding: EdgeInsets.all(8),
              color: Color(0xFF9BA3EB),
              alignment: Alignment.centerLeft,
              child: Text('Maximum Price',
                  overflow: TextOverflow.clip, softWrap: true))),
      GridColumn(
          columnName: 'Average Price',
          width: 100,
          label: Container(
              padding: EdgeInsets.all(8),
              color: Color.fromARGB(255, 190, 193, 223),
              alignment: Alignment.centerRight,
              child: Text('Average Price',
                  overflow: TextOverflow.clip, softWrap: true))),
      GridColumn(
          columnName: 'Minimum Price',
          width: 100,
          label: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              color: Color(0xFF9BA3EB),
              child: Text('Minimum Price')))
    ];
  }

  Future<List<Product>> generateProductList() async {
    var response = await http.get(Uri.parse(
        'https://test123-7b3b5-default-rtdb.asia-southeast1.firebasedatabase.app/Rohtak.json'));
    var decodedProducts =
        json.decode(response.body).cast<Map<String, dynamic>>();
    List<Product> productList = await decodedProducts
        .map<Product>((json) => Product.fromJson(json))
        .toList();
    return productList;
  }
}

class ProductDataGridSource extends DataGridSource {
  ProductDataGridSource(this.productList) {
    buildDataGridRow();
  }
  late List<DataGridRow> dataGridRows;
  late List<Product> productList;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
        color: Color(0xFFDBDFFD),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[1].value,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        color: Color(0xFFDBDFFD),
        child: Text(
          row.getCells()[2].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[3].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(8.0),
          color: Color(0xFFDBDFFD),
          child: Text(
            row.getCells()[4].value.toString(),
            overflow: TextOverflow.ellipsis,
          ))
    ]);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  void buildDataGridRow() {
    dataGridRows = productList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<String>(
            columnName: 'Commodity', value: dataGridRow.Commodity),
        DataGridCell<String>(columnName: 'Variety', value: dataGridRow.Variety),
        DataGridCell<String>(
            columnName: 'Maximum Price', value: dataGridRow.Maximum_Price),
        DataGridCell<String>(
            columnName: 'Average Price', value: dataGridRow.Average_Price),
        DataGridCell<String>(
            columnName: 'Minimum Price', value: dataGridRow.Minimum_Price)
      ]);
    }).toList(growable: false);
  }
}

class Product {
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      Commodity: json['Commodity'],
      Variety: json['Variety'],
      Maximum_Price: json['Maximum Price'],
      Average_Price: json['Average Price'],
      Minimum_Price: json['Minimum Price'],
    );
  }
  Product(
      {required this.Commodity,
      required this.Variety,
      required this.Maximum_Price,
      required this.Average_Price,
      required this.Minimum_Price});

  final String? Commodity;

  final String? Variety;
  final String? Average_Price;
  final String? Maximum_Price;

  final String? Minimum_Price;
}
