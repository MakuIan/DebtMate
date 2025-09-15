import 'package:flutter/material.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.notifications, size: 55, color: Colors.white),
          onPressed: () {
            // TODO Handle notification icon press
          },
        ),

        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 70, // smaller radius
                child: Icon(
                  Icons.price_check,
                  color: Color.fromARGB(255, 0, 126, 244),
                  size: 120,
                ),
              ),
              SizedBox(height: 4), // spacing
              Text(
                'Hello!',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.account_circle, size: 55, color: Colors.white),
          onPressed: () {
            // TODO Handle settings icon press
          },
        ),
      ],
    );
  }
}
