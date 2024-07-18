import 'package:google_fonts/google_fonts.dart';
import 'package:surebetcalc/widgets/custom_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 50,
          centerTitle: true,
          backgroundColor: Color(0xff227324),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
          title: CustomText(
            text: "About Us",
            size: 16,
            color: Colors.white,
            weight: FontWeight.bold,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w400,
                            height: 1.5),
                        children: [
                      TextSpan(
                          text:
                              "Welcome to Arbnaija, your premier destination for the latest and most lucrative arbitrage betting opportunities. At Arbnaija, we specialize in providing up-to-date information and insights that help you maximize your betting profits with minimal risk.\n\n"),
                      TextSpan(
                          text: "What We Do\n\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                          text:
                              "Our mission is to empower bettors with the knowledge and tools needed to exploit arbitrage opportunities. We constantly monitor and analyze betting markets to identify mismatched odds that guarantee a profit, regardless of the outcome. By subscribing to our service, you gain access to real-time updates and expert advice that keeps you ahead of the game.\n\n"),
                      TextSpan(
                          text: "VIP Daily Tips\n\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                          text:
                              "For just 5,000 Naira per month, our subscribers can join our exclusive VIP Daily Tips program. This premium service offers:\n\n"),
                      TextSpan(
                          text:
                              "Daily Arbitrage Opportunities: Receive handpicked, high-value arbitrage bets every day to ensure consistent profits.\nExpert Analysis: Get insights and detailed explanations on how each opportunity works, ensuring you make informed decisions.\nEarly Alerts: Be the first to know about the latest arbitrage opportunities before they disappear.\nDedicated Support: Access personalized support to help you navigate and maximize each betting opportunity effectively.\nGet in Touch\n\n"),
                      TextSpan(
                          text:
                              "To subscribe or learn more about our services, contact us via:\n\n"),
                      TextSpan(children: [
                        TextSpan(text: "Email: "),
                        TextSpan(
                            text: "arbnaija@gmail.com\n\n",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchEmail();
                              },
                            style: TextStyle(
                              color: Colors.blue,
                            ))
                      ]),
                      TextSpan(children: [
                        TextSpan(text: "Phone/WhatsApp: "),
                        TextSpan(
                            text: "+234 911 613 5188\n\n",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchCall();
                              },
                            style: TextStyle(
                              color: Colors.blue,
                            ))
                      ]),
                      TextSpan(children: [
                        TextSpan(text: "Telegram channel: "),
                        TextSpan(
                            text: "https://t.me/arbnaija\n\n",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchTelegram();
                              },
                            style: TextStyle(
                              color: Colors.blue,
                            ))
                      ]),
                      TextSpan(children: [
                        TextSpan(text: "Whatsapp channel: "),
                        TextSpan(
                            text:
                                "https://whatsapp.com/channel/0029VadIxYiDeONG086lTz1P\n\n",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchWhatsapp();
                              },
                            style: TextStyle(
                              color: Colors.blue,
                            ))
                      ]),
                      TextSpan(
                          text: "About Paucha Technology\n\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                          text:
                              "Arbnaija is a product of Paucha Technology, a forward-thinking company based in Oyo State, Nigeria. We are dedicated to leveraging technology to create innovative solutions that enhance our clients' financial success.\n\n"),
                      TextSpan(
                          text:
                              "Join Arbnaija today and start making the most of your betting endeavors!\n\n"),
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future launchEmail() async {
    final url = 'mailto:"arbnaija@gmail.com"';
    await launchUrl(Uri.parse(url));
  }

  Future launchCall() async {
    final url = 'tel:"+2349116135188"';
    await launchUrl(Uri.parse(url));
  }

  Future<void> launchTelegram() async {
    final url = 'https://t.me/arbnaija';
    await launchUrl(Uri.parse(url));
  }

  Future<void> launchWhatsapp() async {
    final url = 'https://whatsapp.com/channel/0029VadIxYiDeONG086lTz1P';
    await launchUrl(Uri.parse(url));
  }
}
