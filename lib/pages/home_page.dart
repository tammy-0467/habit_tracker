import 'package:flutter/material.dart';
import 'package:habittracker/components/habit_tile.dart';
import 'package:habittracker/components/my_drawer.dart';
import 'package:habittracker/components/my_heat_map.dart';
import 'package:habittracker/database/habit_database.dart';
import 'package:habittracker/models/habit.dart';
import 'package:habittracker/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import '../util/habit_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    //read existing habits on app startup
    Provider.of<HabitDatabase>(context, listen: false).readHabits();
    super.initState();
  }



  //text controller
  final TextEditingController textController = TextEditingController();

  //create new habit
  void createNewHabit(){
    showDialog(
        context: context,
        builder: (context)=> AlertDialog(
          content: TextField(
            controller: textController,
            decoration: InputDecoration(
              hintText: "Create a new habit",
            ),
          ),
          actions: [
            //save button
            MaterialButton(
                onPressed: (){
                  //get the new habit name
                  String newHabitName = textController.text;

                  //save to db
                  context.read<HabitDatabase>().addHabit(newHabitName);

                  //pop box
                  Navigator.pop(context);

                  textController.clear();
                },
              child: Text("Save"),
            ),

            //cancel button
            MaterialButton(
                onPressed: (){
                  Navigator.pop(context);

                  textController.clear();
                },
              child: const Text("Cancel"),
            )
          ],
        )
    );
  }

  //check habit on & off
  void checkHabitOnOff(bool? value, Habit habit) {
    // update habit completion status
    if (value != null) {
      context.read<HabitDatabase>().updateHabitCompletion(habit.id, value);
    }
  }

  // edit habit box
  void editHabitBox(Habit habit){
    //set the controller's text to the habit's current name
    textController.text = habit.name;

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(
            controller: textController,
          ),
          actions: [
            //save button
            MaterialButton(
              onPressed: (){
                //get the new habit name
                String newHabitName = textController.text;

                //save to db
                context.read<HabitDatabase>().updateHabitName(habit.id, newHabitName);

                //pop box
                Navigator.pop(context);

                textController.clear();
              },
              child: Text("Save"),
            ),

            //cancel button
            MaterialButton(
              onPressed: (){
                Navigator.pop(context);

                textController.clear();
              },
              child: const Text("Cancel"),
            )
          ],
        )
    );
  }

  // delete habit box
  void deleteHabitBox(Habit habit){

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
         title: const Text("Are you sure you want to delete?"),
          actions: [
            //delete button
            MaterialButton(
              onPressed: (){
                //save to db
                context.read<HabitDatabase>().deleteHabit(habit.id);

                //pop box
                Navigator.pop(context);
              },
              child: Text("Delete"),
            ),

            //cancel button
            MaterialButton(
              onPressed: (){
                Navigator.pop(context);

                textController.clear();
              },
              child: const Text("Cancel"),
            )
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: MyDrawer(
        value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
        onChanged: (value){
          Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: const Icon(
          Icons.add
        ),
      ),
      body: ListView(
        children: [
          // HEATMAP
          _buildHeatMap(),


          //HABIT LIST
          _buildHabitList()
        ],
      ),
    );
  }

  Widget _buildHeatMap(){
    //get access to database
    final habitDatabase = context.watch<HabitDatabase>();

    //current habits
    List<Habit> currentHabits = habitDatabase.currentHabits;

    //return heatmap UI
    return FutureBuilder<DateTime?>(
        future: habitDatabase.getFirstLaunchDate(),
        builder: (context, snapshot){
          if (snapshot.data == null){
            return CircularProgressIndicator();
          } else {
            return MyHeatMap(
                startDate: snapshot.data!,
                datasets: prepHeatMapDataSet(currentHabits)
            );
          }
        }
    );
  }

  //build habit list
  Widget _buildHabitList(){
    //get access to habit database
    final habitDatabase = context.watch<HabitDatabase>();

    //current habits
    List<Habit> currentHabits = habitDatabase.currentHabits;

    // return list of habits
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: currentHabits.length,
      itemBuilder: (context, index){
        //get each individual habit
        final habit = currentHabits[index];
        //check if the habit is completed today
        bool isCompletedToday = isHabitCompletedToday(habit.completedDays);

          //return habit tile UI
        return MyHabitTile(
          text: habit.name,
          isCompleted: isCompletedToday,
          onChanged: (value) => checkHabitOnOff(value, habit),
          editHabit: (context) => editHabitBox(habit),
           deleteHabit: (context) =>  deleteHabitBox(habit),
          );
      }
    );

  }


}


