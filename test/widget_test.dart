// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter_test/flutter_test.dart';
import 'package:fruitshopweb/data/model/request/auth_request.dart';
import 'package:fruitshopweb/data/model/response/auth_reponse.dart';
import 'package:fruitshopweb/data/model/response/fruit_model.dart';
import 'package:fruitshopweb/data/repository/repository.dart';

import 'mock.dart';

void main(){
  test("login() should return an successful auth response", () {
    DataSource dataSource = MockRemoteDateSourceSuccess();
    final result = dataSource.login(AuthRequest());
    expect(result, isInstanceOf<AuthResponse>());
  });

  test("signup() should return an successful auth response", () {
    DataSource dataSource = MockRemoteDateSourceSuccess();
    final result = dataSource.register(AuthRequest());
    expect(result, isInstanceOf<AuthResponse>());
  });

  test("getFruits() should return an successful auth response", () {
    DataSource dataSource = MockRemoteDateSourceSuccess();
    final result = dataSource.getFruits();
    expect(result, isInstanceOf<FruitList>());
  });
}

