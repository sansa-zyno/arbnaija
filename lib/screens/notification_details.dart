/*import 'package:surebetcalc/helpers/common.dart';
import 'package:surebetcalc/screens/notifications.dart';
import 'package:surebetcalc/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class NotificationDetails extends StatefulWidget {
  final Map map;
  const NotificationDetails({required this.map, super.key});

  @override
  State<NotificationDetails> createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends State<NotificationDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              InkWell(
                  onTap: () {
                    changeScreenReplacement(
                        context,
                        BottomNavbar(
                          username: "",
                          pageIndex: 0,
                          newpage: Notifications(),
                        ));
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                  )),
              Spacer(),
              CustomText(
                text: "Notifications",
                size: 16,
                weight: FontWeight.bold,
              ),
              Spacer()
            ],
          ),
          SizedBox(
            height: 15,
          ),
          CustomText(text: widget.map["title"]),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () async {
              if (!await launchUrl(Uri.parse(widget.map["youtubeLink"]))) {
                throw Exception('Could not launch');
              }
            },
            child: Image.asset(
              "assets/youtubeCard.png",
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}*/
