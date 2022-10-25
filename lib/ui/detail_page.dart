import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:resto_app_v2/common/result_state.dart';
import 'package:resto_app_v2/data/api/api_service.dart';
import 'package:resto_app_v2/data/model/resto_detail.dart';
import 'package:resto_app_v2/data/provider/detail_provider.dart';
import 'package:resto_app_v2/ui/add_review_page.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
    required this.id,
  });

  static const routeName = '/detail_page';
  final String id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late CustomerReview review;

  @override
  Widget build(BuildContext context) {
    String id = widget.id;
    TextEditingController name = TextEditingController();
    TextEditingController message = TextEditingController();

    void showBottomSheet() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (builder) {
            return AddNewReview(
                name: name, message: message, id: id, mounted: mounted);
          });
    }

    return ChangeNotifierProvider<DetailProvider>(
      create: (_) => DetailProvider(apiService: ApiService(), id: widget.id),
      child: Consumer<DetailProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            final detail = state.result.restaurant;

            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Stack(children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Hero(
                                tag: "image-resto",
                                child: Image.network(
                                  'https://restaurant-api.dicoding.dev/images/medium/${detail.pictureId}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 28,
                            child: GestureDetector(
                              onTap: () {
                                showBottomSheet();
                                setState(() {});
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20,
                                child: Icon(
                                  Icons.rate_review_rounded,
                                  color: Color(
                                    (0xffE23E3E),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  detail.name,
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_rounded,
                                      color: Color(0xffE23E3E),
                                      size: 15,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      detail.city,
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w200),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.star_rate_rounded,
                                      color: Colors.amber,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(detail.rating.toString(),
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),
                        child: ReadMoreText(
                          detail.description,
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.normal),
                          trimLines: 5,
                          colorClickableText: const Color(0xffE23E3E),
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
                          moreStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ExpansionTile(
                        title: Text('Food Menu',
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        children: detail.menus.foods
                            .map<Widget>(buildMenuItem)
                            .toList(),
                      ),
                      ExpansionTile(
                        title: Text(
                          'Drink Menu',
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        children: detail.menus.drinks
                            .map<Widget>(buildMenuItem)
                            .toList(),
                      ),
                      ExpansionTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Reviews',
                              style: GoogleFonts.poppins(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "(${detail.customerReviews.length})",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w200),
                            )
                          ],
                        ),
                        children: detail.customerReviews
                            .map<Widget>(buildReviews)
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state.state == ResultState.noData) {
            return Center(child: Text(state.message));
          } else if (state.state == ResultState.error) {
            return Scaffold(body: Center(child: Text(state.message)));
          } else {
            return const Center(child: Text(''));
          }
        },
      ),
    );
  }

  Widget buildMenuItem(
    Category e,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12, left: 16),
              child: Image.asset(
                "assets/Icon - Sushi.png",
                width: 50,
                height: 50,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(e.name,
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget buildReviews(CustomerReview e) {
    return ListTile(
      leading: const Icon(Icons.person_rounded),
      title: Text(e.name),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(e.review),
          const SizedBox(
            height: 10,
          ),
          Text(e.date)
        ],
      ),
    );
  }
}
