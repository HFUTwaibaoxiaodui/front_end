import 'package:flutter/material.dart';
import 'package:frontend/Routes/routes.dart';
import '../../widgets/order_list.dart';

class searchBarDelegate extends SearchDelegate<String> {

  @override
  List<Widget>buildActions(BuildContext context){
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: ()=> query="",
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
    return OrderListWidget(
      withOrderName: query,
    );

  }
  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty?
    recentSuggest:searchList.where((input) => input.startsWith(query)).toList();
    return ListView.builder(
      itemCount: suggestionList.isEmpty ? 0 : suggestionList.length,
      itemBuilder: (context ,index)=>ListTile(
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0,query.length),
              style: const TextStyle(
                  color: Colors.black,fontWeight: FontWeight.bold
              ),
              children: [
                TextSpan(
                    text:suggestionList[index].substring(query.length),
                    style: const TextStyle(color: Colors.grey)
                )
              ]
          ),
        ),
      ),
    );
  }
}
