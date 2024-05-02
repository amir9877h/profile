import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  ThemeMode _themeMode = ThemeMode.dark;
  Locale _locale = Locale('fa');

  @override
  Widget build(BuildContext context) {
    Color surfaceColor = Color(0x0dffffff);
    Color primaryColor = Colors.pink.shade400;

    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('fa'), // Persian
      ],
      locale: _locale,
      theme: _themeMode == ThemeMode.dark
          ? MyAppThemeConfig.dark().getTheme(_locale.languageCode)
          : MyAppThemeConfig.light().getTheme(_locale.languageCode),
      home: MyHomePage(
        toggleThemeMode: () {
          setState(() {
            _themeMode =
                _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
          });
        },
        selectedLanguageChanged: (_Languages newSelectedLanguageByUser) {
          setState(() {
            _locale = newSelectedLanguageByUser == _Languages.fa
                ? Locale('fa')
                : Locale('en');
          });
        },
      ),
    );
  }
}

class MyAppThemeConfig {
  static const faPrimaryFontFamily = 'IranYekan';
  static final Color primaryColor = Colors.pink.shade400;
  final Color primaryTextColor;
  final Color secondryTextColor;
  final Color surfaceColor;
  final Color backgroundColor;
  final Color appBarColor;
  final Brightness brightness;

  MyAppThemeConfig.dark()
      : primaryTextColor = Colors.white,
        secondryTextColor = Colors.white70,
        surfaceColor = Color(0x0dffffff),
        backgroundColor = Color.fromARGB(255, 30, 30, 30),
        appBarColor = Colors.black,
        brightness = Brightness.dark;

  MyAppThemeConfig.light()
      : primaryTextColor = Colors.grey.shade900,
        secondryTextColor = Colors.grey.shade900.withOpacity(0.8),
        surfaceColor = Color(0x0d000000),
        backgroundColor = Colors.white,
        appBarColor = Color.fromARGB(255, 235, 235, 235),
        brightness = Brightness.light;

  ThemeData getTheme(String languageCode) {
    return ThemeData(
      // This is the theme of your application.
      //
      // TRY THIS: Try running your application with "flutter run". You'll see
      // the application has a purple toolbar. Then, without quitting the app,
      // try changing the seedColor in the colorScheme below to Colors.green
      // and then invoke "hot reload" (save your changes or press the "hot
      // reload" button in a Flutter-supported IDE, or press "r" if you used
      // the command line to start the app).
      //
      // Notice that the counter didn't reset back to zero; the application
      // state is not lost during the reload. To reset the state, use hot
      // restart instead.
      //
      // This works for code too, not just values: Most code changes can be
      // tested with just a hot reload.
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        // border: InputBorder.none,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: surfaceColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primaryColor))),
      primarySwatch: Colors.blue,
      primaryColor: primaryColor,
      brightness: brightness,
      dividerColor: surfaceColor, //Colors.white,
      dividerTheme: const DividerThemeData(
          color: Colors.white, indent: 32, endIndent: 32, thickness: 0.5),
      appBarTheme: AppBarTheme(
          elevation: 0, //removing appbar shadow
          backgroundColor: appBarColor,
          foregroundColor: primaryTextColor),
      scaffoldBackgroundColor: backgroundColor,
      textTheme: languageCode == 'en' ? enFont : faFont,
      // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      // useMaterial3: true,
    );
  }

  TextTheme get enFont => GoogleFonts.latoTextTheme(TextTheme(
        bodySmall:
            TextStyle(fontSize: 11, color: Color.fromARGB(200, 255, 255, 255)),
        bodyMedium: TextStyle(fontSize: 13, color: secondryTextColor),
        bodyLarge: TextStyle(fontSize: 15, color: primaryTextColor),
        titleLarge:
            TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor),
        titleMedium: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: primaryTextColor),
      ));

  TextTheme get faFont => TextTheme(
        bodySmall:
            TextStyle(fontSize: 11, color: Color.fromARGB(200, 255, 255, 255)),
        bodyMedium: TextStyle(
            fontSize: 15,
            height: 1.5,
            color: secondryTextColor,
            fontFamily: faPrimaryFontFamily),
        bodyLarge: TextStyle(
            fontSize: 15,
            color: primaryTextColor,
            fontFamily: faPrimaryFontFamily),
        titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
            fontFamily: faPrimaryFontFamily),
        titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
            fontFamily: faPrimaryFontFamily),
        labelLarge: TextStyle(fontFamily: faPrimaryFontFamily),
      );
}

enum _SkillType { photoshop, lightroom, afterEffect, xd, illustrator }

enum _Languages { en, fa }

