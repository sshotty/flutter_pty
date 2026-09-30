// Relative import to be able to reuse the C sources shared with the CocoaPods
// and CMake builds. Swift Package Manager rejects target paths outside the
// package root, so the sources live in `src/` and are pulled in from here.
//
// See the comment in ../../flutter_pty.podspec for more information.
#include "../../../../src/flutter_pty.c"
