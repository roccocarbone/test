import 'package:flutter/material.dart';
import 'package:student_link/services/users/get_list_users/get_list_users.dart';
import 'package:student_link/widgets/users/user_box_style/user_box_style.dart';
import 'package:student_link/models/users/user.dart';

class UsersListPage extends StatefulWidget {
  UsersListPage({Key? key}) : super(key: key);

  @override
  _UsersListPageState createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  int page = 0;
  List<User> users = [];
  bool isLoading = false;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadData();

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent &&
          !isLoading) {
        _loadData();
      }
    });
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<User> newUsers = await GetListUsers.getUsers(context, page);
      setState(() {
        users.addAll(newUsers);
        page++;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Gestisci l'errore come preferisci, ad esempio mostrando un messaggio
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      itemCount: users.length + (isLoading ? 1 : 0), // +1 se sta caricando
      itemBuilder: (BuildContext context, int index) {
        if (index == users.length) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return UserBoxStyle(users[index]);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
