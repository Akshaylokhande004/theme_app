import 'package:flutter/material.dart';
import 'package:theme_app/store/theme_store.dart';
import 'package:provider/provider.dart';
// import 'package:theme_app/generated/codegen_loader.g.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:easy_localization/easy_localization.dart';

import 'db/db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await db.init();
  MultiProvider(providers: [
    Provider<ThemeStore>(create: (_) => ThemeStore()),
  ]);

  runApp(
    EasyLocalization(
        supportedLocales: [
          Locale('en'),
          Locale('es'),
          Locale('hi'),
          Locale('mr')
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeStore = ThemeStore();

    return Provider(
      create: (_) => themeStore,
      child: Observer(
        builder: (context) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            title: 'Flutter Demo',
            theme: ThemeData(),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
            ),

            themeMode: themeStore.isDark ? ThemeMode.dark : ThemeMode.light,

            home: const MainView(),
            // home: const FirstView(),
          );
        },
      ),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<ThemeStore>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Theme Change')),
        leading: Observer(
          builder: (context) {
            return Center(
              child: Switch(
                value: store.isDark,
                onChanged: (val) {
                  store.toggleTheme(val);
                },
              ),
            );
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          const SizedBox(
            height: 200,
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondRoute()),
                );
              },
              child: const Text(
                'Next',
                style: TextStyle(
                  fontSize: 20,
                ),
              ))
        ],
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Second Route'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('hi_text'.tr()),
              const SizedBox(height: 30),
              Text('Im_from_pune'.tr()),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      context.setLocale(const Locale("en"));
                    },
                    child: const Text('English'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.setLocale(const Locale("es"));
                    },
                    child: const Text('Inglés'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.setLocale(const Locale("hi"));
                    },
                    child: const Text('अंग्रेज़ी'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.setLocale(const Locale("mr"));
                    },
                    child: const Text('इंग्रजी'),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
