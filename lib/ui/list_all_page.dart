import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:resto_app_v2/data/provider/theme_provider.dart';
import 'package:resto_app_v2/ui/detail_page.dart';

import '../data/model/resto_list.dart';

class ListAllPage extends StatelessWidget {
  final List<RestaurantListItem> restaurant;
  const ListAllPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context, listen: true);

    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: restaurant.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DetailPage(
                              id: restaurant[index].id,
                            );
                          },
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        //set border radius more than 50% of height and width to make circle
                      ),
                      margin: const EdgeInsets.all(10),
                      color: theme.getTheme() == theme.lightTheme
                          ? Colors.grey.shade200
                          : Colors.grey.shade800,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              child: Image.network(
                                'https://restaurant-api.dicoding.dev/images/small/${restaurant[index].pictureId}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4, left: 4),
                            child: Text(
                              maxLines: 1,
                              restaurant[index].name,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, bottom: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.location_on_rounded,
                                  color: Colors.red,
                                  size: 15,
                                ),
                                Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  restaurant[index].city,
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
                    ));
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
            )),
      ),
    );
  }
}
