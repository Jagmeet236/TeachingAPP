import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

/// A [TabNavigator] navigator class for managing tab navigation.
class TabNavigator extends ChangeNotifier {
  /// Constructor that initializes the navigator with an `[initial page]`.
  TabNavigator(this._initialPage) {
    /// Adds the `[initial page]` to the navigation stack.
    _navigationStack.add(_initialPage);
  }

  /// The [_initialPage] initial page for the navigator.
  final TabItem _initialPage;

  /// This [_navigationStack] stack that keeps track of the navigation history.
  final List<TabItem> _navigationStack = [];

  /// [currentPage] Gets the current page from the navigation stack.
  TabItem get currentPage => _navigationStack.last;

  /// [push] Pushes a new [page] onto the navigation stack.
  void push(TabItem page) {
    // Adds a new TabItem with the given page.
    _navigationStack.add(page);

    // Logs the pushed page.
    log('pushed page :$page');
    notifyListeners(); // Notifies listeners about the change.
  }

  /// [pop] Pops the top page from the navigation stack.
  void pop() {
    // Removes the last page if there's more than one.
    if (_navigationStack.length > 1) _navigationStack.removeLast();
    notifyListeners();
  }

  /// [popToRoot] Pops all pages from the navigation stack
  /// and returns to the initial page.
  void popToRoot() {
    _navigationStack
      ..clear()
      ..add(_initialPage);
    notifyListeners();
  }

  /// [popTo] Pops the specific [page] from the navigation stack.
  void popTo(TabItem page) {
    // Removes the specified page from the navigation stack.
    _navigationStack.remove(page);
    notifyListeners();
  }

  /// [popUntil] Pops pages from the navigation stack until the
  /// specified [page] is reached.
  /// If [page] is null, pops all pages to the root.
  void popUntil(TabItem? page) {
    if (page == null) {
      // Pops all pages to the root if the specified page is null.
      return popToRoot();
    }
    if (_navigationStack.length > 1) {
      // Removes pages from the stack until the specified page is reached.
      _navigationStack.removeRange(1, _navigationStack.indexOf(page) + 1);
      notifyListeners();
    }
  }

  /// [pushAndRemoveUntil] Clears the navigation stack and
  /// pushes the specified [page] onto the stack.
  void pushAndRemoveUntil(TabItem page) {
    _navigationStack
      ..clear() // Clears the entire navigation stack.
      ..add(page); // Adds the specified page to the navigation stack.
    notifyListeners();
  }
}

class TabNavigatorProvider extends InheritedNotifier<TabNavigator> {
  const TabNavigatorProvider({
    required this.navigator,
    required super.child,
    super.key,
  }) : super(notifier: navigator);
  final TabNavigator navigator;
  static TabNavigator? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TabNavigatorProvider>()
        ?.navigator;
  }
}

/// A class representing a tab item.
class TabItem extends Equatable {
  /// Constructor that initializes the tab item with a widget and a unique ID.
  /// Generates a unique ID using UUIDv1.
  TabItem({required this.child}) : id = const Uuid().v1();

  /// The widget [child] representing the content of the tab.
  final Widget child;

  /// A unique identifier for the tab item.
  final String id;

  /// Returns the properties that determine whether two instances are equal.
  @override
  List<dynamic> get props => [id];
}
