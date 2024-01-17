import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmaconnectbyturjo/chatroom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class chatpage extends StatefulWidget {
  const chatpage({Key? key}) : super(key: key);

  @override
  State<chatpage> createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> with WidgetsBindingObserver {
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    setStatus("Online");
  }

  void setStatus(String status) async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .update({"status": status});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
    }
  }

  String chatRoomId(String user1, String user2) {
    if (user1 != null &&
        user1.isNotEmpty &&
        user2 != null &&
        user2.isNotEmpty) {
      String normalizedUser1 = user1.toLowerCase();
      String normalizedUser2 = user2.toLowerCase();

      // Ensure that the usernames are not empty after normalization
      if (normalizedUser1.isNotEmpty && normalizedUser2.isNotEmpty) {
        List<String> users = [normalizedUser1, normalizedUser2];
        // Sort the usernames to ensure consistency in generating the chat room ID
        users.sort();

        // Concatenate the sorted usernames to create the chat room ID
        return "${users[0]}${users[1]}";
      }
    }

    // Return an empty string if any of the conditions are not met
    return "";
  }

  void onSearch() async {
    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('users')
        .where("e-mail", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        isLoading = false;
      });
      if (value.docs.isNotEmpty) {
        setState(() {
          userMap = value.docs[0].data();
        });
        print(userMap);
      } else {
        // Handle the case where no matching user is found
        print("User not found");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Screen"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _auth.signOut();
              Navigator.pushNamed(context, 'LoginPage');
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(
        child: Container(
          height: size.height / 20,
          width: size.height / 20,
          child: CircularProgressIndicator(),
        ),
      )
          : Column(
        children: [
          SizedBox(
            height: size.height / 20,
          ),
          Container(
            height: size.height / 14,
            width: size.width,
            alignment: Alignment.center,
            child: Container(
              height: size.height / 14,
              width: size.width / 1.15,
              child: TextField(
                controller: _search,
                decoration: InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height / 50,
          ),
          ElevatedButton(
            onPressed: onSearch,
            child: Text("Search"),
          ),
          SizedBox(
            height: size.height / 20,
          ),
          userMap != null
              ? ListTile(
            onTap: () {
              String roomId = chatRoomId(
                  _auth.currentUser!.displayName!,
                  userMap!['user name']);

              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ChatRoom(
                  chatRoomId: roomId,
                  userMap: userMap!,
                ),
              ));
            },
            leading: UserProfilePicture(
              profilePictureUrl: userMap!['profileImageUrl'],
            ),
            title: Text(
              userMap!['user name'],
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(userMap!['e-mail']),
            trailing: Icon(Icons.chat, color: Colors.black),
          )
              : Container(),
        ],
      ),
    );
  }
}

class UserProfilePicture extends StatelessWidget {
  final String? profilePictureUrl;

  UserProfilePicture({this.profilePictureUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: profilePictureUrl != null
          ? NetworkImage(profilePictureUrl!)
          : AssetImage('assets/icon/user.png') as ImageProvider<Object>?, // Explicitly cast to ImageProvider<Object>?
      radius: 20, // Adjust the radius as needed
    );
  }
}

