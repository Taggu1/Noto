import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/habits/domain/models/habit.dart';
import 'package:note_app/features/habits/presentation/pages/habit_page.dart';
import 'package:note_app/features/note/presentation/pages/notes_page.dart';
import 'package:note_app/features/todo/domain/entities/task.dart';
import 'package:note_app/features/todo/presentation/pages/tasks_page.dart';
import 'package:note_app/features/todo/presentation/widgets/add_item_sheet.dart';

import '../../../auth/presentation/auth/auth_bloc.dart';
import '../widgets/app_drawer.dart';
import 'edit_add_note_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedPageIndex = 0;

  List<Widget> pages = [
    const NotesPage(),
    const TasksPage(),
    const HabitPage(),
  ];

  @override
  void initState() {
    super.initState();
    final authState = BlocProvider.of<AuthBloc>(context).state;
    if (authState is AuthenticatedAuthState) {
      return;
    }
    BlocProvider.of<AuthBloc>(context).add(
      FetchUserAuthEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addButtonOnPressedFunc(context),
        child: const Icon(Icons.add),
      ),
      body: Row(
        children: [
          if (size.width > 700)
            NavigationRail(
              leading: const SizedBox(
                height: 10,
              ),
              labelType: NavigationRailLabelType.selected,
              onDestinationSelected: _onDesetenationSelected,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.notes),
                  label: Text(
                    "Notes",
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.task),
                  label: Text(
                    "To-dos",
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.repeat),
                  label: Text(
                    "Habits",
                  ),
                ),
              ],
              selectedIndex: _selectedPageIndex,
            ),
          pages[_selectedPageIndex]
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: size.width < 700
          ? NavigationBar(
              height: 70,
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              selectedIndex: _selectedPageIndex,
              onDestinationSelected: _onDesetenationSelected,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.notes),
                  label: "Notes",
                ),
                NavigationDestination(
                  icon: Icon(Icons.task),
                  label: "To-dos",
                ),
                NavigationDestination(
                  icon: Icon(Icons.repeat),
                  label: "Habits",
                ),
              ],
            )
          : null,
    );
  }

  _onDesetenationSelected(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  _addButtonOnPressedFunc(BuildContext context) {
    switch (_selectedPageIndex) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const EditAddNotePage(
              isAdd: true,
              noteIndex: 0,
            ),
          ),
        );
      case 1:
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (s) => const AddItemSheet<AppTask>(
            isTask: true,
          ),
        );
      case 2:
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (s) => const AddItemSheet<Habit>(
            isTask: false,
          ),
        );
    }
  }
}
