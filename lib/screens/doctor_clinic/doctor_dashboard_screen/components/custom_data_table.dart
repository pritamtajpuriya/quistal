import 'package:flutter/material.dart';

customDataTable({
  String tableName,
  var routeName,
  var dataTableColumns,
  var dataTableRows,
  var context,
  var hasShowAll,
}) {
  var screenWidth = MediaQuery.of(context).size.width;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 7,
                offset: Offset(3, 3))
          ]),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 210,
                  child: Text(
                    tableName,
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),
                hasShowAll
                    ? ElevatedButton(
                        onPressed: routeName != null
                            ? () {
                                Navigator.of(context).pushNamed(routeName);
                              }
                            : () {},
                        child: Text("Show All"),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue)),
                      )
                    : Container()
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              thickness: 2,
            ),
          ),
          Container(
            height: screenWidth / 1.5,
            child: Scrollbar(
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  DataTable(
                    columns: dataTableColumns,
                    rows: dataTableRows,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
