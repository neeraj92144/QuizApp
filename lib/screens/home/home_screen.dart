
import 'package:findQuiz/controllers/common/drawer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:findQuiz/configs/configs.dart';
import 'package:findQuiz/controllers/controllers.dart';
import 'package:findQuiz/widgets/widgets.dart';

class HomeScreen extends GetView<MyDrawerController> {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';
  

  @override
  Widget build(BuildContext context) {
    QuizPaperController _quizePprContoller = Get.find();
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(gradient: mainGradient(context)),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(kMobileScreenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Transform.translate(
                      //   offset: const Offset(-10, 0),
                      //   child: CircularButton(
                      //     child: const Icon(AppIcons.menuleft),
                      //     onTap: controller.toggleDrawer,
                      //   ),
                      // ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            const Icon(AppIcons.peace),
                            Builder(
                              builder: (_) {

                                String _label = '  Hello mate';

                                return Text(_label,
                                    style: kDetailsTS.copyWith(
                                        color: kOnSurfaceTextColor));
                              },
                            ),
                          ],
                        ),
                      ),
                      const Text('What Do You Want To Improve Today ?',
                          style: kHeaderTS),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ContentArea(
                      addPadding: false,
                      child: Obx(
                            () => LiquidPullToRefresh(
                          height: 150,
                          springAnimationDurationInMilliseconds: 500,
                          //backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                          color:
                          Theme.of(context).primaryColor.withOpacity(0.5),
                          onRefresh: () async {
                            _quizePprContoller.getAllPapers();
                          },
                          child: ListView.separated(
                            padding: UIParameters.screenPadding,
                            shrinkWrap: true,
                            itemCount: _quizePprContoller.allPapers.length,
                            itemBuilder: (BuildContext context, int index) {
                              return QuizPaperCard(
                                model: _quizePprContoller.allPapers[index],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}
