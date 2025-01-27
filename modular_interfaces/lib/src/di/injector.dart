import 'bind.dart';
import 'bind_context.dart';

abstract class Injector<T> {
  B call<B extends Object>([BindContract<B>? bind]) => get<B>(bind);

  B get<B extends Object>([BindContract<B>? bind]);

  bool isModuleAlive<T extends BindContext>();

  void bindContext(BindContext module, {String tag = ''});

  void disposeModuleByTag(String tag);

  void removeScopedBinds();

  bool dispose<B extends Object>();

  void destroy();

  void removeBindContext<T extends BindContext>();

  Future<bool> isModuleReady<M extends BindContext>();
}
