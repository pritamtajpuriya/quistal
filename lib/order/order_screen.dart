import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/scoped_models/order_scoped_model.dart';
import 'package:singleclinic/screens/home/HomeScreen.dart';
// import 'package:singleclinic/screens/cart/widgets/cart_item_vertical_widget.dart';

import '../../AllText.dart';
import '../../main.dart';
import 'widgets/cart_item_vertical_widget.dart';

import 'package:intl/intl.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _selectedValue = 10;
  //CartModel cartModel = CartModel();
  @override
  Widget build(BuildContext context) {
    return ScopedModel<OrderModel>(
        model: OrderModel.instance,
        child: Builder(builder: (context) {
          OrderModel.of(context).getCartList();
          return ScopedModelDescendant<OrderModel>(
              builder: (context, _, model) {
            return Scaffold(
              backgroundColor: Color(0xfff6f6f6),
              appBar: AppBar(
                title: Text(
                  "My Order",
                  style: GoogleFonts.poppins().copyWith(color: Colors.black),
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => HomeScreen())));
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    DropdownButtonFormField(
                        value: _selectedValue,
                        decoration: InputDecoration(
                          labelText: 'Number of Items per Page',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          DropdownMenuItem(value: 10, child: Text('10')),
                          DropdownMenuItem(value: 25, child: Text('25')),
                          DropdownMenuItem(value: 50, child: Text('50')),
                          DropdownMenuItem(value: 100, child: Text('100')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value as int;
                          });
                        }),
                    //     Center(
                    //         child: MonthPickerWidget(
                    //           onSelected: (DateTime date) {
                    // print('Selected date: $date');
                    //           },
                    //         ),
                    //       ),
                    SingleChildScrollView(
                      child: model.order.length == 0
                          ? Center(
                              child: Text('There is no ordered item'),
                            )
                          : Column(
                              children: [
                                ListView.builder(
                                  itemBuilder: (context, index) =>
                                      CartItemVertical(
                                          order: model.order[index]),
                                  itemCount: model.order.length < _selectedValue
                                      ? model.order.length
                                      : _selectedValue,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            );
          });
        }));
  }

  errorDialog(message, context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                Icon(
                  Icons.error,
                  size: 80,
                  color: Colors.red,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  message,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }

  processingDialog(message, context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(LOADING),
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 2,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(color: LIGHT_GREY_TEXT, fontSize: 14),
                  ),
                )
              ],
            ),
          );
        });
  }
}

class MonthPickerWidget extends StatefulWidget {
  final Function(DateTime) onSelected;

  MonthPickerWidget({Key key, @required this.onSelected}) : super(key: key);

  @override
  _MonthPickerWidgetState createState() => _MonthPickerWidgetState();
}

class _MonthPickerWidgetState extends State<MonthPickerWidget> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.onSelected(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectDate(context);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat.yMMMM().format(_selectedDate)),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
