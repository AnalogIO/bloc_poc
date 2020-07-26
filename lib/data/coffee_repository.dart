// This is a fake repository to simulate an actual api
// the delayed futures are simply to simulate this.

import 'dart:collection';

import 'model/coffee.dart';

abstract class CoffeeRepository {
  Future<bool> fetchIsCoffee(String name);
  Future<Coffee> fetchCoffeeDetails(String name);
}

class fakeCoffeeRepository implements CoffeeRepository {
  
  static var coffeeList = [
        new Coffee("Latte", true, 25),
        new Coffee("Americano", true, 20),
        new Coffee("Filter", false, 10),
        new Coffee("Ice Coffee", false, 15),
        new Coffee("Ice Latte", true, 25),
      ];
  static HashMap<String,Coffee> coffeeMap = new HashMap.fromIterable(coffeeList, key: (e) => e.name, value: (e) => e);
      
  @override
  Future<bool> fetchIsCoffee(String name) {
    return Future.delayed( Duration(seconds: 1), 
      () => isCoffee(name) 
    );
  }
  
  @override
  Future<Coffee> fetchCoffeeDetails(String name) {
    return Future.delayed(Duration(seconds: 1), 
      () {
        if( !isCoffee(name) ){
          throw CoffeeNotFoundError();
        } 
        return coffeeMap[name];
      },
    );
  }
  

  // Helpers irrellevant for the poc

  bool isCoffee(String name) {
    return coffeeMap.containsKey(name);
  }
  
}

class CoffeeNotFoundError extends Error {}