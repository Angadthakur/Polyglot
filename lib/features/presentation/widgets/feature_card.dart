import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap; // A function to call when the card is tapped

  const FeatureCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: 270,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 8,
      
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
      
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 90,
                  color: Color.fromARGB(255, 186, 52, 210),
                ),
      
                const SizedBox(width: 10),

                const VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                ),

                

                
                const SizedBox(width: 10),
      
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //TITLE
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                  
                      const SizedBox(height: 8),
                  
                      //SUBTITLE
                  
                          
                       Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54
                    ),
                        
                  )
                    ],
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}