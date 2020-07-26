import 'package:bloc_poc_lib/bloc/coffee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/coffee.dart';

class DetailsPage extends StatefulWidget {
  final String coffeeName;

  const DetailsPage({
    Key key,
    @required this.coffeeName,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _CoffeeDetailPageState();
  }
}

class _CoffeeDetailPageState extends State<DetailsPage> {
  @override
  void didChangeDependencies() {
    //runs once before build
    super.didChangeDependencies();
    // Immediately trigger the event
    BlocProvider.of<CoffeeBloc>(context)
      ..add(GetCoffeeDetails(widget.coffeeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coffee Detail"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        
        child: BlocBuilder<CoffeeBloc, CoffeeState>(
          builder: (context, state) {
            if (state is CoffeeDetails) {
              return buildColumnWithData(context, state.coffee);
            } else if (state is CoffeeLoading) {
              return buildLoading();
            }
            else return Text("oopsie!");
          },
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: Text("LOADING"),
    );
  }

  Column buildColumnWithData(BuildContext context, Coffee coffee) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          coffee.name,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          '${coffee.name} is ${coffee.espressoBased ? '' : 'not'} an espresso based Drink',
        ),
        Text(
          "Price: ${coffee.price} kr",
        ),
      ],
    );
  }
}
