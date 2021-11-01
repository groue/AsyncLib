### A repository that demonstrates the difficulty to run async tests with Xcode 13.2 beta on pre iOS-15 simulators

This demonstration uses an iOS 13.7 simulator.

PROBLEM: This command skips the async test. It should not:

```sh
xcodebuild \
  -project AsyncLib.xcodeproj \
  -scheme AsyncLibTests \
  -destination 'platform=iOS Simulator,name=iPhone 8,OS=13.7' \
  build-for-testing test-without-building
```

<details><summary>Output</summary>

```
Command line invocation:
    /Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild -project AsyncLib.xcodeproj -scheme AsyncLibTests -destination "platform=iOS Simulator,name=iPhone 8,OS=13.7" build-for-testing test-without-building

User defaults from command line:
    IDEPackageSupportUseBuiltinSCM = YES

note: Using new build system
note: Planning
Analyze workspace

Create build description
Build description signature: a14dabc897593fdaa8143b70be9cecd9
Build description path: /Users/groue/Library/Developer/Xcode/DerivedData/AsyncLib-embjdibmowsosldclaycitzaxhhx/Build/Intermediates.noindex/XCBuildData/a14dabc897593fdaa8143b70be9cecd9-desc.xcbuild

note: Build preparation complete
note: Building targets in dependency order
** TEST BUILD SUCCEEDED **

Testing started
Test Suite 'All tests' started at 2021-11-01 15:35:23.737
Test Suite 'AsyncLibTests.xctest' started at 2021-11-01 15:35:23.740
Test Suite 'AsyncLibTests' started at 2021-11-01 15:35:23.740
-[AsyncLibTests testAsyncFunction] skipped: Test is unavailable since it uses features not supported by this OS version
Test Suite 'AsyncLibTests' passed at 2021-11-01 15:35:23.743.
	 Executed 1 test, with 1 test skipped and 0 failures (0 unexpected) in 0.002 (0.003) seconds
Test Suite 'AsyncLibTests.xctest' passed at 2021-11-01 15:35:23.744.
	 Executed 1 test, with 1 test skipped and 0 failures (0 unexpected) in 0.002 (0.005) seconds
Test Suite 'All tests' passed at 2021-11-01 15:35:23.745.
	 Executed 1 test, with 1 test skipped and 0 failures (0 unexpected) in 0.002 (0.008) seconds
2021-11-01 15:35:24.018 xcodebuild[98254:3034487] [MT] IDETestOperationsObserverDebug: 32.896 elapsed -- Testing started completed.
2021-11-01 15:35:24.018 xcodebuild[98254:3034487] [MT] IDETestOperationsObserverDebug: 0.000 sec, +0.000 sec -- start
2021-11-01 15:35:24.018 xcodebuild[98254:3034487] [MT] IDETestOperationsObserverDebug: 32.896 sec, +32.896 sec -- end

Test session results, code coverage, and logs:
	/Users/groue/Library/Developer/Xcode/DerivedData/AsyncLib-embjdibmowsosldclaycitzaxhhx/Logs/Test/Test-AsyncLibTests-2021.11.01_15-34-51-+0100.xcresult

** TEST EXECUTE SUCCEEDED **
```

</details>

WORKAROUND: This command is able to run ONE async test:

```sh
xcodebuild \
  -project AsyncLib.xcodeproj \
  -scheme AsyncLibTests \
  -destination 'platform=iOS Simulator,name=iPhone 8,OS=13.7' \
  -only-testing:AsyncLibTests/AsyncLibTests/testAsyncFunction \
  build-for-testing test-without-building
```

<details><summary>Output</summary>

```
Command line invocation:
    /Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild -project AsyncLib.xcodeproj -scheme AsyncLibTests -destination "platform=iOS Simulator,name=iPhone 8,OS=13.7" "-only-testing:AsyncLibTests/AsyncLibTests/testAsyncFunction" build-for-testing test-without-building

User defaults from command line:
    IDEPackageSupportUseBuiltinSCM = YES

note: Using new build system
note: Planning
Analyze workspace

Create build description
Build description signature: a14dabc897593fdaa8143b70be9cecd9
Build description path: /Users/groue/Library/Developer/Xcode/DerivedData/AsyncLib-embjdibmowsosldclaycitzaxhhx/Build/Intermediates.noindex/XCBuildData/a14dabc897593fdaa8143b70be9cecd9-desc.xcbuild

note: Build preparation complete
note: Building targets in dependency order
** TEST BUILD SUCCEEDED **

Testing started
Test Suite 'Selected tests' started at 2021-11-01 15:36:04.642
Test Suite 'AsyncLibTests.xctest' started at 2021-11-01 15:36:04.644
Test Suite 'AsyncLibTests' started at 2021-11-01 15:36:04.644
Test Case '-[AsyncLibTests.AsyncLibTests testAsyncFunction]' started.
Test Case '-[AsyncLibTests.AsyncLibTests testAsyncFunction]' passed (0.015 seconds).
Test Suite 'AsyncLibTests' passed at 2021-11-01 15:36:04.661.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.015 (0.017) seconds
Test Suite 'AsyncLibTests.xctest' passed at 2021-11-01 15:36:04.662.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.015 (0.018) seconds
Test Suite 'Selected tests' passed at 2021-11-01 15:36:04.663.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.015 (0.021) seconds
2021-11-01 15:36:04.934 xcodebuild[98380:3036436] [MT] IDETestOperationsObserverDebug: 25.457 elapsed -- Testing started completed.
2021-11-01 15:36:04.934 xcodebuild[98380:3036436] [MT] IDETestOperationsObserverDebug: 0.000 sec, +0.000 sec -- start
2021-11-01 15:36:04.934 xcodebuild[98380:3036436] [MT] IDETestOperationsObserverDebug: 25.457 sec, +25.457 sec -- end

Test session results, code coverage, and logs:
	/Users/groue/Library/Developer/Xcode/DerivedData/AsyncLib-embjdibmowsosldclaycitzaxhhx/Logs/Test/Test-AsyncLibTests-2021.11.01_15-35-39-+0100.xcresult

** TEST EXECUTE SUCCEEDED **
```

</details>
