import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resto_app_v2/data/model/resto_list.dart';
import 'package:resto_app_v2/ui/detail_page.dart';

class FirstCard extends StatelessWidget {
  final RestaurantListItem restaurant;

  const FirstCard({super.key, required this.restaurant});

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
            Stack(
              children: [
                SizedBox(
                  width: 255,
                  height: 160,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Positioned(
                //   top: 8,
                //   right: 8,
                //   child: GestureDetector(
                //     onTap: () {},
                //     child: const CircleAvatar(
                //         backgroundColor: Colors.white,
                //         radius: 17,
                //         child: ImageIcon(
                //           AssetImage(
                //             "assets/bookmark-inactive.png",
                //           ),
                //           size: 20,
                //           color: Colors.black,
                //         )),
                //   ),
                // ),
                Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0x4d303030),
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                size: 16,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                restaurant.rating.toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              maxLines: 1,
              restaurant.name,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.fade,
            ),
            Row(
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
          ],
        ),
      ),
    );
  }
}
