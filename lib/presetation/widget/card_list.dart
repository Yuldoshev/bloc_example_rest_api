import 'package:bloc_app/bloc/state/data_state.dart';
import 'package:bloc_app/bloc/user_bloc.dart';
import 'package:bloc_app/data/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List"),
      ),
      body: BlocBuilder<UserBloc, DataState<List<User>>>(
        builder: (context, state) {
          if (state is DataStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DataStateError) {
            return Center(
              child: Text(state.message ?? "Xatolik yuz berdi"),
            );
          }

          if (state is DataStateSuccess && state.data?.isNotEmpty == true) {
            return NotificationListener<ScrollEndNotification>(
              onNotification: (scrollEnd) {
                final metrics = scrollEnd.metrics;
                if (metrics.atEdge) {
                  bool isTop = metrics.pixels == 0;
                  if (isTop) {
                    print('Yuqorida');
                  } else {
                    print('Pastda');
                    var snackBar = const SnackBar(
                      content: Text('Siz oxirgi indeksdasiz'),
                      duration: Duration(milliseconds: 1500),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
                return true;
              },
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: state.data?.length,
                itemBuilder: (context, index) => Container(
                  color: index % 2 == 0 ? Colors.white : Colors.blue[50],
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Center(
                        child: Text(
                          "ID: ${state.data![index].id}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      "${state.data![index].title}",
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                    subtitle: Text(
                      "${state.data![index].body}",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
