import 'package:debtmate/ui/widgets/blue_button_style.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../services/friendship_service.dart';

class AddFriendsDialog extends StatefulWidget {
  const AddFriendsDialog({Key? key}) : super(key: key);

  @override
  _AddFriendsDialogState createState() => _AddFriendsDialogState();
}

class _AddFriendsDialogState extends State<AddFriendsDialog> {
  final TextEditingController _friendCodeTextFieldController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _showAddFriendsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(
              color: Color.fromARGB(255, 0, 126, 244),
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close button at top right
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const Text(
                  'Add Friends',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                // Column centered content
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10), // space below close button
                    const Text(
                      'Enter a Friend codes to add your friend',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _friendCodeTextFieldController,
                      decoration: InputDecoration(
                        hintText: 'Friend Code',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 203, 202, 202),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 0, 126, 244),
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          FriendshipService().addFriendViaFriendCode(
                            _friendCodeTextFieldController.text.trim(),
                            _auth.currentUser!.uid,
                          );
                          Navigator.of(context).pop();
                        },
                        style: AppBlueButtonStyles.elevated,
                        child: const Text('Add'),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'or Add manually',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add, size: 40, color: Colors.white),
      onPressed: () {
        _showAddFriendsDialog();
      },
    );
  }
}
