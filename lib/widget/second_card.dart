import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resto_app_v2/data/model/resto_list.dart';
import 'package:resto_app_v2/ui/detail_page.dart';

class SecondCard extends StatelessWidget {
  final RestaurantListItem restaurant;
  const SecondCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName,
            arguments: restaurant.id);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: 130,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                    fit: BoxFit.cover,
                  ),
                )),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 4.0,
              ),
              child: SizedBox(
                width: 125,
                child: Text(
                  maxLines: 1,
                  restaurant.name,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on_rounded,
                    color: Color(0xffE23E3E),
                    size: 15,
                  ),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    restaurant.city,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
