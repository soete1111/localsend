import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localsend_app/gen/strings.g.dart';
import 'package:localsend_app/provider/tv_provider.dart';
import 'package:localsend_app/theme.dart';
import 'package:routerino/routerino.dart';

/// A normal [TextFormField] on mobile and desktop.
/// A button which opens a dialog on Android TV
class TextFieldTv extends ConsumerStatefulWidget {
  final String name;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const TextFieldTv({
    required this.name,
    required this.controller,
    required this.onChanged,
  });

  @override
  ConsumerState<TextFieldTv> createState() => _TextFieldTvState();
}

class _TextFieldTvState extends ConsumerState<TextFieldTv> {
  @override
  Widget build(BuildContext context) {
    final isTv = ref.watch(tvProvider);

    if (isTv) {
      return TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).inputDecorationTheme.fillColor,
          shape: RoundedRectangleBorder(borderRadius: Theme.of(context).inputDecorationTheme.borderRadius),
          foregroundColor: Theme.of(context).colorScheme.onSurface,
        ),
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(widget.name),
                content: TextFormField(
                  controller: widget.controller,
                  textAlign: TextAlign.center,
                  onChanged: widget.onChanged,
                  autofocus: true,
                  onFieldSubmitted: (_) => context.pop(),
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).buttonTheme.colorScheme!.primary,
                      foregroundColor: Theme.of(context).buttonTheme.colorScheme!.onPrimary,
                    ),
                    onPressed: () => context.pop(),
                    child: Text(t.general.confirm),
                  )
                ],
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(widget.controller.text, style: Theme.of(context).textTheme.titleMedium),
        ),
      );
    } else {
      return TextFormField(
        controller: widget.controller,
        textAlign: TextAlign.center,
        onChanged: widget.onChanged,
      );
    }
  }
}
