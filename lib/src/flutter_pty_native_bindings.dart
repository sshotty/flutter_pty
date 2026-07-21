// Copyright (c) 2022 xuty.
// SPDX-License-Identifier: MIT

// ignore_for_file: non_constant_identifier_names
/// Native-asset entry points for the PTY implementation.
///
/// `flutter_pty_bindings_generated.dart` continues to own the generated FFI
/// struct declarations. Keeping the small callable surface here lets Dart's
/// Native Assets resolver load the library in both Flutter applications and
/// `flutter test` without a hard-coded `.so` / `.dll` / framework path.
@ffi.DefaultAsset('package:flutter_pty/src/flutter_pty_native_bindings.dart')
library;

import 'dart:ffi' as ffi;

import 'flutter_pty_bindings_generated.dart' show PtyHandle, PtyOptions;

class FlutterPtyNativeBindings {
  const FlutterPtyNativeBindings();

  int Dart_InitializeApiDL(ffi.Pointer<ffi.Void> data) =>
      _dartInitializeApiDL(data);

  ffi.Pointer<PtyHandle> pty_create(ffi.Pointer<PtyOptions> options) =>
      _ptyCreate(options);

  void pty_write(
    ffi.Pointer<PtyHandle> handle,
    ffi.Pointer<ffi.Char> buffer,
    int length,
  ) => _ptyWrite(handle, buffer, length);

  void pty_ack_read(ffi.Pointer<PtyHandle> handle) => _ptyAckRead(handle);

  int pty_resize(
    ffi.Pointer<PtyHandle> handle,
    int rows,
    int cols,
    int pixelWidth,
    int pixelHeight,
  ) => _ptyResize(handle, rows, cols, pixelWidth, pixelHeight);

  int pty_getpid(ffi.Pointer<PtyHandle> handle) => _ptyGetPid(handle);

  ffi.Pointer<ffi.Char> pty_error() => _ptyError();
}

@ffi.Native<ffi.IntPtr Function(ffi.Pointer<ffi.Void>)>(
  symbol: 'Dart_InitializeApiDL',
)
external int _dartInitializeApiDL(ffi.Pointer<ffi.Void> data);

@ffi.Native<ffi.Pointer<PtyHandle> Function(ffi.Pointer<PtyOptions>)>(
  symbol: 'pty_create',
)
external ffi.Pointer<PtyHandle> _ptyCreate(ffi.Pointer<PtyOptions> options);

@ffi.Native<
  ffi.Void Function(ffi.Pointer<PtyHandle>, ffi.Pointer<ffi.Char>, ffi.Int)
>(symbol: 'pty_write')
external void _ptyWrite(
  ffi.Pointer<PtyHandle> handle,
  ffi.Pointer<ffi.Char> buffer,
  int length,
);

@ffi.Native<ffi.Void Function(ffi.Pointer<PtyHandle>)>(symbol: 'pty_ack_read')
external void _ptyAckRead(ffi.Pointer<PtyHandle> handle);

@ffi.Native<
  ffi.Int Function(ffi.Pointer<PtyHandle>, ffi.Int, ffi.Int, ffi.Int, ffi.Int)
>(symbol: 'pty_resize')
external int _ptyResize(
  ffi.Pointer<PtyHandle> handle,
  int rows,
  int cols,
  int pixelWidth,
  int pixelHeight,
);

@ffi.Native<ffi.Int Function(ffi.Pointer<PtyHandle>)>(symbol: 'pty_getpid')
external int _ptyGetPid(ffi.Pointer<PtyHandle> handle);

@ffi.Native<ffi.Pointer<ffi.Char> Function()>(symbol: 'pty_error')
external ffi.Pointer<ffi.Char> _ptyError();
