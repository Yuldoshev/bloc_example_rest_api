import 'package:bloc_app/bloc/home_bottom_nav_cubit.dart';
import 'package:bloc_app/bloc/user_bloc.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  static const routName = '/home';

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildBottomNav(HomeBottomNavIndexBloc? homeBottomNavIndexBloc) {
    return ConvexAppBar(
      controller: _tabController,
      items: const [
        TabItem(icon: Icons.list, title: "List"),
        TabItem(icon: Icons.save, title: "Form"),
      ],
      height: 50,
      elevation: 5,
      color: Colors.white,
      onTap: (nIndex) {
        setState(() {
          homeBottomNavIndexBloc!.changeBottomNavIndex(nIndex);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBottomNavIndexBloc, int>(
      builder: (context, navIndex) {
        final HomeBottomNavIndexBloc homeBottomNavIndexBloc = context.read();
        return Scaffold(
          body: homeBottomNavIndexBloc.pages[navIndex],
          bottomNavigationBar: _buildBottomNav(homeBottomNavIndexBloc),
        );
      },
      listener: (context, state) {
        if (state == 0) {
          context.read<UserBloc>().loadUserList();
        }
        setState(() {
          _tabController.index = state;
        });
      },
    );
  }
}
