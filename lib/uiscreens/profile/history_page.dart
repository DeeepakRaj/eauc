import 'package:eauc/constants.dart';
import 'package:eauc/widgetmodels/tag_container.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
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
        child: Column(
          children: [
            TextFormField(
              cursorColor: kprimarycolor,
              style: kSearchFieldTextStyle,
              decoration: kSearchFieldDecoration.copyWith(
                hintText: 'Search in History',
                suffixIcon: GestureDetector(
                  onTap: () {
                    //TODO: Clear the search field
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                ),
              ),
              onChanged: (value) {
                //TODO: Build search list
              },
            ),
            Divider(
              height: 10,
              color: Colors.transparent,
            ),
            Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, _) => Divider(
                          thickness: 1,
                          height: 2,
                        ),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.zero,
                        color: Colors.white,
                        child: ListTile(
                          tileColor: Colors.white,
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Image.asset(
                                  'assets/images/trophyicon.jpg',
                                ),
                              ),
                              Flexible(
                                  flex: 1,
                                  child: Text(
                                    '12-05-2022',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                          isThreeLine: true,
                          title: Text(
                            'Product Name',
                            style: kCardTitleTextStyle,
                          ),
                          subtitle: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Auction Name',
                                style: kCardSubTitleTextStyle,
                              ),
                              Text(
                                '#50000',
                                style: TextStyle(
                                    color: ksecondarycolor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
