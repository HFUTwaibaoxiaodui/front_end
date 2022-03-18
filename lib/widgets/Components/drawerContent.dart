import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List <Widget>drawerContent=[const UserAccountsDrawerHeader(
  accountName: Text("jbsteven"),
  accountEmail: Text("jbsteven79@gmail.com"),
  currentAccountPicture:
  CircleAvatar(backgroundImage: AssetImage("img/2.jpg")),
  decoration: BoxDecoration(
      color: Colors.yellow,
      image: DecorationImage(
          image: AssetImage(
              "img/5.jpg"),
          fit: BoxFit.cover)),
),
  ListTile(
    onTap: () {},
    title: const Text("个人中心"),
    leading: const CircleAvatar(child: Icon(Icons.people)),
  ),
  const Divider(),
  ListTile(
    onTap: () {},
    title: const Text("系统设置"),
    leading: const CircleAvatar(child: Icon(Icons.settings)),
  )];
