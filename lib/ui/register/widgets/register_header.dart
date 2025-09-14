import 'package:flutter/material.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        children: const [
          // Icon + "DebtMate" together in a box
          Column(
            children: [
              CircleAvatar(
                backgroundColor: Color.fromARGB(255, 0, 126, 244),
                radius: 70,
                child: Icon(Icons.price_check, color: Colors.white, size: 120),
              ),
              Text(
                'DebtMate',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 15),
          Text(
            'Register',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
