import 'package:flutter/material.dart';
import 'package:my_cafe_app/models/cart.dart';
import 'package:my_cafe_app/utilities/constants.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String _selectedOrderType = 'Yerinde Yemek';
  final List<String> _orderTypes = ['Yerinde Yemek', 'Paket'];

  Color _buttonColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: 40.0, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.brown,
        title: const Text(
          "Sepet",
          style: TextStyle(
              color: AppColors.kirikbeyaz, fontFamily: "Times New Roman"),
        ),
      ),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: Color(0XFFFCFDF5), // Burada arka plan rengini ayarlayabilirsiniz
      child: Column(
        children: [
          Expanded(
            child: Container(
              height: 100.0, // Belirli bir yükseklik ayarlayın
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: Provider.of<Cart>(context).items.length,
                  itemBuilder: (context, index) {
                    final item = Provider.of<Cart>(context).items[index];
                    return _buildCartItem(context, item);
                  },
                ),
              ),
            ),
          ),
          _buildOrderTypeCard(),
          _buildTableNumberCard(),
        ],
      ),
    );
  }

  Widget _buildOrderTypeCard() {
    return Card(
      color: Color(0XFFFCFDF5),
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonFormField<String>(
          value: _selectedOrderType,
          decoration: InputDecoration(
            labelText: 'Sipariş Yöntemi',
            labelStyle: TextStyle(
              color: Colors.red,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
          dropdownColor: Color(0XFFFCFDF5),
          icon: Icon(
            Icons.arrow_drop_down,
            size: 30.0,
            color: Colors.black,
          ),
          items: _orderTypes.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(value),
                  if (_selectedOrderType == value)
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                ],
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _selectedOrderType = newValue!;
            });
          },
        ),
      ),
    );
  }

  Widget _buildTableNumberCard() {
    return Card(
      color: Colors.amber,
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Masa 3',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, Map<String, dynamic> item) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: Color(
            0XFFFCFDF5), // Burada item arka plan rengini ayarlayabilirsiniz
        leading: Image.network(
          item["imageUrl"],
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(
          item["name"],
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        subtitle: Row(
          children: [
            Expanded(
              child: Text(
                "${(item["price"] * item["quantity"]).toStringAsFixed(2)} TL",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.red,
                ),
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.remove, color: Colors.brown),
              onPressed: () {
                if (item["quantity"] > 1) {
                  Provider.of<Cart>(context, listen: false).addItem(
                    item["name"],
                    item["price"],
                    -1,
                    imageUrl: item["imageUrl"],
                  );
                }
              },
            ),
            Text(
              item["quantity"].toString(),
              style: TextStyle(fontSize: 18.0),
            ),
            IconButton(
              icon: Icon(Icons.add, color: Colors.brown),
              onPressed: () {
                Provider.of<Cart>(context, listen: false).addItem(
                  item["name"],
                  item["price"],
                  1,
                  imageUrl: item["imageUrl"],
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                Provider.of<Cart>(context, listen: false)
                    .removeItem(item["name"]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      color: Color(0XFFF8F9E9),
      padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Toplam:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Times New Roman",
                ),
              ),
              Consumer<Cart>(
                builder: (context, cart, child) {
                  return Text(
                    '${cart.totalPrice.toStringAsFixed(2)} TL',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Times New Roman",
                      color: Colors.red,
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _buttonColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0), // Oval köşeler
                    ),
                  ),
                  onPressed: () {
                    //sipariş tamamlama işlemi burada yapılabilir
                  },
                  child: Text('Siparişi Tamamla'),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0), // Oval köşeler
                    ),
                  ),
                  onPressed: () {
                    Provider.of<Cart>(context, listen: false).clearCart();
                  },
                  child: Text('Sepeti Boşalt'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
