import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yatra/features/test/event.dart';
import 'package:yatra/features/test/test_bloc.dart';
import 'package:yatra/features/test/test_state.dart';
import 'package:yatra/features/widgets/custom_button.dart';

class TestOfBloc extends StatelessWidget {
  TestOfBloc({super.key});
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("test of bloc")),
      body: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) => Column(
          children: [
            Text("${state.count}", style: TextStyle(fontSize: 30)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: CustomButton(
                    backgroundColor: Colors.blue,
                    onPressed: () {
                      context.read<CounterBloc>().add(IncrementEvent());
                    },
                    child: Text("add"),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: CustomButton(
                    backgroundColor: Colors.teal,
                    onPressed: () {
                      context.read<CounterBloc>().add(DecrementEvent());
                    },
                    child: Text("subtract"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
