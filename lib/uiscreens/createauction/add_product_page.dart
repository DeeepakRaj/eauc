import 'dart:io';
import 'package:animations/animations.dart';
import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/sizeconfig.dart';
import 'package:eauc/uiscreens/login_page.dart';
import 'package:eauc/uiscreens/createauction/full_screen_image.dart';
import 'package:eauc/widgetmodels/custom_normal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'product_class.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final GlobalKey<FormState> _addprodPageFormKey = GlobalKey<FormState>();
  late String name = '', emailid;
  Product _product = Product();
  List _selectedCategories = [];

  bool _selectionMode = false;
  Map<File, bool> moreImagesMap = {};

  final ImagePicker _picker = ImagePicker();
  File? _primaryImage;

  void _selectPrimaryImage() async {
    final _temperoryimage = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 480,
      maxHeight: 360,
    );
    if (_temperoryimage == null)
      return;
    else {
      setState(() {
        _primaryImage = File(_temperoryimage.path);
      });
    }
  }

  void _selectMultipleImages() async {
    final _temperoryimage = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 480,
      maxHeight: 360,
    );
    if (_temperoryimage == null)
      return;
    else {
      setState(() {
        moreImagesMap[File(_temperoryimage.path)] = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getIdPreference().then((value) async {
      if (value == 'No Email Attached') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
      } else {
        setState(() {
          this.emailid = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectionMode
              ? 'Selected ${moreImagesMap.values.where((element) => element == true).length} Item(s)'
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
                    moreImagesMap.updateAll((key, value) => false);
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
                      moreImagesMap.removeWhere((key, value) => value == true);
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
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: kprimarycolor, width: 2),
                      color: Color(0xFFfff8e7),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey,
                      //     offset: Offset(0.0, 1.0), //(x,y)
                      //     blurRadius: 10.0,
                      //   ),
                      // ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
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
                                      if (moreImagesMap.length == 2) {
                                        Fluttertoast.showToast(
                                          msg: 'Maximum 2 images can be added',
                                        );
                                      } else {
                                        _selectMultipleImages();
                                      }
                                    },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.10,
                                width:
                                    MediaQuery.of(context).size.height * 0.10,
                                color: Colors.grey.shade500,
                                child: Center(
                                  child: Icon(
                                    Icons.add_photo_alternate,
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
                        (moreImagesMap.isNotEmpty)
                            ? Wrap(
                                spacing: 5.0,
                                runSpacing: 5.0,
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.start,
                                runAlignment: WrapAlignment.start,
                                children: List.generate(
                                    moreImagesMap.keys.length, (index) {
                                  return OpenContainer(
                                    transitionDuration:
                                        Duration(milliseconds: 300),
                                    openBuilder: (context, _) =>
                                        FullScreenImage(
                                      photo:
                                          moreImagesMap.keys.elementAt(index),
                                    ),
                                    closedBuilder: (context, openContainer) {
                                      return GestureDetector(
                                        onLongPress: () {
                                          setState(() {
                                            _selectionMode = !_selectionMode;
                                            moreImagesMap.update(
                                                moreImagesMap.keys
                                                    .elementAt(index),
                                                (value) => !value);
                                            print(moreImagesMap);
                                          });
                                        },
                                        onTap: () {
                                          if (_selectionMode) {
                                            setState(() {
                                              moreImagesMap.update(
                                                  moreImagesMap.keys
                                                      .elementAt(index),
                                                  (value) => !value);
                                              print(moreImagesMap);
                                            });
                                          } else {
                                            openContainer();
                                          }
                                        },
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional.topEnd,
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.10,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.10,
                                              child: Image.file(
                                                moreImagesMap.keys
                                                    .elementAt(index),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            _selectionMode
                                                ? Icon(
                                                    moreImagesMap.values
                                                            .elementAt(index)
                                                        ? Icons.check_box
                                                        : Icons
                                                            .check_box_outline_blank,
                                                    color: kprimarycolor,
                                                  )
                                                : Icon(
                                                    Icons
                                                        .check_box_outline_blank,
                                                    color: Colors.transparent,
                                                  ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }))
                            : SizedBox(
                                height: 5,
                              ),
                      ],
                    ),
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
                      _product.openingBid = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MultiSelectDialogField(
                    items: List.generate(
                      categoriesList.length,
                      (index) => MultiSelectItem(
                          categoriesList[index], categoriesList[index]),
                    ),
                    // items: [
                    //   //TODO: Build categories here
                    //   MultiSelectItem('Electronics', 'Electronics'),
                    //   MultiSelectItem('Sports', 'Sports'),
                    //   MultiSelectItem('Ancient', 'Ancient'),
                    //   MultiSelectItem('Currency', 'Currency'),
                    // ],
                    chipDisplay: MultiSelectChipDisplay(
                      textStyle: TextStyle(color: Colors.blue.shade800),
                      chipColor: Colors.blue.shade100,
                    ),
                    listType: MultiSelectListType.LIST,
                    searchable: true,
                    title: Text(
                      "Select Category",
                      style: TextStyle(color: Colors.blue.shade800),
                    ),
                    selectedColor: Colors.blue.shade800,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    searchTextStyle: TextStyle(color: Colors.black),
                    backgroundColor: kbackgroundcolor,
                    buttonIcon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.blue.shade800,
                    ),
                    buttonText: Text(
                      'Select Product Categories',
                      style: TextStyle(
                        color: Colors.blue.shade800,
                        fontSize: 16,
                      ),
                    ),
                    initialValue: _selectedCategories,
                    onConfirm: (results) {
                      setState(() {
                        _selectedCategories = results;
                        _product.productTags =
                            results.map((e) => e.toString()).toList();
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomNormalButton(
                      buttonText: 'ADD',
                      onPressed: () {
                        if (_primaryImage == null) {
                          Fluttertoast.showToast(
                              msg: 'Primary Image is Required',
                              toastLength: Toast.LENGTH_LONG);
                        } else {
                          _product.primaryImage = _primaryImage!;
                          _product.moreImages = moreImagesMap.keys.toList();
                          Navigator.pop(context, _product);
                        }
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
          _primaryImage!,
        ),
      );
    }
  }
}
