import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/controllers/trips_controller.dart';
import 'package:yemen_travel_guid/controllers/user_controller.dart';

import 'package:yemen_travel_guid/constant.dart';
class AlertDialogRating extends StatefulWidget {
  final int tripId;
  const AlertDialogRating({super.key,required this.tripId});

  @override
  State<AlertDialogRating> createState() => _AlertDialogRatingState();
}

class _AlertDialogRatingState extends State<AlertDialogRating> {
  int rating = 0;
  bool loading = false;




  Future<void> _tripRating() async {
    setState(() {
      loading = true;
    });
    var response = await createRating(rating.toString(), widget.tripId.toString() , null);
    if (response.error == null) {
      showSuccessSnackBar(context: context, message: response.message.toString(), );    }
    else if(response.error == 'unauthorized'){
      unauthorizedLogout(context);
    }
    else {
      showErrorSnackBar(context: context, message: response.error.toString(), );
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('تقييم الرحلة'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () {
                  setState(() {
                    rating = index + 1;
                  });
                },
              );
            }),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: ()  {
             _tripRating();
            Navigator.of(context).pop();
          },
          child: Text('تقييم'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('إلغاء'),
        ),
      ],
    );
  }
}
