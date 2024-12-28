import 'package:flutter/material.dart';
import 'package:my_cafe_app/models/cart.dart';
import 'package:my_cafe_app/screens/cartPage.dart';
import 'package:my_cafe_app/utilities/constants.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  ProductDetail({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  @override
  State<StatefulWidget> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int _quantity = 1;
  TextEditingController _noteController = TextEditingController();

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
          "Product Detail",
          style: TextStyle(
              color: AppColors.kirikbeyaz, fontFamily: "Times New Roman"),
        ),
      ),
      body: _buildProductDetail(context),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  _buildProductDetail(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Container(
          color: Colors.amber[50],
          padding: EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductImage(),
              _buildProductTitle(),
              SizedBox(height: 12.0),
              _buildProductPrice(),
              SizedBox(height: 12.0),
              _buildDivider(size),
              SizedBox(height: 12.0),
              _buildFurtherInfo(),
              SizedBox(height: 12.0),
              _buildDivider(size),
              SizedBox(height: 12.0),
              _buildCustomerNote(),
              SizedBox(height: 12.0),
              _buildQuantitySelector(),
              SizedBox(height: 12.0),
            ],
          ),
        ),
      ],
    );
  }

  _buildProductImage() {
    return Container(
      color: Colors.amber[50],
      child: Padding(
        padding: EdgeInsets.all(30.0),
        child: Container(
          height: 225.0,
          child: Center(
            child: Image.network(
              widget.imageUrl,
            ),
          ),
        ),
      ),
    );
  }

  _buildProductTitle() {
    return Container(
      color: Color(0xFFCDAA7D),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Center(
          child: Text(
            widget.name,
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontFamily: "Times New Roman",
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  _buildProductPrice() {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: [
            Text(
              "${widget.price.toStringAsFixed(2)} TL",
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Times New Roman"),
            ),
            SizedBox(width: 8.0),
          ],
        ),
      ),
    );
  }

  _buildDivider(Size screenSize) {
    return Column(
      children: [
        Container(
          color: const Color.fromARGB(255, 0, 0, 0),
          width: screenSize.width,
          height: 2.0,
        ),
      ],
    );
  }

  _buildFurtherInfo() {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: [
            Icon(Icons.local_offer),
            SizedBox(width: 10.0),
            Text(
              widget.description,
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: "Times New Roman",
                color: Colors.brown,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildCustomerNote() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxHeight: 100.0,
            ),
            child: SingleChildScrollView(
              child: TextField(
                controller: _noteController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: "Müşteri Notu",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.brown),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.brown),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.brown),
                  ),
                  filled: true,
                  fillColor: Colors.brown,
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[50],
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  shadowColor: Colors.brown,
                  elevation: 10.0,
                ),
                onPressed: () {
                  setState(() {
                    _noteController.clear();
                  });
                },
                child: Text(
                  'Notu Sil',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildQuantitySelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              setState(() {
                if (_quantity > 1) _quantity--;
              });
            },
          ),
          Text(
            '$_quantity',
            style: const TextStyle(fontSize: 20.0, color: Colors.red),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                _quantity++;
              });
            },
          ),
        ],
      ),
    );
  }

  _buildBottomBar() {
    return Container(
      color: Colors.amber[50],
      padding: EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Toplam:',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
              fontFamily: "Times New Roman",
            ),
          ),
          Text(
            '${(widget.price * _quantity).toStringAsFixed(2)} TL',
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Times New Roman",
              color: Colors.red,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              onPressed: () {
                // Sepete ekleme işlemi burada yapılabilir
                Provider.of<Cart>(context, listen: false).addItem(
                  widget.name,
                  widget.price,
                  _quantity,
                  imageUrl: widget.imageUrl,
                );

                // Sepet sayfasına yönlendirme
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
              child: Text('Sepete Ekle'),
            ),
          ),
        ],
      ),
    );
  }
}
