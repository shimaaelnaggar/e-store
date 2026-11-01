import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/core/di/service_locator.dart';
import 'package:store/core/routing/app_router.dart';
import 'package:store/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:store/features/cart/presentation/bloc/cart_event.dart';

import 'features/notifications/presentation/bloc/notification_bloc.dart';
import 'features/notifications/presentation/bloc/notification_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupAppServiceLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<CartBloc>()..add(GetCartEvent()),
        ),
        BlocProvider(
          create: (_) => getIt<NotificationBloc>()
            ..add(
                GetNotificationsEvent(
                  includeRead: false,
                  page: 1,
                  pageSize: 100,
                )
            ),
        ),
      ],
      child: const StoreApp(),
    ),
  );
}

class StoreApp extends StatelessWidget {
  const StoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: getIt<AppRouter>().goRouter,
      ),
    );
  }
}