// main page of application
class MyHomePage extends StatefulWidget {
  final Function() toggleThemeMode;
  final Function(_Languages _language) selectedLanguageChanged;

  const MyHomePage(
      {super.key,
      required this.toggleThemeMode,
      required this.selectedLanguageChanged});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _SkillType? _skill;
  _Languages _language = _Languages.fa;

  void _updateSelectedSkill(_SkillType skillType) {
    setState(() {
      this._skill = skillType;
    });
  }

  void _updateSelectedLanguage(_Languages language) {
    widget.selectedLanguageChanged(language);
    setState(() {
      this._language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.profileTitle),
        actions: [
          Icon(CupertinoIcons.chat_bubble),
          // SizedBox(width: 4,),
          InkWell(
            onTap: widget.toggleThemeMode,
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
              child: Icon(CupertinoIcons.ellipsis_vertical),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/images/profile_image.png",
                      width: 60,
                      height: 60,
                    )),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(localizations.name,
                          style: Theme.of(context).textTheme.titleMedium),
                      Text(localizations.job),
                      Row(
                        children: [
                          Icon(CupertinoIcons.location,
                              size: 16,
                              color:
                                  Theme.of(context).textTheme.bodySmall!.color),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            localizations.location,
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Icon(CupertinoIcons.heart,
                    color: Theme.of(context).primaryColor)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(32, 0, 32, 16),
            child: Text(localizations.summary),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(localizations.selectedLanguage),
                CupertinoSlidingSegmentedControl<_Languages>(
                  thumbColor: MyAppThemeConfig.primaryColor,
                    groupValue: _language, // meghdar avalie chie?
                    children: {
                      _Languages.en: Text(localizations.enLanguage),
                      _Languages.fa: Text(localizations.faLanguage)
                    },
                    onValueChanged: ((value) =>
                        _updateSelectedLanguage(value!)))
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 0, 32, 20),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text(
                localizations.skills,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w900),
              ),
              const Icon(
                CupertinoIcons.chevron_down,
                size: 12,
              ),
            ]),
          ),
          Center(
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 8,
              runSpacing: 8,
              children: [
                Skill(
                  type: _SkillType.photoshop,
                  title: 'Photoshop',
                  imagePath: 'assets/images/app_icon_01.png',
                  backgroundShadow: Colors.blue,
                  isActive: _skill == _SkillType.photoshop,
                  onTap: () => _updateSelectedSkill(_SkillType.photoshop),
                ),
                Skill(
                  type: _SkillType.lightroom,
                  title: 'Lightroom',
                  imagePath: 'assets/images/app_icon_02.png',
                  backgroundShadow: Colors.blue,
                  isActive: _skill == _SkillType.lightroom,
                  onTap: () => _updateSelectedSkill(_SkillType.lightroom),
                ),
                Skill(
                  type: _SkillType.afterEffect,
                  title: 'After Effect',
                  imagePath: 'assets/images/app_icon_03.png',
                  backgroundShadow: Colors.blue.shade800,
                  isActive: _skill == _SkillType.afterEffect,
                  onTap: () => _updateSelectedSkill(_SkillType.afterEffect),
                ),
                Skill(
                  type: _SkillType.illustrator,
                  title: 'Illustrator',
                  imagePath: 'assets/images/app_icon_04.png',
                  backgroundShadow: Colors.orange,
                  isActive: _skill == _SkillType.illustrator,
                  onTap: () => _updateSelectedSkill(_SkillType.illustrator),
                ),
                Skill(
                  type: _SkillType.xd,
                  title: 'Adobe Xd',
                  imagePath: 'assets/images/app_icon_05.png',
                  backgroundShadow: Colors.pink,
                  isActive: _skill == _SkillType.xd,
                  onTap: () => _updateSelectedSkill(_SkillType.xd),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(localizations.personalInformation,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w900)),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: localizations.email,
                    prefixIcon: Icon(CupertinoIcons.at),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: localizations.password,
                    prefixIcon: Icon(CupertinoIcons.lock),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                        onPressed: () {}, child: Text(localizations.save))),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class Skill extends StatelessWidget {
  final _SkillType type;
  final String title;
  final String imagePath;
  final Color backgroundShadow;
  final bool isActive;
  final Function() onTap;

  const Skill({
    super.key,
    required this.title,
    required this.imagePath,
    required this.backgroundShadow,
    required this.isActive,
    required this.type,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: 120,
        height: 100,
        decoration: isActive
            ? BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(16),
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: isActive
                  ? BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: backgroundShadow.withOpacity(0.5),
                            blurRadius: 20),
                      ],
                    )
                  : null,
              child: Image.asset(
                imagePath,
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(title)
          ],
        ),
      ),
    );
  }
}
