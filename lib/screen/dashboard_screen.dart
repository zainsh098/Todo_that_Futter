import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:intl/intl.dart';
import '../const.dart';
import '../widgets/bullet.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {


  String _greeting = 'Loading...';



  List<String> litems = [];
  TextEditingController task = TextEditingController();

  TimeOfDay currentTime = TimeOfDay.now();
  String getFormattedDate() {
    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat.yMMMd().format(currentDate);
    return formattedDate;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserName();

  }
  void fetchUserName() async {
    // Replace 'users' with the appropriate collection name in your Firestore database
    CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('User_Signup');
    String uid = FirebaseAuth.instance.currentUser!.uid;
    // Replace 'userId' with the user's ID or document name in your Firestore collection
    DocumentSnapshot userSnapshot = await usersCollection.doc(uid).get();

    if (userSnapshot.exists) {
      String userName = userSnapshot.get('name');
      setState(() {
        _greeting = getGreetingBasedOnTime(userName);
      });
    }
  }



  String getGreetingBasedOnTime(String name) {
    var hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning, $name!';
    } else if (hour < 17) {
      return 'Good Afternoon, $name!';
    } else if (hour < 20) {
      return 'Good Evening, $name!';
    } else {
      return 'Good Night, $name!';
    }
  }













  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(

                  color: const Color.fromARGB(255, 179, 115, 87),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children:  [
                      const SizedBox(
                        height: 20,
                      ),
                       Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Center(
                          child: Text(
                            _greeting,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                
                const SizedBox(
                  height: 15,
                ),
                Container(

                  height: 160,

                  child: AnalogClock(
                    dialColor: const Color(0xFFECE6E6),
                    dateTime:  DateTime.now(),
                    isKeepTime: true,
                    child: const Align(
                      alignment: FractionalOffset(0.5, 0.75),
                      child: Text('GMT-8'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Tasks List',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Card(
                    elevation: 5,
                    shadowColor: Constants.backgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                'Daily Tasks',
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                              InkWell(
                                onTap: () {
                                  _show(context);
                                },
                                child: const Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: litems.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    const MyBullet(),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(litems[index])
                                  ],
                                );
                              },),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Positioned(
              child: Image(
                image: AssetImage(Constants.shape_image),
              ),
            )
          ],
        )),
      ),
    );
  }

  void _show(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 5,
        context: ctx,
        builder: (ctx) => Padding(
              padding: EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: task,
                    keyboardType: TextInputType.name,
                    decoration:
                        const InputDecoration(labelText: 'Enter the Task'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            litems.add(task.text);
                            setState(() {});
                          },
                          child: const Text('Add task')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close_rounded,
                            color: Colors.red,
                          )),
                    ],
                  )
                ],
              ),
            ));
  }
}
