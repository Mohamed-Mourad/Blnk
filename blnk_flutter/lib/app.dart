import 'package:blnk_flutter/blocs/info/info_bloc.dart';
import 'package:blnk_flutter/blocs/info/info_states.dart';
import 'package:blnk_flutter/screens/create_account.dart';
import 'package:blnk_flutter/screens/id_capture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InfoBloc(),
      child: BlocBuilder<InfoBloc, InfoState>(
        builder: (context, state) {
          SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent
            ),
          );
          return MaterialApp(
            title: 'Blnk Banking',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, primary: Colors.blue),
              useMaterial3: true,
            ),
            home: const CreateAccount(initialPage: 0),
          );
        },
      ),
    );
  }
}
