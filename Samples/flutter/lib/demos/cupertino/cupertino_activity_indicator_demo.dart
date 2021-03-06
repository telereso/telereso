// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';
import 'package:gallery/l10n/remote_localization.telereso.dart';

// BEGIN cupertinoActivityIndicatorDemo

class CupertinoProgressIndicatorDemo extends StatelessWidget {
  const CupertinoProgressIndicatorDemo();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle: Text(
          RemoteLocalizationsDefault.of(context).demoCupertinoActivityIndicatorTitle,
        ),
      ),
      child: const Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}

// END
