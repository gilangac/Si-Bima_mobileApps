import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:si_bima/constant/colors.dart';
import 'package:si_bima/controllers/home/home_controller.dart';
import 'package:si_bima/models/type.dart';
import 'package:si_bima/models/person.dart';
import 'package:si_bima/widgets/general/card_data.dart';
import 'package:si_bima/widgets/general/dialog.dart';
import 'package:si_bima/widgets/general/projects_detail_lazyload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light));

    final statusBarHeight = MediaQuery.of(context).padding.top;
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.accentBoxColor,
        body: DoubleBackToCloseApp(
          snackBar: SnackBar(
            elevation: 0,
            backgroundColor: AppColors.primaryColor,
            content: Text(
              "Tekan kembali lagi untuk keluar",
              style: GoogleFonts.poppins(),
            ),
            duration: Duration(milliseconds: 1500),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                Container(
                  height: statusBarHeight,
                  color: AppColors.primaryColor,
                ),
                Expanded(child: _body()),
              ],
            ),
          ),
        ),
        floatingActionButton: Visibility(
          visible: !keyboardIsOpen,
          child: FloatingActionButton(
            onPressed: () {
              Get.dialog(dialogInfo());
            },
            child: Icon(
              Feather.info,
              color: Colors.white,
              size: 25,
            ),
            backgroundColor: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification? overscroll) {
        overscroll!.disallowGlow();
        return true;
      },
      child: Obx(() => CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                delegate: _DelegateClass(),
                pinned: true,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Obx(() => homeController.searchText.value != ''
                        ? !homeController.isLoading
                            ? homeController.searchResult.length > 0
                                ? DataCard(
                                    data: Person.fromJson(
                                        homeController.searchResult[index]))
                                : Scrollbar(
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * 0.08,
                                            vertical: 5),
                                        child: Image.asset(
                                          "assets/images/empty_result_illustration.png.png",
                                          height: 190,
                                        ),
                                      ),
                                    ),
                                  )
                            : PersonLazyLoadWidget()
                        : Scrollbar(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.08, vertical: 5),
                                child: Image.asset(
                                  "assets/images/search_illustration.png",
                                  height: 190,
                                ),
                              ),
                            ),
                          ));
                  },
                  childCount: homeController.searchText.value != ''
                      ? !homeController.isLoading
                          ? homeController.searchResult.length > 0
                              ? homeController.searchResult.length
                              : 1
                          : 10
                      : 1, // 1000 list items
                ),
              ),
            ],
          )),
    );
  }
}

class _DelegateClass extends SliverPersistentHeaderDelegate {
  HomeController homeController = Get.find();
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.accentBoxColor,
      child: Column(
        children: [_searchBar(), _content()],
      ),
    );
  }

  Widget _header() {
    return Obx(() => AnimatedContainer(
          height: homeController.searchText.value == '' ? 76 : 0,
          duration: Duration(milliseconds: 300),
          child: homeController.searchText.value == ''
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: Get.width,
                      color: AppColors.primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _headerBar(),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox(
                  height: 0,
                ),
        ));
  }

  Widget _headerBar() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bapas Kelas II",
              style: GoogleFonts.poppins(
                  color: AppColors.yellow,
                  fontSize: 28,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "Madiun",
              style: GoogleFonts.poppins(
                  color: AppColors.yellow,
                  fontSize: 28,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Spacer(),
        Image.asset(
          "assets/images/vector_bapas.png",
          alignment: Alignment.center,
          height: 45,
        )
      ],
    );
  }

  Widget _searchBar() {
    return Obx(() => AnimatedContainer(
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(
                    homeController.searchText.value == '' ? 25 : 0)),
            color: AppColors.primaryColor,
          ),
          duration: Duration(milliseconds: 300),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(),
                SizedBox(
                  height: homeController.searchText.value == '' ? 15 : 0,
                ),
                Text(
                  "Layanan info status Klien Pemasyarakatan",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: homeController.searchFC,
                  onChanged: (value) {
                    homeController.searchText.value = value;
                  },
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(Feather.search, color: Colors.grey.shade400),
                    hintText: 'Cari nama',
                    suffixIcon: homeController.searchFC.text.length > 0 ||
                            homeController.searchText.value != ''
                        ? GestureDetector(
                            onTap: () {
                              homeController.searchFC.clear();
                              homeController.searchText.value = '';
                            },
                            child: Icon(Feather.x, color: Colors.black54),
                          )
                        : null,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }

  Widget _content() {
    return Obx(() => homeController.searchText.value != ''
        ? Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hasil Pencarian",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _autoComplete()
                ],
              ),
            ),
          )
        : SizedBox(height: 0));
  }

  Widget _autoComplete() {
    return GetBuilder<HomeController>(
      builder: (state) {
        state.onUpdateType();
        return Obx(() => TypeAheadFormField<Type>(
              textFieldConfiguration: TextFieldConfiguration(
                  controller: state.jailFC,
                  onChanged: (value) => {
                        homeController.typeText.value = value,
                        if (value == '') {homeController.onGetPerson()}
                      },
                  decoration: InputDecoration(
                      hintText: "Cari Berdasarkan Jenis",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(12)),
                      suffixIcon: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween, // added line
                        mainAxisSize: MainAxisSize.min, // added line
                        children: [
                          homeController.typeText.value != ''
                              ? GestureDetector(
                                  onTap: () {
                                    homeController.jailFC.clear();
                                    homeController.typeText.value = '';
                                    homeController.onGetPerson();
                                  },
                                  child: Icon(
                                    Feather.x,
                                    color: Colors.grey.shade400,
                                  ),
                                )
                              : SizedBox(
                                  width: 0,
                                ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Feather.chevron_down,
                              color: Colors.grey.shade400),
                          SizedBox(
                            width: 5,
                          )
                        ],
                      ))),
              suggestionsCallback: (pattern) {
                return state.typeData.where(
                  (Type option) => option.name
                      .toString()
                      .toLowerCase()
                      .contains(pattern.toLowerCase()),
                );
              },
              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion.name),
                );
              },
              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
              onSuggestionSelected: (suggestion) {
                state.jailFC.text = suggestion.name;
                state.typeText.value = suggestion.id.toString();
                print(state.typeText.value);
                state.onGetPerson();
                // state.onParseJailName();
              },
            ));
      },
    );
  }

  @override
  double get maxExtent => 260;

  @override
  double get minExtent => 260;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
