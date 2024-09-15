import 'package:flutter/material.dart';
import 'package:rlv2_flutter/counter/counter.dart';
import 'package:rlv2_flutter/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
      colorScheme: const ColorScheme(
          primary:  Color(0xFF37474F), 
          onPrimary: Colors.white,    
          secondary: Color(0xFFFF5722), 
          onSecondary: Colors.white,  
          surface: Color(0xFFECEFF1), 
          onSurface: Colors.black,    
          error: Color(0xFFB00020),   
          onError: Colors.white,      
          brightness: Brightness.light, 
          inversePrimary: Color(0xFF00BFA5),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF37474F), 
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const CounterPage(),
    );
  }
}
