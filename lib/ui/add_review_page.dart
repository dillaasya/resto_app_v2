import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resto_app_v2/data/api/api_service.dart';
import 'package:resto_app_v2/ui/detail_page.dart';

class AddNewReview extends StatefulWidget {
  const AddNewReview({
    Key? key,
    required this.name,
    required this.message,
    required this.id,
    required this.mounted,
  }) : super(key: key);

  final TextEditingController name;
  final TextEditingController message;
  final String id;
  final bool mounted;

  @override
  State<AddNewReview> createState() => _AddNewReviewState();
}

class _AddNewReviewState extends State<AddNewReview> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Add New Review',
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: widget.name,
            autofocus: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                label: Text(
                  'Name',
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.normal),
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: widget.message,
            maxLines: 4,
            minLines: 2,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                label: Text(
                  'Review',
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.normal),
                )),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  )),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xffE23E3E),
                ),
                onPressed: () async {
                  await ApiService().postReview(
                      widget.id, widget.name.text, widget.message.text);

                  widget.name.clear();
                  widget.message.clear();
                  if (!widget.mounted) return;

                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, DetailPage.routeName,
                      arguments: widget.id);
                },
                child: Text('Add',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              )
            ],
          )
        ],
      ),
    ));
  }
}
