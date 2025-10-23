import 'package:alif_electronics/models/expense/expense_model.dart';
import 'package:alif_electronics/models/spare_parts/spare_parts_model.dart';
import 'package:alif_electronics/models/used_tv/used_tv_model.dart';
import 'package:alif_electronics/models/work/work_model.dart';
import 'package:alif_electronics/presentation/splash_screen.dart';
import 'package:alif_electronics/provider/expense_provider.dart';
import 'package:alif_electronics/provider/home_provider.dart';
import 'package:alif_electronics/provider/report_provider.dart';
import 'package:alif_electronics/provider/spare_parts_provider.dart';
import 'package:alif_electronics/provider/usedtv_provider.dart';
import 'package:alif_electronics/provider/wallet_provider.dart';
import 'package:alif_electronics/provider/work_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:alif_electronics/models/spare_parts_used/spare_parts_used.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SparepartsModelAdapter());
  Hive.registerAdapter(UsedTvModelAdapter());
  Hive.registerAdapter(WorkModelAdapter());
  Hive.registerAdapter(SparePartUsageAdapter());
  Hive.registerAdapter(ExpenseModelAdapter());
  await Hive.openBox<SparepartsModel>('spare_parts');
  await Hive.openBox<dynamic>('profile');
  await Hive.openBox<UsedTvModel>('used_tv_box');
  await Hive.openBox<WorkModel>('work_box');
  await Hive.openBox<Map>('categories');
  await Hive.openBox<SparePartUsage>('spare_parts_box');
  await Hive.openBox<ExpenseModel>('expenses');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SparePartsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WorkProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UsedtvProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WalletProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReportProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ExpenseProvider(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(394, 854),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          theme: ThemeData(
              textTheme: GoogleFonts.robotoTextTheme(),
              scaffoldBackgroundColor: Colors.white),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        ),
      ),
    ),
  );
}
