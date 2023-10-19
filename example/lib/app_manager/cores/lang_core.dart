import 'package:app_manager/app_manager.dart';

class LangCore extends AppManagerCore<AppLangs, LangModel> {
  @override
  AppLangs get defaultMode => AppLangs.eng;

  @override
  AppManagerUtilOptions<AppLangs>? get util => AppManagerUtilOptions(
        util: AppManagerUtil.theme,
        system: AppLangs.system,
      );

  @override
  Map<AppLangs, LangModel> get modes => {
        AppLangs.eng: LangModel(
          title: "App Manager",
          text:
              "This text will be in a different language if you change its mode.",
        ),
        AppLangs.tr: LangModel(
          title: "Uygulama Yöneticisi",
          text: "Bu yazı dil modunu değiştirince farklı bir dilde olucak.",
        ),
        AppLangs.de: LangModel(
          title: "App Manager",
          text:
              "Dieser Text wird in einer anderen Sprache sein, wenn Sie seinen Modus ändern.",
        ),
        AppLangs.lorem: LangModel(
          title: "Ipsum Officia",
          text: "Consectetur in incididunt ut velit aute anim laboris irure.",
        ),
      };
}

enum AppLangs {
  system,
  eng,
  tr,
  de,
  lorem;
}

class LangModel {
  final String title;
  final String text;

  LangModel({
    required this.title,
    required this.text,
  });
}
