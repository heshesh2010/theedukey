import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/utils/local_storage.dart';
import '../../../../elements/drawer.dart';
import '../../../../elements/topbar.dart';
import '../../../data/models/language.dart';
import '../controllers/language_controller.dart';

class LanguageView extends GetWidget<LanguageController> {
  LanguageView({Key? key}) : super(key: key);

  final LanguagesList languagesList = LanguagesList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getTopBar(context, title: 'language'.tr),
      drawer: DrawerSideMenu(),
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
                return const Divider(
                  color: Colors.grey,
                );
              },
              itemBuilder: (context, index) {
                Language language = languagesList.languages.elementAt(index);

                if (LocalStorage().getlanguageSelected() == language.code) {
                  language.selected = true;
                }

                return InkWell(
                  onTap: () async {
                    if (language.code == "ar") {
                      controller.changeLanguage("ar");
                    } else {
                      controller.changeLanguage("en");
                    }
                    for (var l in languagesList.languages) {
                      l.selected = false;
                    }
                    language.selected = !language.selected;
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: language.selected ? 30 : 30,
                          width: language.selected ? 30 : 30,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Theme.of(context).focusColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40)),
                            color: Colors.white
                                .withOpacity(language.selected ? 0.85 : 0.85),
                          ),
                          child: Icon(
                            Icons.circle,
                            size: language.selected ? 20 : 20,
                            color: Theme.of(context)
                                .focusColor
                                .withOpacity(language.selected ? 0.85 : 0),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                language.englishName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                language.localName,
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40)),
                            image: DecorationImage(
                                image: AssetImage(language.flag),
                                fit: BoxFit.cover),
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
