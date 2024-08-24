
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/src/home_cubit.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,

  });


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<HomeCubit>(
      create: (_) => HomeCubit(

      ),
      child: const HomeView(

      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,

  });



  @override
  Widget build(BuildContext context) {
    // final isTablet = !View.of(context).isSmallTabletOrLess;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
          ),
          body: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text('Home'),
              ),
            ],
          ),
        );
      },
    );
  }
}

