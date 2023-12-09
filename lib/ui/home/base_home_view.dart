
import 'package:flutter/material.dart';
import 'package:fruitshopweb/constants/imagepath.dart';
import 'package:fruitshopweb/ui/home/sell/sell_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../constants/color_const.dart';


class BaseHomeView extends StatefulWidget {
  const BaseHomeView({Key? key}) : super(key: key);
  static const routeName =  "/base-home-view";
  static final navigatorKey = GlobalKey<NavigatorState>();


  @override
  _BaseHomeViewState createState() => _BaseHomeViewState();
}

class _BaseHomeViewState extends State<BaseHomeView>  with SingleTickerProviderStateMixin {



  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: ResponsiveBuilder(
          builder: (context, sizingInformation) {
            return Scaffold(
              backgroundColor: ColorPath.OFF_WHITE,
              body: Material(
                child: Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: <Widget>[
                      Card(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              SizedBox(width: 24,),
                              const Image(
                                image: AssetImage(ImagePath.LOGO,),
                                height: 30,width: 30,
                                fit: BoxFit.contain,),
                              SizedBox(width: 8,),
                              Text("Best Fruit Shop", textAlign: TextAlign.center,
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: ColorPath.BLACK,
                                ),),
                              Expanded(child: SizedBox()),
                              Icon(Icons.add_shopping_cart, color: Colors.grey,),
                              SizedBox(width: 16,),
                              Icon(Icons.history,color: Colors.grey,),
                              SizedBox(width: 16,),
                              Icon(Icons.person,color: Colors.grey,),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          child: Navigator(
                              key: BaseHomeView.navigatorKey,
                              initialRoute: SellScreen.routeName,
                              onGenerateRoute: RouteGenerator.generateRoute
                          )
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    BaseHomeView.navigatorKey.currentState!.dispose();
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed while calling Navigator.pushNamed
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const SellScreen(),
        );
      case SellScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const SellScreen(),
        );
        //
      default:
        return MaterialPageRoute(
          builder: (context) =>  SellScreen(),
        );
    }
  }


}
