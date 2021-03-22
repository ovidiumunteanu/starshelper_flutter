import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:starshelper_app/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:starshelper_app/utils/global.dart';

Widget loadPosts(context, post) {
  return Card(
    margin: EdgeInsets.fromLTRB(20, 5, 10, 5),
    color: Colors.blue,
    elevation: 5.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Index Offer:           ' + post['indexOffer'],
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Index Request:     ' + post['indexRequest'],
              style: TextStyle(color: Colors.white),
            ),
            // Text(
            //   'Matric Number:    ' + post.matricNum,
            //   style: TextStyle(color: Colors.white),
            // ),
            // Text(
            //   'Password:             ' + post.password,
            //   style: TextStyle(color: Colors.white),
            // ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // 'contact' Button and its popup window
            RaisedButton(
              color: Colors.blue[100],
              onPressed: () => {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 16,
                        child: Container(
                          height: 200.0,
                          width: 360.0,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Title(
                                title: 'Title1',
                                child: Text(
                                  'Contact Information',
                                  style: TextStyle(
                                      color: Colors.blue[700],
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                color: Colors.blueAccent,
                              ),
                              createContactInfoWidgets(
                                  'Phone :', post['phoneNum']),
                              createContactInfoWidgets(
                                  'Email :', post['email']),
                              RaisedButton(
                                onPressed: () => {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          elevation: 16,
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                20, 20, 20, 0),
                                            height: 210.0,
                                            width: 360.0,
                                            child: Column(
                                              children: [
                                                TextField(
                                                  minLines: 5,
                                                  maxLines: 5,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'Enter Your Message.',
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  2.0)),
                                                    ),
                                                  ),
                                                ),
                                                FlatButton(
                                                  color: Colors.grey[300],
                                                  child: Text('Send'),
                                                  onPressed: () {},
                                                ),
                                              ],
                                            ),
                                          ));
                                    },
                                  )
                                },
                                child: Text('Send Message'),
                              )
                            ],
                          ),
                        ));
                  },
                )
              },
              child: Text('Contact'),
            )
          ],
        )
      ],
    ),
  );
}

Widget loadMyPosts(context, post, index, snapshot) {
  return Card(
    margin: EdgeInsets.fromLTRB(20, 5, 10, 5),
    color: Colors.blue,
    elevation: 5.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Index Offer:           ' + post['indexOffer'],
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Index Request:     ' + post['indexRequest'],
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // 'contact' Button and its popup window
            RaisedButton(
              child: Text('Delete'),
              color: Colors.blue[100],
              onPressed: () => {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 16,
                        child: Container(
                          height: 150.0,
                          width: 100.0,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Title(
                                  title: 'Title1',
                                  child: Text(
                                    'Are you sure to delete?',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  color: Colors.blueAccent,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RaisedButton(
                                        onPressed: () async {
                                          try {
                                            await FirebaseFirestore.instance
                                                .runTransaction((Transaction
                                                    myTransaction) async {
                                              myTransaction.delete(snapshot
                                                  .data.docs[index].reference);
                                            });
                                            Navigator.pop(context);
                                          } catch (error) {
                                            print(
                                                error.toString()); // For Debug
                                          }
                                        },
                                        child: Text(
                                          'Yes',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      RaisedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('No'),
                                      )
                                    ]),
                              ],
                            ),
                          ),
                        ));
                  },
                )
              },
            )
          ],
        )
      ],
    ),
  );
}

Widget loadMessage(context, post, index, snapshot) {
  return Container(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      color: Colors.blue[100],
      height: 60,
      child: Center(
          child: Text(
        post['message'],
        maxLines: 3,
        style: TextStyle(
          color: Colors.black,
        ),
      )));
}

// Function to create an contact info line
Expanded createContactInfoWidgets(String header, String details) {
  return Expanded(
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            header,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            details,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    ),
  );
}

// Search for Posted Swap Request
class CourseSwapPage extends StatefulWidget with NavigationStates {
  @override
  _CourseSwapState createState() => _CourseSwapState();
}

int _selectedIndex = 0;
String indexsearch1 = '';
String indexsearch2 = '';

