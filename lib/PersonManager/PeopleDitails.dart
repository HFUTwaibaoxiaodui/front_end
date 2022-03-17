import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constant/constant.dart';

class PeopleDitails extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String groupTitle;
  final String imageAssets;
  const PeopleDitails(Type friendsCell, {Key key, this.imageUrl, this.name, this.groupTitle, this.imageAssets}) : super(key: key);

  @override
  _PeopleDitailsState createState() => _PeopleDitailsState();
}


//头像布局
class SettingHead extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String groupTitle;
  final String imageAssets;
  final VoidCallback onPressed;

  SettingHead({this.onPressed, this.imageUrl, this.name, this.groupTitle, this.imageAssets});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
          onTap: onPressed,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 15.0),
                          child: const Text('头像',
                              style:
                              TextStyle(fontSize: 14, color: Colors.black)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            image: DecorationImage(
                              image: imageUrl != null
                                  ? NetworkImage(imageUrl)
                                  : AssetImage(imageAssets),
                            )),
                      ), //图片
                      Container(
                        margin: const EdgeInsets.only(left: 15.0, right: 15),
                        child: Image.asset(
                          Constant.ASSETS_IMG + "ic_arrow_right.png",
                          width: 15,
                          height: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 0.5,
                color: Colors.black12,
                //  margin: EdgeInsets.only(left: 60),
              ),
            ],
          )),
    );
  }
}

//普通条目布局
class SettingCommon extends StatelessWidget {
  final VoidCallback onPressed;

  const SettingCommon({this.title, this.content, this.onPressed});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: InkWell(
          onTap: onPressed,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 15.0),
                          child: Text(title,
                              style:
                              TextStyle(fontSize: 13, color: Colors.black)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(content,
                            style:
                            TextStyle(fontSize: 13, color: Colors.black)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5.0, right: 15),
                        child: Image.asset(
                          Constant.ASSETS_IMG + "ic_arrow_right.png",
                          width: 15,
                          height: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 0.5,
                color: Colors.black12,
                //  margin: EdgeInsets.only(left: 60),
              ),
            ],
          ),
        ));
  }
}

//, elevation: 0.5
class _PeopleDitailsState extends State<PeopleDitails> {
  @override
  // void initState() {
  //   super.initState();
  //   Constant.eventBus.on<ChangeInfoEvent>().listen((event) {
  //     setState(() {
  //       print("接收更换个人信息的消息");
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            '人员信息编辑',
            style: TextStyle(fontSize: 15),
          ),
          elevation: 0.5),
      body: Container(
        color: Color(0xffF2F2F2),
        child: ListView(
          children: <Widget>[
            SettingHead(onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    // return HeadChooseWidget(
                    //     chooseImgCallBack: (File mHeadFile) {
                    //       FormData formData = FormData.fromMap({
                    //         "userId": UserUtil.getUserInfo().id,
                    //         "headFile": MultipartFile.fromFileSync(mHeadFile.path)
                    //       });
                    //       request(ServiceUrl.updateHead, formData: formData)
                    //           .then((val) {
                    //         int code = val['status'];
                    //         if (code == 200) {
                    //           String mUrl = val['data'];
                    //           print("返回的头像的url:${mUrl}");
                    //           UserUtil.saveUserHeadUrl(mUrl);
                    //           ToastUtil.show('提交成功!');
                    //           setState(() {});
                    //         } else {
                    //           String msg = val['msg'];
                    //           ToastUtil.show(msg);
                    //         }
                    //       });
                    //     });
                  });
            }),
            SettingCommon(
                title: "账户名",
                content: "",
                // content: UserUtil.getUserInfo().nick,
                onPressed: () {

                  // Routes.navigateTo(context, '${Routes.changeNickNamePage}');
                }),
            SettingCommon(
                title: "用户名称",
                content: "",
                // content: UserUtil.getUserInfo().nick,
                onPressed: () {

                  // Routes.navigateTo(context, '${Routes.changeNickNamePage}');
                }),
            SettingCommon(
                title: "性别",
                content: "",
                onPressed: () {
                  // Routes.navigateTo(context, '${Routes.changeDescPage}');
                }),
            SettingCommon(
                title: "工号",
                content: "",
                onPressed: () {
                  //  ToastUtil.show('暂未开发!');
                }),
            SettingCommon(
                title: "手机号",
                content: "",
                onPressed: () {
                  // ToastUtil.show('暂未开发!');
                }),
            SettingCommon(
                title: "邮箱",
                content: "",
                onPressed: () {
                  // ToastUtil.show('暂未开发!');
                }),
            SettingCommon(
                title: "状态",
                content: "",
                onPressed: () {
                  // ToastUtil.show('暂未开发!');
                }),
            Container(
              height: 30,
              color: Color(0xffF2F2F2),
              //  margin: EdgeInsets.only(left: 60),
            ),
            // SettingCommon(
            //   title: "意见反馈",
            //   content: "",
            //   onPressed: () {
            //     // Routes.navigateTo(context, '${Routes.feedbackPage}');
            //   },
            // ),
            // SettingCommon(title: "关于微博", content: ""),
            // SettingCommon(title: "清理缓存", content: ""),
            Container(
              height: 30,
              color: Color(0xffF2F2F2),
              //  margin: EdgeInsets.only(left: 60),
            ),
            Material(
              color: Colors.white,
              child: InkWell(
                  onTap: () {
                    //Routes  .navigateTo(context, '${Routes.settingPage}');
                    showDialog(
                      context: context,
                      barrierDismissible: true, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text('删除人员?',style: TextStyle(fontSize: 12),),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('确定',style: TextStyle(fontSize: 12),),
                              onPressed: () {
                                // UserUtil.loginout();
                                // Navigator.of(context).pop();
                                // Routes.navigateTo(
                                //     context, '${Routes.loginPage}',
                                //     clearStack: true,
                                //     transition: TransitionType.fadeIn);
                              },
                            ),
                            FlatButton(
                              child: Text('取消',style: TextStyle(fontSize: 12),),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                          backgroundColor: Colors.white,
                          elevation: 20,
                          // 设置成 圆角
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                    ),
                    child: const Center(
                      child: Text('删除人员',
                          style: TextStyle(fontSize: 13, color: Colors.red)),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}