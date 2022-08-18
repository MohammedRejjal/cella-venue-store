import 'package:cell_avenue_store/models/onboarding_content.dart';
import 'package:cell_avenue_store/ui/onbording/onBording_provider.dart';
import 'package:cell_avenue_store/ui/onbording/widgets/dot.dart';

import 'package:cell_avenue_store/ui/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:cell_avenue_store/ui/bottom_nav_bar/bottom_nav_bar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnBoardingBody extends StatelessWidget {
  OnBoardingBody({
    Key? key,
    required this.content,
  }) : super(key: key);
  List<OnBoardingContent> content;

  PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<OnBordingProvider>(context);

    return Stack(
      children: [
        PageView.builder(
          onPageChanged: (int value) {
            viewModel.changeIndex(value);
          },
          controller: _pageController,
          itemCount: content.length,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.deepPurple[50],
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        child: Column(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(140.0)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40.0),
                                child: Image.network(
                                  "${content[index].imageURL}",
                                  fit: BoxFit.fill,
                                  height: MediaQuery.of(context).size.height /
                                      (2.5),
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        textDirection: TextDirection.ltr,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Text("${content[index].text}"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("${content[index].subText}"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Dot(x: viewModel.pageIndex == 0),
              Dot(x: viewModel.pageIndex == 1),
              Dot(x: viewModel.pageIndex == 2),
              Dot(
                x: viewModel.pageIndex == 3,
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            viewModel.pageIndex == content.length - 1
                ? Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            fixedSize: Size(200, 50)),
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => ChangeNotifierProvider(
                                        builder: (context, _) => BottomBar(),
                                        create: (context) =>
                                            BottomNavBarViewModel(),
                                      )));
                        },
                        child: Text('Lets Go')))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider(
                                          builder: (context, _) => BottomBar(),
                                          create: (context) =>
                                              BottomNavBarViewModel(),
                                        )));
                          },
                          child: Text('Skip')),
                      TextButton(
                          onPressed: () {
                            _pageController.nextPage(
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.easeInOutCubicEmphasized);
                          },
                          child: Text('next'))
                    ],
                  ),
            SizedBox(
              height: 30,
            )
          ],
        )
      ],
    );
  }
}
