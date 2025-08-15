import 'package:auto_route/auto_route.dart';

@RoutePage(name: 'BottomTabHomeRouter')
class BottomTabHomePage extends AutoRouter {
  const BottomTabHomePage({super.key});
}

@RoutePage(name: 'BottomTabAddTransferRouter')
class BottomTabAddTransferPage extends AutoRouter {
  const BottomTabAddTransferPage({super.key});
}

@RoutePage(name: 'BottomTabProfileRouter')
class BottomTabProfilePage extends AutoRouter {
  const BottomTabProfilePage({super.key});
}

class EmptyRouterScreen extends AutoRouter {
  const EmptyRouterScreen({super.key});
}
