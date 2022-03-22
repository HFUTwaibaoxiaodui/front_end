import 'package:flutter/material.dart';
import 'package:frontend/Routes/routes.dart';
import 'package:frontend/global/back_end_interface_url.dart';
import 'package:http/http.dart' as Http;
import 'dart:convert';

import '../../widgets/order_list.dart';


class  searchBarDelegate extends SearchDelegate<String> {

  @override
  List<Widget>buildActions(BuildContext context){
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: ()=>query="",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress:transitionAnimation),
      onPressed: ()=>close(context,''),
    );

  }

  @override
  Widget buildResults(BuildContext context) {



    // recentSuggest.add(query);
    // return Center(
    //   child:Container(
    //     width: 100,
    //     height: 100,
    //     child:Card(
    //       color: Colors.redAccent,
    //       child: Text(query),
    //     ),
    //   ),
    // );
    return Container(
      child: OrderListWidget(
        withStatus: query,
      ),
    );

  }
  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList=query.isEmpty?
    recentSuggest:serchList.where((input) => input.startsWith(query)).toList();
    return ListView.builder(
      itemCount: suggestionList.length==0?0:suggestionList.length,
      itemBuilder: (context ,index)=>ListTile(
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0,query.length),
              style: TextStyle(
                  color: Colors.black,fontWeight: FontWeight.bold
              ),
              children: [
                TextSpan(
                    text:suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey)
                )
              ]
          ),
        ),
      ),
    );
  }



}
