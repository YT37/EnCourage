import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '/config/constants.dart';
import '/models/response.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _LanguageSelector(),
                    const Divider(height: 40),
                    Obx(() => MODE.value.screen),
                  ],
                ),
              ),
              const Center(child: _ModeSelector()),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageSelector extends StatelessWidget {
  const _LanguageSelector();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: Obx(
            () => DropdownButton(
              value: FROM.value,
              isExpanded: true,
              underline: Container(),
              onChanged: (option) {
                FROM.value = option!;

                CONTROLLER.value.clear();
                RESPONSE.value = Response(
                  response: {},
                  status: Status.EMPTY,
                );
              },
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              selectedItemBuilder: (context) => List.generate(
                FROM_LANGS.length,
                (_) => Center(
                  child: Text(
                    FROM.value,
                    style: context.textTheme.displaySmall,
                  ),
                ),
              ),
              items: List.generate(
                FROM_LANGS.length,
                (index) {
                  final String _lang = FROM_LANGS[index];

                  return DropdownMenuItem(
                    value: _lang,
                    child: Text(
                      _lang,
                      style: context.textTheme.displaySmall,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.theme.colorScheme.secondary,
                  context.theme.colorScheme.tertiary,
                ],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                stops: const [0.35, 0.95],
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              Icons.swap_horiz,
              size: 25,
              color: context.theme.colorScheme.onSecondary,
            ),
          ),
        ),
        Flexible(
          child: Obx(
            () => DropdownButton(
              value: TO.value,
              isExpanded: true,
              underline: Container(),
              onChanged: (option) {
                TO.value = option!;

                CONTROLLER.value.clear();
                RESPONSE.value = Response(
                  response: {},
                  status: Status.EMPTY,
                );
              },
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              selectedItemBuilder: (context) => List.generate(
                TO_LANGS.length,
                (_) => Center(
                  child: Text(
                    TO.value,
                    style: context.textTheme.displaySmall,
                  ),
                ),
              ),
              items: List.generate(
                TO_LANGS.length,
                (index) {
                  final String _lang = TO_LANGS[index];

                  return DropdownMenuItem(
                    value: _lang,
                    child: Text(
                      _lang,
                      style: context.textTheme.displaySmall,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ModeSelector extends StatefulWidget {
  const _ModeSelector();

  @override
  State<_ModeSelector> createState() => _ModeSelectorState();
}

class _ModeSelectorState extends State<_ModeSelector>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.theme.colorScheme.secondary,
            context.theme.colorScheme.tertiary,
          ],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          stops: const [0.35, 0.95],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TabBar(
        dividerHeight: 0,
        unselectedLabelColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.label,
        controller: TabController(
          vsync: this,
          length: MODES.length,
          initialIndex: MODES.indexWhere((mode) => mode == MODE.value),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        tabs: List.generate(
          MODES.length,
          (index) => Icon(MODES[index].icon),
        ),
        onTap: (index) => MODE.value = MODES[index],
      ),
    );
  }
}
