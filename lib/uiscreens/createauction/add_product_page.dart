import 'dart:io';

import 'package:eauc/constants.dart';
import 'package:eauc/sizeconfig.dart';
import 'package:eauc/widgetmodels/custom_normal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'product_class.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final GlobalKey<FormState> _addprodPageFormKey = GlobalKey<FormState>();
  late String name = '';
  Product _product = Product();

  bool _selectionMode = false;
  List<bool> _isSelected = [];
  Map<XFile, bool> _moreImages = {};

  final ImagePicker _picker = ImagePicker();
  XFile? _primaryImage;
  List<XFile> _additionalImageList = [];

  void _selectPrimaryImage() async {
    final _temperoryimage = await _picker.pickImage(source: ImageSource.camera);
    if (_temperoryimage == null)
      return;
    else {
      setState(() {
        _primaryImage = _temperoryimage;
      });
    }
  }

  void _selectMultipleImages() async {
    final _temperoryimage = await _picker.pickImage(source: ImageSource.camera);
    if (_temperoryimage == null)
      return;
    else {
      setState(() {
        // _moreImages[_temperoryimage]=false;
        _isSelected.add(false);
        _additionalImageList.add(_temperoryimage);
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectionMode
              ? 'Selected ${_isSelected.where((c) => c == true).toList().length} Item(s)'
              : 'Add Product',
        ),
        leading: _selectionMode
            ? IconButton(
                icon: Icon(
                  Icons.close,
                ),
                onPressed: () {
                  setState(() {
                    _selectionMode = !_selectionMode;
                    _isSelected.fillRange(0, _isSelected.length, false);
                    // _moreImages.forEach((key, value) {value=false;});
                  });
                },
              )
            : IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
        actions: [
          _selectionMode
              ? IconButton(
                  icon: Icon(
                    Icons.delete_forever,
                  ),
                  onPressed: () {
                    setState(() {
                      // _isSelected.removeWhere((element){
                      //   _additionalImageList.removeAt(_isSelected.indexOf(element));
                      //   return true;
                      // });
                      _isSelected.forEach((element) {
                        if (element == true) {
                          _additionalImageList
                              .removeAt(_isSelected.indexOf(element));
                        }
                      });
                      _isSelected.removeWhere((item) => item == true);
                      _selectionMode = false;
                    });
                  },
                )
              : SizedBox(
                  width: 1,
                ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _addprodPageFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Add ',
                        style: TextStyle(fontSize: 50, color: Colors.black),
                      ),
                      Text(
                        'Product',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w800,
                          color: kprimarycolor,
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: _selectionMode
                        ? null
                        : () {
                            _selectPrimaryImage();
                          },
                    child: _buildPrimaryImageContainer(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Add More Images',
                    style: kHeaderTextStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: _selectionMode
                            ? null
                            : () {
                                _selectMultipleImages();
                              },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.10,
                          width: MediaQuery.of(context).size.height * 0.10,
                          color: Colors.grey.shade500,
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  (_additionalImageList.isNotEmpty)
                      ? Wrap(
                          spacing: 5.0,
                          runSpacing: 5.0,
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          runAlignment: WrapAlignment.start,
                          children: List.generate(_additionalImageList.length,
                              (index) {
                            return GestureDetector(
                              onLongPress: () {
                                print(index);
                                setState(() {
                                  _selectionMode = !_selectionMode;
                                  _isSelected[index] = !_isSelected[index];
                                  print(_isSelected[index]);
                                });
                              },
                              onTap: () {
                                if (_selectionMode) {
                                  setState(() {
                                    _isSelected[index] = !_isSelected[index];
                                    print('On tap: ${_isSelected[index]}');
                                  });
                                }
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.10,
                                    width: MediaQuery.of(context).size.height *
                                        0.10,
                                    child: Image.file(
                                      File(_additionalImageList[index].path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  _selectionMode
                                      ? Icon(
                                          _isSelected[index]
                                              ? Icons.check_box
                                              : Icons.check_box_outline_blank,
                                          color: kprimarycolor,
                                        )
                                      : Icon(
                                          Icons.check_box_outline_blank,
                                          color: Colors.transparent,
                                        ),
                                ],
                              ),
                            );
                          }))
                      : SizedBox(
                          height: 5,
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: kInputFieldDecoration.copyWith(
                        hintText: 'Product Name'),
                    style: kInputFieldTextStyle,
                    cursorColor: kprimarycolor,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Product name is Required';
                      }
                    },
                    onChanged: (value) {
                      _product.productName = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: kInputFieldDecoration.copyWith(
                        hintText: 'Product Description or Specifications'),
                    style: kInputFieldTextStyle,
                    maxLines: 6,
                    cursorColor: kprimarycolor,
                    validator: (value) {
                      if (value!.isEmpty) return 'Description is Required';
                    },
                    onChanged: (value) {
                      _product.productDesc = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: kInputFieldDecoration.copyWith(
                        hintText: 'Set Base Price'),
                    style: kInputFieldTextStyle,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    cursorColor: kprimarycolor,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (!RegExp(r"[0-9]+?").hasMatch(value!)) {
                        return 'Enter a valid number';
                      }
                    },
                    onChanged: (value) {
                      _product.productPrice = value;
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
        ),
      ),
    );
  }

  Widget _buildPrimaryImageContainer() {
    if (_primaryImage == null) {
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.30,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.1), BlendMode.dstATop),
                image: AssetImage(
                  'assets/images/sampleimage1.jpg',
                ))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_a_photo,
                color: Colors.white,
                size: 80,
              ),
              Text(
                'Add Primary Photo',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      );
    } else if (_primaryImage!.path.isEmpty) {
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.30,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.1), BlendMode.dstATop),
                image: AssetImage(
                  'assets/images/sampleimage1.jpg',
                ))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_a_photo,
                color: Colors.white,
                size: 80,
              ),
              Text(
                'Add Primary Photo',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.30,
        child: Image.file(
          File(_primaryImage!.path),
        ),
      );
    }
  }
}
