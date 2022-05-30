import 'package:flutter/material.dart';

import 'package:bazaar/screens/edit_screen.dart';

class UserProducts extends StatelessWidget {
  final String id;
  final String title;
  final String imgUrl;

  const UserProducts({
    Key? key,
    required this.id,
    required this.title,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imgUrl),
          ),
          trailing: Container(
            width: 99,
            // height: 120,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditScreen.routeName, arguments: id);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
