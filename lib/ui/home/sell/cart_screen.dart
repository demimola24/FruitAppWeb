import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruitshopweb/data/model/response/fruit_model.dart';
import 'package:fruitshopweb/ui/home/sell/sell_screen.dart';
import 'package:fruitshopweb/ui/varialble_ext.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../constants/color_const.dart';
import '../../widget/custom_dialogs.dart';


class CartScreen extends StatefulWidget {

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = 450;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      alignment: Alignment.topCenter,
      child: StreamBuilder<List<FruitModel>>(
          stream: SellScreen.homeBloc.cartItemsStream,
          builder: (context, snapshot) {
            return Container(
              child:  ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  EdgeInsets padding = const EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 12.0, bottom: 12.0);
                  if(snapshot.hasError || snapshot.data==null ){
                    return SizedBox();
                  }
                  final product = snapshot.data![index];

                  return Card(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      elevation: 1,
                      margin: EdgeInsets.only(top: 4,bottom: 4),
                      child: Container(
                        margin: EdgeInsets.zero,
                        height: 60,
                        padding: padding,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 45,
                              width: 45,
                              margin: const EdgeInsets.only(left: 0,right: 0),
                              alignment: Alignment.center,
                              child: TextField(
                                keyboardType:  TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onChanged: (value){
                                  product.quantity = int.tryParse(value.toString())??1;
                                  //SellScreen.homeBloc.cartItems.add(product);
                                },
                                cursorColor: Colors.transparent,
                                cursorWidth: 1,
                                style: GoogleFonts.spaceGrotesk(
                                  color: ColorPath.MAIN_COLOR,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.0,
                                ),
                                decoration: InputDecoration(
                                  hintText: "${product.quantity}",
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: ColorPath.GREY, width: 0.3),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: ColorPath.GREY, width: 0.4),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder:OutlineInputBorder(
                                    borderSide: const BorderSide(color: ColorPath.ACCENT_COLOR, width: 1.0),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  hintStyle: GoogleFonts.spaceGrotesk(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16,),
                            Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        text: product.name,
                                        style: GoogleFonts.spaceGrotesk(
                                            fontSize: 14,
                                            wordSpacing: 1.0,
                                            color: ColorPath.MAIN_COLOR
                                        ),
                                        children:  <TextSpan>[
                                          TextSpan(text: "", style: GoogleFonts.spaceGrotesk( fontSize: 14,wordSpacing: 1,)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8,),
                                    Text("${((product.nutritions?.carbohydrates??0)*(product.quantity??1)).formatPrice()}",
                                      style: GoogleFonts.spaceGrotesk(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  ],
                                )),
                            const SizedBox(width: 16,),
                            InkWell(
                              child: const Icon(Icons.delete_outline, size: 20,color: Colors.red,),
                              onTap: (){

                              },
                            )
                          ],
                        ),
                      ));
                },
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data?.length,
              ),
            );
          }
      ),
    );
  }



  void showSuccessMessage(message,context){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialogs.showMessageDialog(context, message.toString());
        }
    );
  }

  void showErrorDialog(message,context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialogs.showErrorDialog(context, message.toString());
        }
    );
  }
}

