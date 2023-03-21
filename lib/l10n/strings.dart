import 'package:flutter/material.dart';

import 'localiztions.dart';


class Strings {
  late final BuildContext context;

  Strings.of(this.context);

  String get appName => AppLocalizations.of(context)!.appName;
}
