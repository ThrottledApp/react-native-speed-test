
package com.reactlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.Promise;

public class RNSpeedTestModule extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;

  public RNSpeedTestModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  private static final String SPEED_TEST_ERROR = "SPEED_TEST_ERROR";
  @ReactMethod
  public void getSpeed(Promise promise) {
      promise.resolve(200);
  }

  @Override
  public String getName() {
    return "RNSpeedTest";
  }
}
