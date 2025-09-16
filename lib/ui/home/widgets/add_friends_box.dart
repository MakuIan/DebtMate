import 'package:flutter/material.dart';

class AddFriendsBox extends StatelessWidget {
  const AddFriendsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 126, 244), // Background color
              borderRadius: BorderRadius.circular(15), // Rounded rectangle
              border: Border.all(
                color: const Color.fromARGB(255, 0, 126, 244), // Border color
                width: 2,
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.add, size: 40, color: Colors.white),
              onPressed: () {
                // TODO: Handle add friend action
              },
            ),
          ),

          const SizedBox(width: 8),
          const Text(
            'Add Friends',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 126, 244),
            ),
          ),
        ],
      ),
    );
  }
}
