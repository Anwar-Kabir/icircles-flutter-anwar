import 'package:flutter/material.dart';
import 'package:icircles/app_config.dart';
import 'package:icircles/screens/update_profile/toggle_button.dart';

class UpdateProfileConfig extends StatelessWidget {
  const UpdateProfileConfig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.08,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _configItem(context, text: "Experience", toggle: false),
            _configItem(context, text: "Portfolio", toggle: false),
            _configItem(context, text: "Language", toggle: false),
            _configItem(context, text: "Testimonials", toggle: false),
            _configItem(context, text: "Skills", toggle: false),
            _configItem(context, text: "Interests", toggle: false),
            _configItem(context, text: "Blog", toggle: true),
            _configItem(context, text: "References", toggle: true),
            _configItem(context, text: "Services", toggle: true),
            _configItem(context, text: "Blog", toggle: true),
            _configItem(context, text: "Awards", toggle: true),
            _configItem(context, text: "Clients", toggle: true),
            _configItem(context, text: "Appointments", toggle: true),
          ],
        ),
      ),
    );
  }

  _configItem(context, {required text, required toggle}) {
    return Container(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.02,
      ),
      child: Row(
        children: [
          ToggleSwitch(
            toggle: toggle,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
          ),
          Text(
            text,
            style: TextStyle(
              color: AppCon.color.textColor1,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
