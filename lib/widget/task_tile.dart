import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/text_styles.dart';

class TaskTile extends StatelessWidget {
  TaskTile(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged});

  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        final player = AudioPlayer();
        player.play(
          AssetSource("assest/audio/bubble_click.wav"),
        );
      },
      leading: Checkbox(
        value: taskCompleted,
        onChanged: onChanged,
        activeColor: kColorPrimary,
      ),
      title: Text(
        taskName,
        style: kTextStyleGabaritoRegular.copyWith(
          fontSize: 14,
          decoration:
              taskCompleted ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
    );
    // return CheckboxListTile(
    //   title: Text(taskName),
    //   value: taskCompleted, onChanged: onChanged,

    // );
  }
}
