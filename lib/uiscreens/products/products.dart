import 'package:eauc/constants.dart';
import 'package:eauc/widgetmodels/custom_navigation_drawer.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  static const routename = '/productspage';

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  Map<String, String> categoriesMap = {
    'electronics': 'Electronics',
    'furniture': 'Furniture',
    'sports': 'Sports',
    'books': 'Books',
    'antiqueitems': 'Antique',
    'currency': 'Currency',
    'videogames': 'Games',
    'music': 'Music',
    'art': 'Art',
    'moviecollectibles': 'Movie Memorabilia',
    'toys': 'Toys',
    'automobiles': 'Automobiles',
    'fashion': 'Fashion'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PRODUCTS'),
      ),
      drawer: CustomNavigationDrawer(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 1.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ExpandableNotifier(
                        child: ScrollOnExpand(
                          scrollOnExpand: true,
                          scrollOnCollapse: false,
                          child: ExpandablePanel(
                            theme: const ExpandableThemeData(
                              headerAlignment:
                                  ExpandablePanelHeaderAlignment.center,
                            ),
                            header: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Browse by Category',
                                style: kCardTitleTextStyle,
                              ),
                            ),
                            collapsed: Center(
                              child: Container(
                                height: 60,
                                child: Wrap(
                                  spacing: 40,
                                  runSpacing: 30,
                                  alignment: WrapAlignment.spaceEvenly,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  textDirection: TextDirection.ltr,
                                  children: categoriesMap.entries.map((e) {
                                    return Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            'assets/images/' + e.key + '.jpg',
                                            height: 40,
                                            width: 40,
                                          ),
                                          Text(
                                            e.value,
                                            style: TextStyle(
                                                color: Colors.brown,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            expanded: Center(
                              child: Wrap(
                                spacing: 40,
                                runSpacing: 30,
                                alignment: WrapAlignment.spaceEvenly,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                textDirection: TextDirection.ltr,
                                children: categoriesMap.entries.map((e) {
                                  return Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          'assets/images/' + e.key + '.jpg',
                                          height: 40,
                                          width: 40,
                                        ),
                                        Flexible(
                                            child: Text(
                                          e.value,
                                          style: TextStyle(
                                              color: Colors.brown,
                                              fontWeight: FontWeight.bold),
                                        ))
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            builder: (_, collapsed, expanded) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                child: Expandable(
                                  collapsed: collapsed,
                                  expanded: expanded,
                                  theme: const ExpandableThemeData(
                                      crossFadePoint: 0),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
