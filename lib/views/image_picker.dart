import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Photo extends StatefulWidget {
  @override
  _PhotoState createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  final ImagePicker picker = new ImagePicker();
  List _imageList = []; //图片列表
  int _photoIndex = 0; //选择拍照还是相册的索引

  //action sheet
  List _actionSheet = [
    {"name": "拍照", "icon": Icon(Icons.camera_alt)},
    {"name": "相册", "icon": Icon(Icons.photo)}
  ];

  //拍照或者相册选取图片，只能单选
  Future _getImage() async {
    Navigator.of(context).pop();
    var image = await ImagePicker.pickImage(
        source: _photoIndex == 0 ? ImageSource.camera : ImageSource.gallery);

    //没有选择图片或者没有拍照
    if (image != null) {
      setState(() {
        _imageList.add(image);
      });
    }
  }

  //获取sheet选择
  Future _getActionSheet() async {
    await showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            padding: EdgeInsets.all(10.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _actionSheet.length,
              itemExtent: 50.0,
              itemBuilder: (innerCtx, i) {
                return ListTile(
                  title: Text(_actionSheet[i]["name"]),
                  leading: _actionSheet[i]["icon"],
                  onTap: () {
                    setState(() {
                      _photoIndex = i;
                    });
                    _getImage();
                  },
                );
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("拍照APP"),
      ),
      body: Column(
        children: [
          Row(
            children:[
                RaisedButton(
                child: Text("上传照片"),
                onPressed: () => _getActionSheet(),
              ),
              SizedBox(width: 10,),
              // Text("照片列表"),
              _imageList.isNotEmpty
              ? Wrap(
              spacing: 5.0,
              children: _getImageList(),
              )
                  : Text("暂无内容")
          ]
        )
        ],
      ),
    );
  }

  //图片列表的刻画
  List<Widget> _getImageList() {
    return _imageList.map((img) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: <Widget>[
            Image.file(
              img,
              fit: BoxFit.cover,
              width: 100.0,
              height: 70.0,
            ),
            Positioned(
              right: 5.0,
              top: 5.0,
              child: GestureDetector(
                child: ClipOval(
                  child: Container(
                    width: 15.0,
                    height: 15.0,
                    color: Colors.lightBlue,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 12.0,
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _imageList.remove(img);
                  });
                },
              ),
            )
          ],
        ),
      );
    }).toList();
  }
}