import 'package:eauc/constants.dart';
import 'package:eauc/widgetmodels/custom_normal_button.dart';
import 'package:flutter/material.dart';
import 'product_class.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({Key? key}) : super(key: key);

  @override
  _CreateProductPageState createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  late String name = '';
  Product _product = Product();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Product'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              TextFormField(
                decoration:
                    kInputFieldDecoration.copyWith(hintText: 'Product Name'),
                style: kInputFieldTextStyle,
                onChanged: (value) {
                  _product.productName = value;
                },
              ),
              CustomNormalButton(
                  buttonText: 'Press This',
                  onPressed: () {
                    Navigator.pop(context, _product);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
