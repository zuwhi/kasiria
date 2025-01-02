import 'package:flutter/material.dart';

Future<void> customDialogConfirm({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onConfirm,
}) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0), 
        ),
        title: Row(
          children: [
            const Icon(Icons.warning, color: Colors.orange, size: 28), 
            const SizedBox(width: 10),
            Text(
              title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold), 
            ),
          ],
        ),
        content: Text(
          content,
          style: const TextStyle(fontSize: 16), 
        ),
        actions: [
       
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey[700], 
            ),
            child: const Text('Batal'),
          ),
        
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); 
              onConfirm();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), 
              ),
            ),
            child: const Text(
              'Hapus',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    },
  );
}
