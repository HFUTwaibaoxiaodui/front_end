package edu.hfut.frontend;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import edu.hfut.frontend.activities.AddressPickActivity;
import edu.hfut.frontend.activities.CalculateDistanceActivity;
import edu.hfut.frontend.activities.NavigatorActivity;
import edu.hfut.frontend.listeren.DistanceListener;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    public static final String flutterChannel = "activity_visitor";

    public static MethodChannel.Result mResult;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP){
            getWindow().setStatusBarColor(0);
        }
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),flutterChannel).setMethodCallHandler(
                (call, result) -> {
                    mResult = result;
                    Intent intent = null;
                    switch (call.method) {
                        case "getDistance" :
                            double latitude = 0.0,longitude = 0.0;
                            String str = call.arguments.toString();
                            try{
                                JSONObject obj = new JSONObject(str);
                                latitude = obj.getDouble("latitude");
                                longitude = obj.getDouble("longitude");
                            }catch (Exception e){
                            }
                            if(latitude==0.0 || longitude==0.0){
                                MainActivity.mResult.success("传参出错");
                            } else {
                                Log.i("zz",latitude+","+longitude);
                                new CalculateDistanceActivity().getCurrentDistance(latitude, longitude,
                                        MainActivity.this, new DistanceListener() {
                                            @Override
                                            public void distance(double latitude, double longitude) {
                                                Map<String, Object> resultMap = new HashMap<>();
                                                resultMap.put("longitude", longitude);
                                                resultMap.put("latitude", latitude);
                                                MainActivity.mResult.success(resultMap);
                                            }
                                        });
                            }
                            break;
                        case "pickAddress":
                            intent = new Intent(MainActivity.this, AddressPickActivity.class);
                            startActivity(intent);
                            break;
                        case "navigate":
                            System.out.println(123123);
                            intent = new Intent(MainActivity.this, NavigatorActivity.class);
                            System.out.println(call.arguments.toString());
                            intent.putExtra("address", call.arguments.toString());
                            startActivity(intent);
                            break;
                    }

                }
        );
    }
}
