package store.checker.store_checker;

import android.annotation.TargetApi;
import android.content.Context;
import android.os.Build;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** StoreCheckerPlugin is a android class to find the orign of installed apk */
public class StoreCheckerPlugin implements FlutterPlugin, MethodCallHandler {
  // MethodChannel is used to provide communication between Flutter and native Android
  private MethodChannel channel;
  private Context applicationContext;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    this.applicationContext = flutterPluginBinding.getApplicationContext();
    channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "store_checker");
    channel.setMethodCallHandler(this);
  }

  //This function is used to get the installer package name of current application
  @TargetApi(Build.VERSION_CODES.ECLAIR)
  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    // Check call methos
    if (call.method.equals("getSource")) {
      // get the installer package name
      result.success(applicationContext.getPackageManager().getInstallerPackageName(applicationContext.getPackageName()));
    } else {
      result.notImplemented();
    }
  }

  // onDetachedFromEngine will be used to disconnect the binding between channels
  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
