// Copyright (c) 2022 xuty.
// SPDX-License-Identifier: MIT

import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:native_toolchain_c/native_toolchain_c.dart';

/// Builds the PTY implementation as a Dart Native Asset.
///
/// The legacy `ffiPlugin` CMake configuration still bundles a library for
/// existing Flutter desktop builds. Native Assets additionally makes the same
/// implementation available to the Dart VM used by `flutter test`, where
/// plugin CMake output is otherwise not placed on the dynamic-loader path.
void main(List<String> arguments) async {
  await build(arguments, _build);
}

Future<void> _build(BuildInput input, BuildOutputBuilder output) async {
  if (!input.config.buildCodeAssets) return;

  _addNativeDependencies(input, output);

  final targetOS = input.config.code.targetOS;
  final linkMode = targetOS == OS.iOS
      ? LinkModePreference.static
      : LinkModePreference.dynamic;
  await CBuilder.library(
    // Do not collide with the legacy plugin's libflutter_pty binary when a
    // Flutter application builds both integration paths.
    name: 'flutter_pty_native',
    packageName: input.packageName,
    assetName: 'src/flutter_pty_native_bindings.dart',
    sources: const ['src/flutter_pty.c'],
    defines: const {'DART_SHARED_LIB': null},
    libraries: [if (targetOS == OS.linux) 'pthread'],
    flags: [if (targetOS == OS.android) '-Wl,-z,max-page-size=16384'],
    linkModePreference: linkMode,
  ).run(input: input, output: output);
}

void _addNativeDependencies(BuildInput input, BuildOutputBuilder output) {
  const paths = [
    'src/flutter_pty.c',
    'src/flutter_pty.h',
    'src/flutter_pty_unix.c',
    'src/flutter_pty_win.c',
    'src/forkpty.c',
    'src/forkpty.h',
    'src/include/dart_api_dl.c',
    'src/include/dart_api_dl.h',
    'src/include/dart_api.h',
    'src/include/dart_native_api.h',
    'src/include/dart_tools_api.h',
    'src/include/dart_version.h',
    'src/include/internal/dart_api_dl_impl.h',
  ];

  for (final path in paths) {
    final uri = input.packageRoot.resolve(path);
    if (File.fromUri(uri).existsSync()) output.dependencies.add(uri);
  }
}
