import 'package:flutter_modular/flutter_modular.dart';
import 'modules/app_controller.dart';
import 'modules/modules/home/home_module.dart';
import 'modules/shared/hasura/custom_hasura_connect/custom_hasura_connect.dart';

// ignore: must_be_immutable
class AppModule extends Module {
  @override
  List<Bind> get binds => [
      Bind((i) => AppController()),
      Bind((i) => CustomHasuraConnect('https://true-rattler-64.hasura.app/v1/graphql').getConnect()),
      ];

  @override
  List<ModularRoute> routes = [
        ModuleRoute(Modular.initialRoute, module: HomeModule()),
      ];

}
