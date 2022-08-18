import 'package:cell_avenue_store/models/onboarding_content.dart';
import 'package:cell_avenue_store/ui/onbording/widgets/onboarding_body.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  List<OnBoardingContent> bordingScreens = [
    OnBoardingContent(
        imageURL:
            'https://cellavenuestore.com/wp-content/uploads/2022/08/Reach-Web-EN-1920-620-1.jpg',
        text:
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
        subText: 'Why do we use it'),
    OnBoardingContent(
        imageURL:
            'https://scontent.famm9-1.fna.fbcdn.net/v/t1.6435-9/182678294_2880068682254594_2903872626130284799_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=e3f864&_nc_ohc=GcqJ3WfLJX4AX8ffFjj&_nc_ht=scontent.famm9-1.fna&oh=00_AT-UXaANLIITEEypkQgSZzZshigHuAI_gaNuufp9bC7NgQ&oe=6323861A',
        text:
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
        subText: 'What is Lorem Ipsum'),
    OnBoardingContent(
        imageURL:
            'https://scontent.famm9-1.fna.fbcdn.net/v/t1.6435-9/136050621_2792644674330329_3434019451877855827_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=e3f864&_nc_ohc=-pHG0GX17QMAX8Qx-H1&_nc_ht=scontent.famm9-1.fna&oh=00_AT8lrMpInltGhpukROePlNYd2im46mXsIVQWXSwJnUNFRA&oe=6321DC6A',
        text:
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
        subText: 'Where does it come from'),
    OnBoardingContent(
        imageURL:
            'https://scontent.famm9-1.fna.fbcdn.net/v/t1.6435-9/79663154_2430885770506223_1621477469955555328_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=e3f864&_nc_ohc=yIaE27uzv44AX_Shfip&_nc_ht=scontent.famm9-1.fna&oh=00_AT-OPDkWbuhwk7ohvhXnAXRERcvwlzw3060m5LKMfHFQmQ&oe=6322003F',
        text:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
        subText: 'Where can I get some'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: OnBoardingBody(content: bordingScreens)),
    );
  }
}
