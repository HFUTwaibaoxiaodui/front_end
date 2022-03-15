import 'package:flutter/material.dart';

class searchBarDelegate extends SearchDelegate<String> {
  @override
  //重写搜索栏中右侧的图标X
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = "", //点击X按钮，搜索的值置为空
      )
    ];
  }
  @override
//重写搜索页左侧的返回按钮
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, progress: transitionAnimation,
      ),
      onPressed: ()=>close(context,''), //点击图标就关闭之前的页面
    );
  }

  @override
  //重写搜索结果
  Widget buildResults(BuildContext context){
    return Container(
      height: 80.0,
      child: Card(
        color: Colors.blueGrey,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  @override
  //重写搜索内容
  Widget buildSuggestions(BuildContext context){
    final suggestionList = query.isEmpty
        ? recentSuggest
        : searchList.where((input)=> input.startsWith(query)).toList();
    return ListView.builder( //这是一个动态列表
      itemCount: suggestionList.length,
      itemBuilder: (context, index)=> ListTile(
          title: RichText( //富文本
              text: TextSpan( //给搜索到的字符加粗显示
                  text: suggestionList[index].substring(0,query.length),
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold
                  ),
                  children:[
                    TextSpan(
                        text: suggestionList[index].substring(query.length),
                        style: TextStyle(color: Colors.grey)
                    )
                  ]
              )
          )
      ),
    );
  }
}
const searchList = [
  "Text_1",
  "Text_2",
  "Fairy",
  "Beauty",
];

const recentSuggest = [
  "Demo-1",
  "Demo-2"
];