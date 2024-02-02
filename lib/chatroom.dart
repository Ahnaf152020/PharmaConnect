import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class Message {
  final String text;
  final String senderUid;
  final bool isSeen; // Add this field

  Message({
    required this.text,
    required this.senderUid,
    required this.isSeen,
  });
}

class ChatRoom extends StatefulWidget {
  final Map<String, dynamic> userMap;
  final String chatRoomId;

  ChatRoom({required this.chatRoomId, required this.userMap});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _message = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  File? imageFile;

  Future getImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage();
      }
    });
  }

  Future<void> uploadImage() async {
    String fileName = Uuid().v1();

    try {
      await _firestore
          .collection('chatroom')
          .doc(widget.chatRoomId)
          .collection('chats')
          .doc(fileName)
          .set({
        "sendby": _auth.currentUser!.displayName,
        "message": "", // Leave it empty initially for images
        "type": "img",
        "time": FieldValue.serverTimestamp(),
        "seen": false, // Add seen status for new messages
      });

      var ref = FirebaseStorage.instance.ref().child('images').child(
          "$fileName.jpg");

      await ref.putFile(imageFile!);

      String imageUrl = await ref.getDownloadURL();

      await _firestore
          .collection('chatroom')
          .doc(widget.chatRoomId)
          .collection('chats')
          .doc(fileName)
          .update({"message": imageUrl, "seen": true}); // Mark as seen when updating message
      print(imageUrl);
    } catch (error) {
      print("Error uploading image: $error");

      // If an error occurs during image uploading, delete the Firestore document
      await _firestore
          .collection('chatroom')
          .doc(widget.chatRoomId)
          .collection('chats')
          .doc(fileName)
          .delete();
    }
  }

  void markMessagesAsSeen() async {
    String userUid = widget.userMap['uid'];

    QuerySnapshot messages = await _firestore
        .collection('chatroom')
        .doc(widget.chatRoomId)
        .collection('chats')
        .where('sendby', isEqualTo: userUid)
        .get();

    for (QueryDocumentSnapshot message in messages.docs) {
      await message.reference.update({'seen': true});
    }
  }

  @override
  void initState() {
    super.initState();
    // Call markMessagesAsSeen when the widget is initialized
    markMessagesAsSeen();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<DocumentSnapshot>(
          stream: _firestore
              .collection("users")
              .doc(widget.userMap['uid'])
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String? profileImageUrl = snapshot.data!['profileImageUrl'];

              return Container(
                child: Row(
                  children: [
                    // Check if the user has a profile image
                    profileImageUrl != null && profileImageUrl.isNotEmpty
                        ? CircleAvatar(
                      backgroundImage: NetworkImage(profileImageUrl),
                      radius: 20,
                    )
                        : Icon(Icons.account_circle, size: 40),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.userMap['user name']),
                        Text(
                          snapshot.data!['status'],
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height / 1.25,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('chatroom')
                    .doc(widget.chatRoomId)
                    .collection('chats')
                    .orderBy("time", descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> map = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        return messages(size, map, context);
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Container(
              height: size.height / 10,
              width: size.width,
              alignment: Alignment.center,
              child: Container(
                height: size.height / 12,
                width: size.width / 1.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height / 17,
                      width: size.width / 1.3,
                      child: TextField(
                        controller: _message,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () => getImage(),
                              icon: Icon(Icons.photo),
                            ),
                            hintText: "Send Message",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: onSendMessage,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> message = {
        "sendby": _auth.currentUser!.displayName,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
        "seen": false,
      };

      _message.clear();
      await _firestore
          .collection('chatroom')
          .doc(widget.chatRoomId)
          .collection('chats')
          .add(message);
    } else {
      print("Enter Some Text");
    }
  }

  Widget messages(Size size, Map<String, dynamic> map, BuildContext context) {
    String senderName = map['sendby']; // Assuming sender's email/name is stored in 'sendby'
    DateTime timestamp = DateTime.now(); // Add timestamp for the message

    bool isCurrentUser = senderName == _auth.currentUser!.displayName;

    return Column(
      crossAxisAlignment: isCurrentUser
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Container(
          width: size.width,
          alignment: isCurrentUser
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Text(
            senderName,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: isCurrentUser ? Colors.lightBlue : Colors.green,
            ),
          ),
        ),
        map['type'] == "text"
            ? Container(
          width: size.width,
          alignment: isCurrentUser
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: isCurrentUser
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                margin:
                EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: isCurrentUser ? Colors.red : Colors.green,
                ),
                child: Text(
                  map['message'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              // Add timestamp for text messages
              Padding(
                padding: EdgeInsets.only(
                    left: isCurrentUser ? 0 : 8,
                    right: isCurrentUser ? 8 : 0),
                child: Text(
                  timestamp.toString(),
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ),
              // Display seen status
              if (isCurrentUser)
                Padding(
                  padding: EdgeInsets.only(
                      left: isCurrentUser ? 0 : 8,
                      right: isCurrentUser ? 8 : 0),
                  child: Text(
                    map['seen'] ? 'Seen' : 'Delivered',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.blue,
                    ),
                  ),
                ),
            ],
          ),
        )
            : InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ShowImage(
                imageUrl: map['message'],
              ),
            ),
          ),
          child: Container(
            height: size.height / 2.5,
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            alignment: isCurrentUser
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: isCurrentUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height / 2.5,
                    width: size.width / 2,
                    decoration: BoxDecoration(border: Border.all()),
                    alignment: Alignment.center,
                    child: map['message'] != "" && map['message'] != null
                        ? isNetworkUrl(map['message'])
                        ? Image.network(
                      map['message'],
                      fit: BoxFit.cover,
                    )
                        : Image.file(
                      File(map['message']),
                      fit: BoxFit.cover,
                    )
                        : CircularProgressIndicator(),
                  ),
                  // Add timestamp for image messages
                  Padding(
                    padding: EdgeInsets.only(
                        left: isCurrentUser ? 0 : 8,
                        right: isCurrentUser ? 8 : 0),
                    child: Text(
                      timestamp.toString(),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  // Display seen status
                  if (isCurrentUser)
                    Padding(
                      padding: EdgeInsets.only(
                          left: isCurrentUser ? 0 : 8,
                          right: isCurrentUser ? 8 : 0),
                      child: Text(
                        map['seen'] ? 'Seen' : 'Delivered',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// show image in chat
class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(imageUrl),
      ),
    );
  }
}

bool isNetworkUrl(String url) {
  return Uri.parse(url).isAbsolute;
}
