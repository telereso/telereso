import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:telereso_generator/src/remote_generator.dart';

import 'src/generator.dart';

// Builder boringWidget(BuilderOptions options) => LibraryBuilder(BoringWidgetGenerator());
Builder remoteLocalization(BuilderOptions options) => SharedPartBuilder([RemoteLocalizationGenerator()],'remote_localization');


Builder remoteLocalizationBuilder(BuilderOptions options) => RemoteLocalizationBuilder();
