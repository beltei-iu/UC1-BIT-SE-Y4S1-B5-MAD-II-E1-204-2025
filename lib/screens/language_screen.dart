import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {

  bool _isEnglish = true;

  @override
  void initState() {
    super.initState();
    _isEnglish = Get.locale?.languageCode == 'en';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("language".tr),
          centerTitle: true,
          elevation: 0.5,
          backgroundColor: Colors.indigoAccent
      ),
      body: Column(
        children: [
            ListTile(
              title: Text("khmerLanguage".tr),
              leading: Icon(Icons.language),
              trailing: Checkbox(value: !_isEnglish, onChanged: (v){
                  Get.updateLocale(Locale('km', 'KH'));
                  setState(() {
                    _isEnglish = false;
                  });
              }),
              ),
          Divider(),
          ListTile(
            title: Text("englishLanguage".tr),
            leading: Icon(Icons.language),
            trailing: Checkbox(value: _isEnglish, onChanged: (v){
              Get.updateLocale(Locale('en', 'US'));
              setState(() {
                _isEnglish = true;
              });
            }),
          ),
          Divider(),
        ],
      ),
    );
  }
}
