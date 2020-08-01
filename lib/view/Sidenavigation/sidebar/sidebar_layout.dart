import 'package:flutter/material.dart';
import 'package:flutter_app/view/Sidenavigation/pages/homepage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'sidebar.dart';

class SideBarLayout extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    var blocProvider = BlocProvider<NavigationBloc>(
        create: (context) {
          var navigationBloc = NavigationBloc(HomePage());
                    return navigationBloc;
        },
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc, NavigationStates>(
              builder: (context, navigationState) {
                return navigationState as Widget;
              },
            ),
            SideBar(),
          ],
        ),
      );
    return Scaffold(
      body: blocProvider,
    );
  }
}
