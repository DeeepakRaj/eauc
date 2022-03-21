import 'package:eauc/constants.dart';
import 'package:eauc/widgetmodels/shimmering_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringProducts extends StatefulWidget {
  const ShimmeringProducts({Key? key}) : super(key: key);

  @override
  _ShimmeringProductsState createState() => _ShimmeringProductsState();
}

class _ShimmeringProductsState extends State<ShimmeringProducts> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ShimmeringWidget(
                width: double.infinity,
                height: 40,
              ),
              SizedBox(
                height: 20,
              ),
              ShimmeringWidget(
                width: double.infinity,
                height: 80,
              ),
              SizedBox(
                height: 20,
              ),
              ShimmeringWidget(
                width: double.infinity,
                height: 20,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: kProductsListViewHeight,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ShimmeringWidget(
                        width: 180,
                        height: kProductsListViewHeight,
                      );
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              ShimmeringWidget(
                width: double.infinity,
                height: 20,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: kProductsListViewHeight,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ShimmeringWidget(
                        width: 180,
                        height: kProductsListViewHeight,
                      );
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              ShimmeringWidget(
                width: double.infinity,
                height: 20,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: kProductsListViewHeight,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ShimmeringWidget(
                        width: 180,
                        height: kProductsListViewHeight,
                      );
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              ShimmeringWidget(
                width: double.infinity,
                height: 20,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: kProductsListViewHeight,
                child: ListView.separated(
                    separatorBuilder: (context, _) => SizedBox(
                          width: 10,
                        ),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ShimmeringWidget(
                        width: 180,
                        height: kProductsListViewHeight,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
