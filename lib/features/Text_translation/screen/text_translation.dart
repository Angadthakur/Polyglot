import 'package:flutter/material.dart';
import 'package:translator_app_polyglot/features/Text_translation/widgets/input_text_field.dart';
import 'package:translator_app_polyglot/features/Text_translation/widgets/translated_text_field.dart';
import 'package:translator_app_polyglot/features/presentation/screens/homescreen.dart';

class TextTranslation extends StatelessWidget {
  const TextTranslation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,

      
      appBar: AppBar(
         backgroundColor: const Color.fromARGB(255, 186, 52, 210), // Match your theme
        elevation: 0,
        leading:IconButton(
          onPressed: (){
          //Takes back to the Home Screen
          Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Homescreen()));

        print("Back to Home Screen");
          
        }, 
        icon:const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.black,
          size: 30,
          
        )
        ),
        titleSpacing:40,

        title: const Text(
          "Text Translation",
          style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontStyle: FontStyle.italic
                ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.centerStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [
              const Color.fromARGB(255, 218, 167, 227),
              const Color.fromARGB(255, 186, 52, 210),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children:[
              const Expanded(
                child:InputTextField() 
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton.icon(onPressed: (){
                    //TODO : Add translation logic 
                    print("Translate button tapped!");
                  }, 
                  icon: const Icon(Icons.translate),
                  label: const Text("Translate"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color.fromARGB(255, 186, 52, 210),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ), 
                ),

                const Expanded(
                  child: TranslatedTextField(
                    translatedText:"This is where the translated text will appear after you press")
                  )
              
            ],
          )),
      ),
    );
  }
}