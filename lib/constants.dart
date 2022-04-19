import 'package:flutter/material.dart';

const kprimarycolor = Color(0xFFF0A500);
const kbackgroundcolor = Color(0xFFF4F4F4);
const kblacktextcolor = Colors.black;
const kinputfieldbgcolor = Color(0xFFEBF3FB);
const kinputfieldlabelcolor = Color(0xFFB0AFAF);
const knormalbuttoncolor = Color(0xFFF0A500);
// const kbrowntextcolor = Color(0xFFB26E63);
const ksecondarycolor = Color(0xFFBF9954);

const String apiUrl = 'https://eauction2022.000webhostapp.com/';

String numberRegExp = r'^[0-9]*$';
String emailRegExp =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
String passwordRegExp =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

double kProductsListViewHeight = 310;
double kAuctionsListViewHeight = 270;
double kAuctionsListViewWidth = 180;

final kInputFieldDecoration = InputDecoration(
    hintText: 'Email',
    hintStyle: TextStyle(color: kinputfieldlabelcolor, fontSize: 17.0),
    fillColor: Colors.white,
    focusColor: Color(0xFFEBEBFB),
    filled: true,
    contentPadding: EdgeInsets.all(20.0),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.red, width: 2.0)));

final kSearchFieldDecoration = InputDecoration(
  hintText: 'Search in All Auctions',
  hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
  fillColor: Colors.white,
  filled: true,
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(color: Colors.red, width: 2.0),
  ),
  prefixIcon: Icon(
    Icons.search,
    color: kprimarycolor,
  ),
  suffixIcon: Icon(
    Icons.close,
    color: Colors.grey,
  ),
  focusColor: kprimarycolor,
  hoverColor: kprimarycolor,
  prefixIconColor: kprimarycolor,
  contentPadding: EdgeInsets.all(10.0),
);

final kSmallInputFieldDecoration = InputDecoration(
  hintText: 'Search in All Auctions',
  hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
  fillColor: Colors.white,
  filled: true,
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(color: Colors.red, width: 2.0),
  ),
  focusColor: kprimarycolor,
  hoverColor: kprimarycolor,
  prefixIconColor: kprimarycolor,
  contentPadding: EdgeInsets.all(10.0),
);

final kInputFieldTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 21.0,
);

final kSearchFieldTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 18,
);

final kHeaderTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

final kCardTitleTextStyle =
    TextStyle(fontWeight: FontWeight.w900, color: kprimarycolor, fontSize: 20);

final kCardSubTitleTextStyle = TextStyle(fontSize: 18, color: Colors.grey);

List<String> categoriesList = [
  'Collectables',
  'Furniture',
  'Arms, Armour & Militaria',
  'Oil, Acrylic paintings & Mixed Media',
  'Books, Manuscripts & Periodicals',
  'Prints & Multiples',
  'Sculpture',
  'Toys, Models & Dolls',
  'Jewellery',
  'Ceramics',
  'Salvage & Architectural Antiques',
  'Vintage Fashion',
  'Silver & Silver-plated items',
  'Glassware',
  'Musical Instruments & Memorabilia',
  'Porcelain',
  'Metalware',
  'Sporting Memorabilia & Equipment',
  'Clocks',
  'Lighting',
  'Watercolours',
  'Watches & Watch accessories',
  'Kitchenalia',
  'Chinese Works of Art',
  'Scientific Instruments',
  'Stamps',
  'Coins',
  'Classic Cars, Motorcycles & Automobilia',
  'Textiles',
  'Carpets & Rugs',
  'Writing Instruments',
  'Tools',
  'Taxidermy & Natural History',
  'Fine art',
  'Cameras & Camera Equipment',
  'Japanese Works of Art',
  'Photographs',
  'Wines & Spirits',
  'Drawings & Pastels',
  'Maps',
  'Barometers',
  'Ethnographica & tribal art',
  'Entertainment Memorabilia',
  'Bank notes',
  'Russian Works of Art',
  'Greek, Roman, Egyptian & other antiquities',
  'Islamic Works of Art',
  'Clocks, watches & jewellery',
  'Indian Works of Art',
  'Decorative art',
  'Asian art',
  'Railwayana',
  'Consumer goods',
  'Art Nouveau & Art Deco',
  'Religious Items & Folk Art',
  'Vintage fashion & textiles',
  'Design',
  'Homewares',
  'Audio & Musical Equipment',
  'Cars',
  'Fashion & Accessories',
  'General collective',
  'Jewellery & Watches',
  'Photographic',
  'Toys',
  'Trucks & Trailers',
  'Attachments',
  'Aviation & Marine',
  'Chairs',
  'Fitness & Sports Equipment',
  'Garden & Outdoor',
  'Grocery Products & Consumables',
  'Ground Care',
  'Home Improvements',
  'Kitchen',
  'Kitchen Equipment',
  'Medical equipment',
  'Motorbikes',
  'Office furniture & supplies',
  'Old Currency',
  'Other Industrial Supplies & Equipment',
  'Pet Products',
  'Restaurant & Bar Equipment',
  'Spreaders & Sprayers',
  'Televisions',
  '4WD Vehicles',
  'Agricultural equipment',
  'Auto Parts & Accessories',
  'Bathroom',
  'Bedroom',
  'Bicycle',
  'Bowsers & Tanks',
  'Children & Baby Products',
  'Cookers & Cookware',
  'Electrical Supplies',
  'Food Preparation',
  'Food Warmers & Holding Cabinets',
  'Fridges & Freezers',
  'Furniture',
  'Gaming & Consoles',
  'Measuring & Testing Equipment',
  'Mixers & Blenders',
  'Monitors',
  'Perfume & Cosmetics',
  'Pipes & Fittings',
  'Planting & Sowing',
  'Printing equipment',
  'Processing',
  'Refrigeration',
  'Rollers',
  'Seasonal Products',
  'Small Appliances',
  'Tables',
  'Tillage',
  'Tools',
  'Tractors',
  'Tumble Dryers',
  'Vans & Commercial Vehicles',
  'Washing Machines',
  'Welders',
  'Wines & Spirits'
];