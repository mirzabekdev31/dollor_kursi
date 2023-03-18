import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/main_bloc.dart';
import 'calculate/calculate_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MainBloc>();
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: Text("Currency".tr()),
            backgroundColor: Colors.blueGrey,
            centerTitle: false,
            actions: [
              GestureDetector(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(
                      const Duration(days: 30),
                    ),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    bloc.add(MainGetDateEvent(date));
                  }
                },
                child: const Icon(Icons.calendar_month),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext bc) {
                          return Container(
                            child: Wrap(
                              children: <Widget>[
                                ListTile(
                                    title: Text('English'),
                                    onTap: () => {
                                          context.setLocale(
                                              const Locale("en", "EN")),
                                          Navigator.pop(context)
                                        }),
                                ListTile(
                                    title: Text('Rus'),
                                    onTap: () => {
                                          context.setLocale(
                                              const Locale("ru", "RU")),
                                          Navigator.pop(context)
                                        }),
                                ListTile(
                                    title: Text('Uz'),
                                    onTap: () => {
                                          context.setLocale(
                                              const Locale("uz", "UZ")),
                                          Navigator.pop(context)
                                        }),
                              ],
                            ),
                          );
                        });
                  },
                  child: const Image(
                    height: 30,
                      width: 30,
                      image: AssetImage("assets/images/internet.png"))),
              const SizedBox(width: 16),
            ],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(10.0)),
            ),
          ),
          body: Builder(
            builder: (context) {
              if (state.status == Status.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.separated(
                itemCount: state.currencies.length,
                separatorBuilder: (_, i) => const SizedBox(height: 1),
                itemBuilder: (_, i) {
                  final model = state.currencies[i].tr(context.locale);
                  return Card(
                      margin: const EdgeInsets.all(8),
                      elevation: 10,
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ExpansionTile(
                        title: Container(
                            height: 70,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(model.ccyNm,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold)),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      model.diff,
                                      style: const TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "1 ${model.ccy}=>${model.rate} UZS |",
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                    SizedBox(width: 4,),
                                    const Image(
                                        height: 20,
                                        width:20,
                                        image: AssetImage(
                                            "assets/images/calendar2.png")),
                                    SizedBox(width: 4,),
                                    Text("${model.date}",
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black),)
                                  ],
                                )
                              ],
                            )),
                        children: [contaninerCalculateBtn(model.ccyNm,model.rate)],
                      )
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget contaninerCalculateBtn(String countryName,String money) {
    return Container(
      margin: EdgeInsets.all(16),
      height: 80,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, CalculatePage.route,arguments: {"country":countryName,"money":money});
            },
            child: Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueGrey,
              ),
              child: const Center(
                child: Text(
                  "Calculate",
                  style: TextStyle(color: Colors.white,fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  title: Text('English'),
                  onTap: () => context.setLocale(const Locale("en", "EN")),
                ),
                ListTile(
                  title: Text('Rus'),
                  onTap: () => context.setLocale(const Locale("ru", "RU")),
                ),
                ListTile(
                    title: Text('Uz'),
                    onTap: () => {
                          context.setLocale(const Locale("uz", "UZ")),
                        }),
              ],
            ),
          );
        });
  }
}
