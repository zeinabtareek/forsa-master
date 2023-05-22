import 'package:flutter/material.dart';
import 'package:fursa/Controller/SettingsController.dart';
import 'package:fursa/Core/Constnts.dart';
import 'package:fursa/View/SharedComponents/AppBar/app_bar_back.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:fursa/View/SharedComponents/ScreenLoader.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SettingsController>(context, listen: false)
        .getNotifications(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Consumer<SettingsController>(
      builder: (context, settingsController, child) => Scaffold(
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            AppBarBack(title: 'notifications'),
            settingsController.settingStage == SettingsControllerStage.LOADING
                ? ScrreenLoader()
                : SliverToBoxAdapter(
                    child: settingsController.notifications.isEmpty
                        ? Container(
                            width: media.width,
                            height: media.height * 0.9,
                            child: Center(child: Text('لا يوجد اشعارات حاليا')))
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: List.generate(
                                settingsController.notifications.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.only(
                                    left: defaultPading,
                                    right: defaultPading,
                                    bottom: 10,
                                  ),
                                  child: Container(
                                    width: media.width,
                                    height: 90,
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: standaredBoxShadow,
                                      borderRadius:
                                          BorderRadius.circular(defaultPading),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${settingsController.notifications[index].title}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '${settingsController.notifications[index].description}',
                                              style: TextStyle(
                                                  color: Color(0xffEA0101),
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  )
          ],
        ),
      ),
    );
  }
}
