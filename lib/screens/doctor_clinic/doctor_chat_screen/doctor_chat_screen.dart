import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singleclinic/screens/doctor_clinic/custom_drawer.dart';
import 'package:singleclinic/utils/colors.dart';

class DoctorChatScreen extends StatefulWidget {
  const DoctorChatScreen({Key key}) : super(key: key);
  static String routeName = "doctorChatScreen";

  @override
  State<DoctorChatScreen> createState() => _DoctorChatScreenState();
}

class _DoctorChatScreenState extends State<DoctorChatScreen> {
  List<ChatList> chatList;
  List<ChatList> searchedChatList;
  var uid;
  TextEditingController searchController;

  loadChatList() {
    chatList = [
      ChatList(
        time: "2022-11-27",
        message: "Hello doctor sab",
        userId: uid,
        messageWith: "biman",
      ),
      ChatList(
          time: "2022-10-02",
          message: "Doctor sab when will you be free?",
          userId: uid,
          messageWith: "rina"),
      ChatList(
        time: "2020-05-27",
        message: "Hello ritu come to my clinic tomorrow for followup",
        userId: uid,
        messageWith: "ritu",
      ),
    ];
  }

  searchChat() {
    searchedChatList = [];
    chatList.forEach((element) {
      if (element.messageWith
          .toLowerCase()
          .contains(searchController.text.toLowerCase())) {
        setState(() {
          searchedChatList.add(element);
        });
      }
    });
  }

  @override
  void initState() {
    // SharedPreferences.getInstance().then((value) {
    //   setState(() {
    //     uid = value.getString("uid");
    //   });
    // });
    searchController = TextEditingController();
    loadChatList();

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: screenWidth / 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 7,
                          offset: Offset(3, 3))
                    ]),
                child: TextField(
                  controller: searchController,
                  onSubmitted: searchChat(),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                              BorderSide(color: primaryColor, width: 2)),
                      prefixIcon: Icon(Icons.search_outlined),
                      hintText: "Search"),
                ),
              ),
              SizedBox(
                height: screenWidth / 10,
              ),
              ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: searchedChatList.length != null
                      ? searchedChatList.length
                      : chatList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: screenWidth / 13),
                      child: GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Container(
                              width: screenWidth,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        child: Icon(
                                          CupertinoIcons.person_alt,
                                          color: primaryColor,
                                        ),
                                        height: screenWidth / 6,
                                        width: screenWidth / 6,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey.shade200,
                                                  blurRadius: 7,
                                                  offset: Offset(4, 4))
                                            ],
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: screenWidth / 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            searchedChatList.length != null
                                                ? searchedChatList[index]
                                                    .messageWith
                                                : chatList[index].messageWith,
                                            style: TextStyle(
                                              fontSize: 19,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(
                                            width: screenWidth / 2.3,
                                            child: Text(
                                              searchedChatList.length != null
                                                  ? searchedChatList[index]
                                                      .message
                                                  : chatList[index].message,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    searchedChatList.length != null
                                        ? searchedChatList[index].time
                                        : chatList[index].time,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: screenWidth / 20),
                              child: Divider(
                                thickness: 2,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class ChatList {
  String message;
  String time;
  int userId;
  String messageWith;

  ChatList({
    this.message,
    this.time,
    this.userId,
    this.messageWith,
  });
}
