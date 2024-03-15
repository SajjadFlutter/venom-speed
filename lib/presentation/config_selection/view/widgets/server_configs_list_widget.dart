import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:venom_speed/infrastructure/models/server_model/server_model.dart';

import '../../bloc/server_cubit/server_cubit.dart';
import 'server_config_item.dart';

class ServerConfigsListWidget extends StatelessWidget {
  const ServerConfigsListWidget({
    super.key,
    required this.secondaryHeaderColor,
    required this.primaryColor,
    required this.textTheme,
  });

  final Color secondaryHeaderColor;
  final Color primaryColor;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      // call api
      BlocProvider.of<ServerCubit>(context).callServerDataEvent();

      return BlocBuilder<ServerCubit, ServerState>(
        builder: (context, state) {
          // Loading
          if (state.serverDataStatus is ServerDataLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: primaryColor,
                    strokeWidth: 3.0,
                  ),
                  const SizedBox(height: 25.0),
                  Text(
                    'در حال دریافت اطلاعات...',
                    style: textTheme.labelMedium,
                  ),
                  const SizedBox(height: 60.0),
                ],
              ),
            );
          }
          // Completed
          if (state.serverDataStatus is ServerDataCompleted) {
            ServerDataCompleted serverDataCompleted =
                state.serverDataStatus as ServerDataCompleted;
            ServerModel serverModel = serverDataCompleted.serverModel;

            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                // config item
                return ServerConfigItem(
                  index: index,
                  secondaryHeaderColor: secondaryHeaderColor,
                  primaryColor: primaryColor,
                  textTheme: textTheme,
                  serverModel: serverModel,
                );
              },
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 12.0),
              itemCount: serverModel.result.length,
            );
          }
          // Error
          if (state.serverDataStatus is ServerDataError) {
            final ServerDataError serverDataError =
                state.serverDataStatus as ServerDataError;

            return Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wifi_off_rounded,
                    color: primaryColor,
                    size: 70.0,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    serverDataError.errorMessage,
                    style: textTheme.labelMedium,
                  ),
                  const SizedBox(height: 15.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        backgroundColor: primaryColor,
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        )),
                    child: const Text(
                      'تلاش مجدد',
                      style: TextStyle(
                        fontFamily: 'iransans',
                        fontSize: 12.0,
                      ),
                    ),
                    onPressed: () {
                      // call api
                      BlocProvider.of<ServerCubit>(context)
                          .callServerDataEvent();
                    },
                  ),
                ],
              ),
            );
          }

          return Container();
        },
      );
    });
  }
}
