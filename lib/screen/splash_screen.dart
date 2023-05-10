
import 'package:flutter/material.dart';


import '../const.dart';
import '../utils/route_name.dart';
import '../widgets/button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);




  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  bool _showButton=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 3),(){





      setState(() {

        _showButton=true;

      });


    }





    );

  }








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E6E6),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 120),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  <Widget>[

                      const Image(image: AssetImage(Constants.splashlogo),),
                      const SizedBox(height: 60,),
                      const Text('Get things done with ToDo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),

                      const SizedBox(height: 60,),
                      const  Text('  Simplify your life and boost your  productivity  \n by organizing your tasks in one place.',
                        textAlign: TextAlign.center, style: TextStyle( fontSize: 15,fontWeight: FontWeight.w400),),

                      const SizedBox(height: 80,),
                      _showButton ? ButtonWidget(textmessage: 'Get Started',onTap: (){
                        Navigator.pushNamed(context, RouteName.registration_screen);
                      }):Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: LinearProgressIndicator(

                          color: Colors.deepOrangeAccent.shade100,

                        ),
                      )


                    ],
                  ),
                ),
              ),
              const Positioned(child: Image(image: AssetImage(Constants.shape_image),),)
            ],
          ),
        ),
      ),
    );
  }
}
