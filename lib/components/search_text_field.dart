import 'package:cell_avenue_store/ui/home/home_provider.dart';
import 'package:cell_avenue_store/ui/search/search_provider.dart';
import 'package:cell_avenue_store/ui/search/search_screen.dart';
import 'package:cell_avenue_store/utilities/constants.dart';
import 'package:cell_avenue_store/utilities/general.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class SearchTextField extends StatelessWidget {
  SearchTextField({
    this.readonly = false,
    Key? key,
  }) : super(key: key);
  final bool readonly;

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<SearchProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Material(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        elevation: 4.0,
        shadowColor: Colors.black,
        child: TextField(
          onSubmitted: (String value) {
            viewModel.reloadProduct(value, context);
          },
          textInputAction: TextInputAction.search,
          readOnly: readonly,
          onTap: () {
            if (readonly) {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                      create: (context) => SearchProvider(),
                      builder: (_, __) => SearchScreen(),
                    ),
                  ));
              // pushNewScreen(context,
              //     screen: ChangeNotifierProvider(
              //       create: (context) => SearchProvider(),
              //       builder: (_, __) => SearchScreen(),
              //     ),
              //     withNavBar: false);
            }
          },
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            prefixIcon: Container(
                margin: EdgeInsets.all(5),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: Icon(
                  Icons.search,
                )),
            hintText: General.getTranslatedText(context, "Search"),
            hintStyle: TextStyle(color: Colors.grey),
            contentPadding: EdgeInsets.fromLTRB(30, 10, 30, 10),
          ),
        ),
      ),
    );
  }
}
