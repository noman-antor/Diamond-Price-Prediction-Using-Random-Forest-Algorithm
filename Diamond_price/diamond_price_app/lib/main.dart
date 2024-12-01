import 'dart:convert';

import 'package:diamond_price_app/front_page.dart';
import 'package:diamond_price_app/text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Times New Roman",
      ),
      home: front_page(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> quality = ['Fair', 'Good', 'Very Good', 'Premium', 'Ideal'];
  String quality_value = "Fair";
  int quality_code = 0;

  List<String> clr = ['J', 'I', 'H', 'G', 'F', 'E', 'D'];
  String clr_value = "J";
  int clr_code = 0;

  List<String> clrty = ['I1', 'SI2', 'SI1', 'VS2', 'VS1', 'VVS2', 'VVS1', 'IF'];
  String clrty_value = "I1";
  int clrty_code = 0;

  text_field tf = text_field();
  TextEditingController take_carat = TextEditingController();
  double carat=0.0;
  TextEditingController width_of_top = TextEditingController();
  double table=0.0;
  TextEditingController x = TextEditingController();
  double x_=0.0;
  TextEditingController y = TextEditingController();
  double y_=0.0;
  TextEditingController z = TextEditingController();
  double z_=0.0;

  double depth=0.0;

  String price="";
  int api_check=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          padding: EdgeInsets.all(10.0),
          child: RefreshIndicator(
              onRefresh: () {
                return Future.delayed(Duration(seconds: 2), () {
                  setState(() {
                    quality_value = "Fair";
                    quality_code = 0;
                    clr_value = "J";
                    clr_code = 0;
                    clrty_value = "I1";
                    clrty_code = 0;
                    take_carat.clear();
                    width_of_top.clear();
                    x.clear();
                    y.clear();
                    z.clear();
                    price="";
                    api_check=0;
                  });
                });
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text("Diamond Price Detection",
                            style: TextStyle(
                                fontFamily: "Times New Roman",
                                color: Colors.black,
                                fontSize: 25)),
                      ),
                    ),
                    SizedBox(height: 50),

                    //Building carat box
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Quality: ",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        SizedBox(width: 10),
                        Container(
                          width: 105,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: DropdownButton(
                              dropdownColor: Colors.white,
                              underline: SizedBox(),
                              focusColor: Colors.white,
                              value: quality_value,
                              items: quality.map((String item) {
                                return DropdownMenuItem(
                                    child: Text(item), value: item);
                              }).toList(),
                              onChanged: (String? newvalue) {
                                setState(() {
                                  quality_value = newvalue!;
                                });
                                for (int i = 0; i < quality.length; i++) {
                                  if (quality_value == quality[i]) {
                                    setState(() {
                                      quality_code = i;
                                    });
                                  }
                                }
                              }),
                        )
                      ],
                    ),
                    SizedBox(height: 6),
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.white))),
                    ),

                    //Building color box
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Color Code: \n(Worst to Best)",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        SizedBox(width: 10),
                        Container(
                          width: 50,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: DropdownButton(
                              dropdownColor: Colors.white,
                              underline: SizedBox(),
                              focusColor: Colors.white,
                              value: clr_value,
                              items: clr.map((String item) {
                                return DropdownMenuItem(
                                    child: Text(item), value: item);
                              }).toList(),
                              onChanged: (String? newvalue) {
                                setState(() {
                                  clr_value = newvalue!;
                                });
                                for (int i = 0; i < clr.length; i++) {
                                  if (clr_value == clr[i]) {
                                    setState(() {
                                      clr_code = i;
                                    });
                                  }
                                }
                              }),
                        )
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.white))),
                    ),

                    //Building clarity box
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Clarity Code: \n(Worst to Best)",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        SizedBox(width: 10),
                        Container(
                          width: 70,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: DropdownButton(
                              dropdownColor: Colors.white,
                              underline: SizedBox(),
                              focusColor: Colors.white,
                              value: clrty_value,
                              items: clrty.map((String item) {
                                return DropdownMenuItem(
                                    child: Text(item), value: item);
                              }).toList(),
                              onChanged: (String? newvalue) {
                                setState(() {
                                  clrty_value = newvalue!;
                                });
                                for (int i = 0; i < clrty.length; i++) {
                                  if (clrty_value == clrty[i]) {
                                    setState(() {
                                      clrty_code = i;
                                    });
                                  }
                                }
                              }),
                        )
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.white))),
                    ),

                    //Carat box
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Carat ? ",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        tf.get_text_field(take_carat),
                      ],
                    ),
                    SizedBox(height: 1),
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.white))),
                    ),

                    //Width_of_top box
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Width of \nTop of diamond ? ",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        tf.get_text_field(width_of_top)
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.white))),
                    ),

                    //Length(X) box
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Length ? ",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        tf.get_text_field(x),
                      ],
                    ),
                    SizedBox(height: 1),
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.white))),
                    ),

                    //Width(Y) box
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Width ? ",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        tf.get_text_field(y),
                      ],
                    ),
                    SizedBox(height: 1),
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.white))),
                    ),

                    //Depth(Z) box
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Depth ? ",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        tf.get_text_field(z),
                      ],
                    ),
                    SizedBox(height: 1),
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.white))),
                    ),


                    //price button
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(onPressed: ()async{
                          carat=double.parse(take_carat.text);
                          print(quality_code);
                          print(clr_code);
                          print(clrty_code);
                          x_=double.parse(x.text);
                          y_=double.parse(y.text);
                          z_=double.parse(z.text);
                          depth=(2*z_)/(x_+y_);
                          table=double.parse(width_of_top.text);
                          
                          
                          Dio dio=Dio();
                          var res=await dio.post("http://192.168.0.104:8080/diamond_price",
                          data: jsonEncode({
                            "carat":carat,
                            "cut":quality_code,
                            "color":clr_code,
                            "clarity":clrty_code,
                            "depth":depth,
                            "table":table,
                            "x":x_,
                            "y":y_,
                            "z":z_
                          }));

                          if(res.statusCode==200)
                            {
                              setState(() {
                                price=res.data.toString();
                                api_check=1;
                              });
                            }
                          else
                            {
                              setState(() {
                                price="Invalid Result";
                              });
                            }

                        },
                            child: Text("Price",style: TextStyle(fontSize: 18,color: Colors.black)),
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white))),

                        if(api_check==1)
                          Text("$price USD",
                            style: TextStyle(fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),)
                      ],
                    )
                  ],
                ),
              )
          )
      ),
    );
  }
}
