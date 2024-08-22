import 'package:flutter/material.dart';

class RAlert {
  
  showError({
    required BuildContext context,
    required String title,
    required String desc,
  }) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(desc),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          )
        ],
      ),
    );
  }
}
