/*import 'package:flutter/material.dart';
import 'package:surebetcalc/constants/app_colors.dart';
import 'package:surebetcalc/widgets/curved_textfield.dart';
import 'package:surebetcalc/widgets/custom_text.dart';

class BetCalc extends StatefulWidget {
  const BetCalc({super.key});

  @override
  State<BetCalc> createState() => _BetCalcState();
}

class _BetCalcState extends State<BetCalc> {
  int length = 2;
  String noOfWays = "Two";
  bool decimal = true;
  bool american = false;
  bool fractional = false;
  noOfWaysCalc(int val) {
    switch (val) {
      case 2:
        noOfWays = "Two";
      case 3:
        noOfWays = "Three";
      case 4:
        noOfWays = "Four";
      case 5:
        noOfWays = "Five";
      case 6:
        noOfWays = "Six";
      case 7:
        noOfWays = "Seven";
      case 8:
        noOfWays = "Eight";
      case 9:
        noOfWays = "Nine";
      case 10:
        noOfWays = "Ten";
      case 11:
        noOfWays = "Eleven";
      case 12:
        noOfWays = "Twelve";
      case 13:
        noOfWays = "Thirteen";
      case 14:
        noOfWays = "Fourteen";
      case 15:
        noOfWays = "Fifteen";
      case 16:
        noOfWays = "Sixteen";
      case 17:
        noOfWays = "Seventeen";
      case 18:
        noOfWays = "Eighteen";
      case 19:
        noOfWays = "Nineteen";
      case 20:
        noOfWays = "Twenty";
      default:
        noOfWays = "Two";
    }
  }

  @override
  Widget build(BuildContext context) {
    noOfWaysCalc(length);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          centerTitle: true,
          backgroundColor: appColor,
          surfaceTintColor: Colors.transparent,
          title: CustomText(
            text: "Surebet Calculator",
            size: 16,
            color: Colors.white,
            weight: FontWeight.bold,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "${noOfWays} Way",
                    size: 16,
                    weight: FontWeight.bold,
                  ),
                  InkWell(
                    onTap: () {
                      length = length + 1;
                      setState(() {});
                    },
                    child: CircleAvatar(
                      backgroundColor: appColor,
                      radius: 15,
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  )
                ],
              ),
              Divider(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CustomText(
                  text: "Profit:",
                  size: 16,
                  weight: FontWeight.w500,
                ),
                SizedBox(width: 15),
                CustomText(
                  text: "0%",
                  size: 16,
                  color: appColor,
                  weight: FontWeight.w500,
                )
              ]),
              SizedBox(height: 15),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CustomText(text: "Win:"),
                SizedBox(width: 15),
                CustomText(
                  text: "0.00",
                  color: appColor,
                  weight: FontWeight.w500,
                )
              ]),
              Divider(height: 30),
              Row(children: [
                CustomText(text: "Stake Amount", weight: FontWeight.w500),
                SizedBox(width: 30),
                Expanded(child: CurvedTextField()),
              ]),
              Divider(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                  onTap: () {
                    decimal = true;
                    american = false;
                    fractional = false;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: decimal ? appColor.withOpacity(0.3) : null,
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.bar_chart,
                          color: appColor,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        CustomText(
                          text: "Decimal",
                          color: appColor,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    decimal = false;
                    american = true;
                    fractional = false;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: american ? appColor.withOpacity(0.3) : null,
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit_document,
                          color: appColor,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        CustomText(
                          text: "American",
                          color: appColor,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    decimal = false;
                    american = false;
                    fractional = true;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: fractional ? appColor.withOpacity(0.3) : null,
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit_document,
                          color: appColor,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        CustomText(
                          text: "Fractional",
                          color: appColor,
                        ),
                      ],
                    ),
                  ),
                )
              ]),
              Divider(height: 30),
              Expanded(
                  child: ListView.separated(
                itemCount: length,
                itemBuilder: (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(children: [
                        CustomText(
                            text: "Odd ${index + 1}:", weight: FontWeight.w500),
                        SizedBox(width: 5),
                        SizedBox(
                            width: 70, height: 45, child: CurvedTextField())
                      ]),
                      Row(children: [
                        CustomText(text: "Amount:", weight: FontWeight.w500),
                        SizedBox(width: 5),
                        SizedBox(
                            width: 100, height: 45, child: CurvedTextField())
                      ]),
                      InkWell(
                        onTap: () {
                          if (length > 2) {
                            length = length - 1;
                            setState(() {});
                          }
                        },
                        child: Icon(
                          Icons.delete,
                          color: appColor,
                        ),
                      )
                    ]),
                separatorBuilder: (context, index) => Divider(height: 30),
              ))
            ],
          ),
        ),
      ),
    );
  }
}*/
