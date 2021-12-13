import 'package:flutter/material.dart';
import 'package:icircles/app_config.dart';

class ToggleSwitch extends StatefulWidget {
  final bool toggle;
  const ToggleSwitch({
    Key? key,
    this.toggle = false,
  }) : super(key: key);

  @override
  State<ToggleSwitch> createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  bool toggle = false;

  @override
  void initState() {
    setState(() {
      toggle = widget.toggle;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          toggle = !toggle;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 300,
        ),
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width * 0.35,
          maxWidth: MediaQuery.of(context).size.width * 0.35,
          minHeight: MediaQuery.of(context).size.height * 0.05,
          maxHeight: MediaQuery.of(context).size.height * 0.05,
        ),
        decoration: BoxDecoration(
          color: toggle
              ? AppCon.color.textColor1.withOpacity(0.52)
              : const Color.fromRGBO(228, 228, 228, 0.56),
          borderRadius: BorderRadius.circular(26),
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  "On",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Off",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            AnimatedPositioned(
              left: toggle ? 60 : 0,
              right: toggle ? 0 : 60,
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: 300,
                ),
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 0.35,
                  maxWidth: MediaQuery.of(context).size.width * 0.35,
                  minHeight: MediaQuery.of(context).size.height * 0.05,
                  maxHeight: MediaQuery.of(context).size.height * 0.05,
                ),
                decoration: BoxDecoration(
                  color: toggle ? AppCon.color.textColor1 : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              duration: const Duration(
                milliseconds: 300,
              ),
              curve: Curves.easeIn,
            ),
          ],
        ),
      ),
    );
  }
}