class _CourseSwapState extends State<CourseSwapPage> {
  final _matricNumController = TextEditingController();
  final _indexOfferController = TextEditingController();
  final _indexRequestController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedIndex == 0) {
      // implement browse page
      return buildBrowsePage();
    } else if (_selectedIndex == 1) {
      // implement MyPost Page
      return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: buildBottomNavigationBar(),
          body: Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Title(
                      color: Colors.blue,
                      child: Text(
                        '   My Posts',
                        style: TextStyle(
                            color: Colors.indigo, fontWeight: FontWeight.bold),
                        textScaleFactor: 2,
                      ),
                    ),
                    Divider(
                      indent: 20,
                      endIndent: 10,
                      thickness: 1.5,
                      color: Colors.blue[900],
                    ),
                    Expanded(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('swapinfodata')
                              .where('email', isEqualTo: Global().appData["userEmail"])
                              .snapshots(),
                          builder: (context, snapshot) {
                            return ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                return (loadMyPosts(
                                    context,
                                    snapshot.data.docs[index],
                                    index,
                                    snapshot));
                              },
                            );
                          }),
                    ),
                  ]),
            ),
          ));
    } else {
      // implement message page
      return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: buildBottomNavigationBar(),
        body: Container(
          padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Title(
                color: Colors.blue,
                child: Text(
                  '   Messages',
                  style: TextStyle(
                      color: Colors.indigo, fontWeight: FontWeight.bold),
                  textScaleFactor: 2,
                ),
              ),
              Divider(
                indent: 20,
                endIndent: 10,
                thickness: 1.5,
                color: Colors.blue[900],
              ),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('messages')
                        .where('receiverEmail', isEqualTo: Global().appData["userEmail"])
                        .snapshots(),
                    builder: (context, snapshot) {
                      return ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                          height: 2,
                          thickness: 1,
                          color: Colors.black,
                        ),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          return (loadMessage(context,
                              snapshot.data.docs[index], index, snapshot));
                        },
                      );
                    }),
              )
            ],
          ),
        ),
      );
    }
  }

  Scaffold buildBrowsePage() {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan[600],
        child: Icon(Icons.add), // Or use Icons.post_add
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 16,
                  child: Container(
                    height: 450.0,
                    width: 360.0,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Title(
                            title: 'Title1',
                            child: Text(
                              'Post Your Request',
                              style: TextStyle(
                                  color: Colors.blue[700],
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            color: Colors.blueAccent,
                          ),
                          createInputWidgets(
                              'Matric No.* :', _matricNumController),
                          createInputWidgets(
                              'Username* :', _usernameController),
                          createInputWidgets(
                              'Index Offer* :', _indexOfferController),
                          createInputWidgets(
                              'Index Request* :', _indexRequestController),
                          createInputWidgets(
                              'password* :', _passwordController),
                          createInputWidgets('email*', _emailController),
                          createInputWidgets(
                              'mobile Number :', _phoneNumController),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel'),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  Map<String, dynamic> postdata = {
                                    'matric': _matricNumController.text,
                                    'username': _usernameController.text,
                                    'indexOffer': _indexOfferController.text,
                                    'indexRequest':
                                        _indexRequestController.text,
                                    'phoneNum': _phoneNumController.text,
                                    'email': _emailController.text,
                                  };
                                  CollectionReference collectionReference =
                                      FirebaseFirestore.instance
                                          .collection('swapinfodata');
                                  try {
                                    await collectionReference
                                        .add(postdata)
                                        .timeout(Duration(seconds: 10));
                                    Navigator.pop(context);
                                    _matricNumController.clear();
                                    _usernameController.clear();
                                    _indexOfferController.clear();
                                    _indexOfferController.clear();
                                    _passwordController.clear();
                                    _indexRequestController.clear();
                                    _phoneNumController.clear();
                                    _emailController.clear();
                                    AlertDialog ad = AlertDialog(
                                      title: Text('Successful'),
                                      content: Text('Your request is posted'),
                                    );
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ad;
                                      },
                                    );
                                  } catch (error) {
                                    AlertDialog ad = AlertDialog(
                                      title: Text('Error: '),
                                      content: Text(error.toString()),
                                    );
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ad;
                                      },
                                    );
                                  }
                                },
                                child: Text('Post'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ));
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      bottomNavigationBar: buildBottomNavigationBar(),
      body: Container(
          child: Padding(
        padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          // SearchFunction(),
          Row(
            children: [
              FlatButton(
                minWidth: 10,
                height: 50,
                onPressed: null,
                child: Icon(Icons.search),
              ),
              Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(hintText: 'Index you want'),
                  onChanged: (text1) {
                    indexsearch1 = text1;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                  child: TextField(
                      style: TextStyle(color: Colors.black),
                      decoration:
                          InputDecoration(hintText: 'Index you provide'),
                      onChanged: (text2) {
                        indexsearch2 = text2;
                        setState(() {});
                      })),
            ],
          ),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('swapinfodata')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                        child: const Text(
                      'Loading...',
                      textScaleFactor: 3,
                    ));
                  if (indexsearch1.length != 0 && indexsearch2.length != 0) {
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('swapinfodata')
                          .where('indexOffer', isEqualTo: indexsearch1)
                          .where('indexRequest', isEqualTo: indexsearch2)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const Text('Loading...');
                        return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            return (loadPosts(
                                context, snapshot.data.docs[index]));
                          },
                        );
                      },
                    );
                  } else if (indexsearch1.length != 0) {
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('swapinfodata')
                          .where('indexOffer', isEqualTo: indexsearch1)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const Text('Loading...');
                        return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            return (loadPosts(
                                context, snapshot.data.docs[index]));
                          },
                        );
                      },
                    );
                  } else if (indexsearch2.length != 0) {
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('swapinfodata')
                          .where('indexRequest', isEqualTo: indexsearch2)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const Text('Loading...');
                        return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            return (loadPosts(
                                context, snapshot.data.docs[index]));
                          },
                        );
                      },
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return (loadPosts(context, snapshot.data.docs[index]));
                    },
                  );
                }),
          )
        ]),
      )),
    );
  }

// Function to create an text input line with a header
  Expanded createInputWidgets(
      String header, TextEditingController textEditingController) {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: Text(header),
          ),
          Expanded(
            flex: 2,
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.lightBlue,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.view_list_rounded,
          ),
          label: 'Browse',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'My Post',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Message',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      onTap: _onItemTapped,
    );
  }
}
