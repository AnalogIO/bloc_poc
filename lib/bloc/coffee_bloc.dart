import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_poc_lib/data/coffee_repository.dart';
import 'package:bloc_poc_lib/data/model/coffee.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';

import '../main.dart';

part 'coffee_event.dart';
part 'coffee_state.dart';

class CoffeeBloc extends Bloc<CoffeeEvent, CoffeeState> {
  final CoffeeRepository coffeeRepository;
   
  CoffeeBloc(this.coffeeRepository) : super(CoffeeInitial());

  
  @override
  Stream<CoffeeState> mapEventToState(
    CoffeeEvent event,
  ) async* {
    yield CoffeeLoading();
    if(event is GetIsCoffee) yield CoffeeCheck( await coffeeRepository.fetchIsCoffee(event.coffeeName),event.coffeeName);
    else if(event is GetCoffeeDetails) {       
        try {
          final coffee = await coffeeRepository.fetchCoffeeDetails(event.props[0]);
          yield CoffeeDetails(coffee);
        } on CoffeeNotFoundError {
          yield CoffeeError('${event.props[0]} is not a type of coffee');
        } 
    }       
  }

  
}
