import 'package:flutter/material.dart';
import 'package:student_link/services/users/get_list_users/get_list_users.dart';
import 'package:student_link/widgets/users/user_box_style/user_box_style.dart';
import 'package:student_link/models/users/user.dart';
class UsersListPage extends StatelessWidget {
  const UsersListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: GetListUsers.getUsers(context),
      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: snapshot.data!
                  .map((User user) => UserBoxStyle(user))
                  .toList(),
            ),
          );
        }
      },
    );
  }
}
