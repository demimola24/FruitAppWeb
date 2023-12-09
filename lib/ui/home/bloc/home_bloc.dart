import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fruitshopweb/data/model/request/auth_request.dart';
import 'package:fruitshopweb/data/model/response/fruit_model.dart';
import 'package:rxdart/rxdart.dart';
import '../../../data/repository/repository.dart';

class HomeBloc  {
  final _repo = Repository();

  final _showProgressSubject = BehaviorSubject<bool>();
  Stream<bool> get progressStatusStream => _showProgressSubject.stream;
  Function(bool) get showProgressBar => _showProgressSubject.sink.add;

  final _productsSubject = BehaviorSubject<FruitList>();
  Stream<FruitList> get productsStream => _productsSubject.stream;

  final _cartItemsSubject = BehaviorSubject<List<FruitModel>>();
  Stream<List<FruitModel>> get cartItemsStream => _cartItemsSubject.stream;


  addToCart(FruitModel product){
    final value  = _cartItemsSubject.value;
    value.add(product);
    _cartItemsSubject.sink.add(value);
  }

  getProducts(){
    print("called");
    _showProgressSubject.sink.add(true);
     _repo.getFruits().then((response) async {
       print("Success");
      _showProgressSubject.sink.add(false);
      _productsSubject.sink.add(response);
    }, onError: (e) {
       print(e);
      _productsSubject.sink.addError(e);
      _showProgressSubject.sink.add(false);
    });
  }



  void dispose() async {
    _showProgressSubject.drain();
    await _showProgressSubject.close();
    _productsSubject.drain();
    await _productsSubject.close();
  }
}
