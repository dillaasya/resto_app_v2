import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:resto_app_v2/common/result_state.dart';
import 'package:resto_app_v2/data/provider/list_provider.dart';
import 'package:resto_app_v2/data/provider/theme_provider.dart';
import 'package:resto_app_v2/ui/list_all_page.dart';
import 'package:resto_app_v2/ui/search_page.dart';
import 'package:resto_app_v2/widget/first_card.dart';
import 'package:resto_app_v2/widget/second_card.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context, listen: true);

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Text(
              "Find Your Favorite Restaurant",
              style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SearchPage();
                    },
                  ),
                );
              },
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  border: Border.all(color: Colors.black26),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_rounded,
                        size: 20,
                        color: theme.getTheme() == theme.lightTheme
                            ? Colors.grey.shade400
                            : Colors.grey.shade800,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Looking for something?',
                        style: TextStyle(
                          color: theme.getTheme() == theme.lightTheme
                              ? Colors.grey.shade400
                              : Colors.grey.shade800,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          _subHeader(context, "Popular"),
          _buildPrimaryCarousel(),
          _subHeader(context, "For You"),
          _buildSecondaryCarousel(),
          _subHeader(context, "Newest"),
          _buildSecondaryCarousel(),
        ],
      ),
    );
  }

  Padding _subHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const ListAllPage();
                  },
                ),
              );
            },
            child: Row(
              children: [
                Text(
                  "See All",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xffE23E3E)),
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.red,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildPrimaryCarousel() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: SizedBox(
      height: 230,
      child: Consumer<ListProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.result.restaurants.length,
                    itemBuilder: (context, index) {
                      var restaurant = state.result.restaurants[index];

                      return FirstCard(restaurant: restaurant);
                    },
                  ),
                )
              ],
            );
          } else if (state.state == ResultState.noData) {
            return Center(child: Text(state.message));
          } else if (state.state == ResultState.error) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text(''));
          }
        },
      ),
    ),
  );
}

Widget _buildSecondaryCarousel() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: SizedBox(
      height: 160,
      child: Consumer<ListProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.result.restaurants.length,
                    itemBuilder: (context, index) {
                      var restaurant = state.result.restaurants[index];
                      return SecondCard(restaurant: restaurant);
                    },
                  ),
                )
              ],
            );
          } else if (state.state == ResultState.noData) {
            return Center(child: Text(state.message));
          } else if (state.state == ResultState.error) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text(''));
          }
        },
      ),
    ),
  );
}
