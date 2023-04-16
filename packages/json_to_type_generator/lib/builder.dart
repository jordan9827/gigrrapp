import 'dart:async';

import 'package:build/build.dart';
import 'package:json_to_type_generator/src/json_to_type_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:glob/glob.dart';

Builder jsonToTypeGenerator(BuilderOptions options) => JsonToTypeBuilder();

class JsonToTypeBuilder extends Builder {
  static final inputFiles = Glob('lib/**');

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final resolver = buildStep.resolver;
    final outputFile = AssetId(buildStep.inputId.package,'lib/data/network/json_converter.dart');

    final imports = <String>[];
    final files = <String>['final jsonConverters = <Type, Function>{'];

    final packageNameImport = "import 'package:${buildStep.inputId.package}/";

    await for (final input in buildStep.findAssets(inputFiles)) {

      final assetId = AssetId(buildStep.inputId.package, input.path);
      if (await resolver.isLibrary(assetId) && outputFile != assetId) {
        final library = await resolver.libraryFor(assetId);
        final jsonToTypeBuilder = JsonToTypeGenerator();
        final className = await jsonToTypeBuilder.generate(LibraryReader(library), buildStep);
        if (className.isNotEmpty) {
          imports.add(packageNameImport + input.path.replaceRange(0, 4, "") + "';");
          files.add(className);
        }
      }
    }
    files.add('};');
    final output = [
      ...imports,
      ...files,
    ];
    String outputContent = output.join('\n');
    return buildStep.writeAsString(outputFile, outputContent);
  }

  @override
  Map<String, List<String>> get buildExtensions => const {
    '\$lib\$': ['data/network/json_converter.dart'],
  };

}