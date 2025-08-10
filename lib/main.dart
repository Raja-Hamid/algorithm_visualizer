import 'package:algorithm_visualizer/ui/screens/selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 915),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const SelectionScreen(),
        );
      },
    );
  }
}
