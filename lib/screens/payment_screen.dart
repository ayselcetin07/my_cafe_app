import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:my_cafe_app/models/cart.dart'; // Cart sınıfını içe aktar

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  InputDecoration _buildInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.white),
      filled: true,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1.5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  Future<void> _processPayment() async {
    if (_formKey.currentState!.validate()) {
      // Ödeme işlemi burada yapılabilir
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ödeme işlemi başarılı!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomPaint(
        painter: WavePainter(),
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            height: screenHeight,
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 40.0), // Üstte biraz boşluk bırakmak için
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 30.0,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Text(
                  'Ödeme Ekranı',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 36.0,
                    fontFamily: "Retosta",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 32.0),
                Form(
                  key: _formKey,
                  child: Container(
                    width: screenWidth * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.brown.shade800.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.black, width: 1.5),
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _cardHolderNameController,
                          decoration: _buildInputDecoration('Kart Sahibi Adı'),
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Kart sahibi adını giriniz';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _cardNumberController,
                          decoration: _buildInputDecoration('Kart Numarası'),
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Kart numarasını giriniz';
                            }
                            if (value.length != 16) {
                              return 'Kart numarası 16 haneli olmalıdır';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _expiryDateController,
                          decoration: _buildInputDecoration(
                              'Son Kullanma Tarihi (MM/YY)'),
                          keyboardType: TextInputType.datetime,
                          style: TextStyle(color: Colors.white),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(5),
                            TextInputFormatter.withFunction(
                                (oldValue, newValue) {
                              if (newValue.text.length == 2 &&
                                  !newValue.text.contains('/')) {
                                return TextEditingValue(
                                  text: '${newValue.text}/',
                                  selection: TextSelection.collapsed(
                                      offset: newValue.selection.end + 1),
                                );
                              }
                              return newValue;
                            }),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Son kullanma tarihini giriniz';
                            }
                            if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
                              return 'Geçerli bir tarih formatı giriniz (MM/YY)';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _cvvController,
                          decoration: _buildInputDecoration('CVV'),
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'CVV kodunu giriniz';
                            }
                            if (value.length != 3) {
                              return 'CVV kodu 3 haneli olmalıdır';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        Consumer<Cart>(
                          builder: (context, cart, child) {
                            return Text(
                              'Toplam: ${cart.totalPrice.toStringAsFixed(2)} TL',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _processPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26.0),
                    ),
                  ),
                  child: Text(
                    'Ödemeyi Tamamla',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.brown.shade300
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height * 0.2)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.15,
          size.width * 0.5, size.height * 0.2)
      ..quadraticBezierTo(
          size.width * 0.75, size.height * 0.25, size.width, size.height * 0.2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);

    final paint2 = Paint()
      ..color = Colors.brown.shade500
      ..style = PaintingStyle.fill;

    final path2 = Path()
      ..moveTo(0, size.height * 0.4)
      ..quadraticBezierTo(size.width * 0.15, size.height * 0.35,
          size.width * 0.4, size.height * 0.4)
      ..quadraticBezierTo(
          size.width * 0.65, size.height * 0.45, size.width, size.height * 0.4)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path2, paint2);

    final paint3 = Paint()
      ..color = Colors.brown.shade700
      ..style = PaintingStyle.fill;

    final path3 = Path()
      ..moveTo(0, size.height * 0.6)
      ..quadraticBezierTo(size.width * 0.35, size.height * 0.55,
          size.width * 0.6, size.height * 0.6)
      ..quadraticBezierTo(
          size.width * 0.85, size.height * 0.65, size.width, size.height * 0.6)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path3, paint3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
