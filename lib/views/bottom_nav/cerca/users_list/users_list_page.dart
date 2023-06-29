import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:student_link/widgets/users/user_box_style/user_box_style.dart';

class UsersListPage extends StatelessWidget {
  const UsersListPage({super.key});

  //TODO: CREARE LISTVIEW CON UNICO BOX E LISTA UTENTI E RENDERE CLICCABILE
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          UserBoxStyle(),
          UserBoxStyle(),
          UserBoxStyle(),
          UserBoxStyle(),
          UserBoxStyle(),
          UserBoxStyle(),
          UserBoxStyle(),
          UserBoxStyle(),
        ],
      ),
    );
  }
}
