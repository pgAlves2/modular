import 'package:modular_core/modular_core.dart';
import 'package:shelf/shelf.dart' hide Middleware;

import 'module.dart';

class Route extends ModularRouteImpl {
  final Function? handler;
  Route._({
    this.handler,
    required String name,
    String parent = '',
    String schema = '',
    List<ModularRoute> children = const [],
    List<Middleware> middlewares = const [],
    Uri? uri,
    Map<ModularKey, ModularRoute>? routeMap,
    Map<Type, BindContext> bindContextEntries = const {},
  }) : super(
          name: name,
          parent: parent,
          schema: schema,
          children: children,
          middlewares: middlewares,
          routeMap: routeMap,
          uri: uri ?? Uri.parse('/'),
          bindContextEntries: bindContextEntries,
        );

  factory Route.get(
    String name,
    Function handler, {
    List<Middleware> middlewares = const [],
  }) {
    return Route._(
      handler: handler,
      name: name,
      schema: 'GET',
      middlewares: middlewares,
    );
  }

  factory Route.post(
    String name,
    Function handler, {
    List<Middleware> middlewares = const [],
  }) {
    return Route._(
      handler: handler,
      name: name,
      schema: 'POST',
      middlewares: middlewares,
    );
  }

  factory Route.delete(
    String name,
    Function handler, {
    List<Middleware> middlewares = const [],
  }) {
    return Route._(
      handler: handler,
      name: name,
      schema: 'DELETE',
      middlewares: middlewares,
    );
  }
  factory Route.path(
    String name,
    Function handler, {
    List<Middleware> middlewares = const [],
  }) {
    return Route._(
      handler: handler,
      name: name,
      schema: 'PATCH',
      middlewares: middlewares,
    );
  }

  factory Route.put(
    String name,
    Function handler, {
    List<Middleware> middlewares = const [],
  }) {
    return Route._(
      handler: handler,
      name: name,
      schema: 'PUT',
      middlewares: middlewares,
    );
  }

  factory Route.resource(
    String name, {
    required Resource resource,
    List<Middleware> middlewares = const [],
  }) {
    return Route._(
      name: name,
      children: resource.routes,
      middlewares: middlewares,
    );
  }

  factory Route.module(String name, {required Module module, List<Middleware> middlewares = const []}) {
    final route = Route._(name: name, middlewares: middlewares);
    return route.addModule(name, module: module) as Route;
  }

  @override
  Route copyWith({
    Handler? handler,
    String? name,
    String? schema,
    List<Middleware>? middlewares,
    List<ModularRoute>? children,
    String? parent,
    Uri? uri,
    Map<ModularKey, ModularRoute>? routeMap,
    Map<Type, BindContext>? bindContextEntries,
  }) {
    return Route._(
      handler: handler ?? this.handler,
      name: name ?? this.name,
      schema: schema ?? this.schema,
      middlewares: middlewares ?? this.middlewares,
      children: children ?? this.children,
      parent: parent ?? this.parent,
      uri: uri ?? uri,
      routeMap: routeMap ?? routeMap,
      bindContextEntries: bindContextEntries ?? this.bindContextEntries,
    );
  }
}

abstract class Resource {
  List<Route> get routes;
}
