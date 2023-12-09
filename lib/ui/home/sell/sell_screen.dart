import 'package:flutter/material.dart';
import 'package:fruitshopweb/constants/color_const.dart';
import 'package:fruitshopweb/ui/home/sell/products_screen.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../widget/custom_progress.dart';
import '../bloc/home_bloc.dart';
import 'cart_screen.dart';

class SellScreen extends StatefulWidget {
  static const routeName = "/sell-screen";
  const SellScreen({Key? key}) : super(key: key);

   static final  homeBloc = HomeBloc();

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {

  @override
  void initState() {
    super.initState();
    SellScreen.homeBloc.getProducts();
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
          backgroundColor:  ColorPath.OFF_WHITE,
          body: Stack(
            children: [
              Container(
                  width: width,
                  alignment: Alignment.center,
                  height: height,
                  child:  ResponsiveBuilder(
                      builder: (context, sizingInformation) {
                        // if(sizingInformation.screenSize.width<900){
                        //   return ProductsScreen();
                        // }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 8,),
                            Expanded(
                                child: ProductsScreen(),
                            ),
                            const SizedBox(width: 8,),
                            //CartScreen(),
                          ],
                        );
                      }
                  )
              ),
              customProgress(SellScreen.homeBloc.progressStatusStream)
            ],
          ),
        );
  }
}