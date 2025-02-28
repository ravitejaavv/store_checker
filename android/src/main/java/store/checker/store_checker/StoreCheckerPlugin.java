package store.checker.store_checker;

import android.annotation.TargetApi;
import android.content.Context;
import android.content.pm.InstallSourceInfo;
import android.content.pm.PackageManager;
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

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    // Check call method
    if (call.method.equals("getSource")) {
      try {
        String packageName = applicationContext.getPackageName();
        String installerPackageName;

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
          // For Android 11 (API level 30) and above
          InstallSourceInfo info = applicationContext.getPackageManager().getInstallSourceInfo(packageName);
          installerPackageName = info.getInstallingPackageName();
        } else {
          // For versions below Android 11
          installerPackageName = applicationContext.getPackageManager().getInstallerPackageName(packageName);
        }

        result.success(installerPackageName);
      } catch (Exception e) {
        result.error("ERROR", "Failed to get installer source: " + e.getMessage(), null);
      }
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