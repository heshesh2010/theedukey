import 'package:flutter/material.dart';
import 'package:theedukey/elements/topbar.dart';
import '../controller/app_language.dart';
import '../elements/drawer.dart';
import '../models/language.dart';
import 'package:get/get.dart';
import 'package:theedukey/utils/local_storage/local_storage.dart';




class LanguagesScreen extends StatelessWidget {
   LanguagesScreen({Key? key}) : super(key: key);

  final AppLanguage controller = Get.put(AppLanguage());
 final LanguagesList languagesList = LanguagesList();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getTopBar(context),
      drawer:    DrawerSideMenu(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const SizedBox(height: 10),
            ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemCount: languagesList.languages.length,
              separatorBuilder: (context, index) {
                return const Divider(color: Colors.grey,);
              },
              itemBuilder: (context, index) {
                Language _language = languagesList.languages.elementAt(index);
               LocalStorage().languageSelected.then((langCode) {
      if (langCode == _language.code) {
    _language.selected = true;
    }
    });
                return InkWell(
                  onTap: () async {
                    if (_language.code=="ar") {
                      controller.changeLanguage("ar");

                    } else {
                      controller.changeLanguage("en");

                    }
                    for (var _l in languagesList.languages) {
                        _l.selected = false;
                    }
                    _language.selected = !_language.selected;
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: _language.selected ? 30 : 30,
                          width: _language.selected ? 30 : 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).focusColor),
                            borderRadius: const BorderRadius.all(Radius.circular(40)),
                            color: Colors.white.withOpacity(_language.selected ? 0.85 : 0.85),
                          ),
                          child: Icon(
                            Icons.circle,
                            size: _language.selected ? 20 : 20,
                            color: Theme.of(context).focusColor.withOpacity(_language.selected ? 0.85 : 0),
                          ),
                        ),

                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _language.englishName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                _language.localName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(40)),
                            image: DecorationImage(image: AssetImage(_language.flag), fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
  )
          ],
        ),
      ),
    );
  }
}
