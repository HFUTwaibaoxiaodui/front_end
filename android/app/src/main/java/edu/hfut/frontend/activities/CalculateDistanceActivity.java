package edu.hfut.frontend.activities;

import android.app.Activity;
import android.content.Context;
import android.util.Log;

import com.amap.api.location.AMapLocationClient;
import com.amap.api.location.AMapLocationClientOption;
import com.amap.api.location.AMapLocationListener;
import com.amap.api.maps.AMapUtils;
import com.amap.api.maps.model.LatLng;

import edu.hfut.frontend.listeren.DistanceListener;

public class CalculateDistanceActivity{

    private volatile LatLng latLng = null;

    private DistanceListener _listener;
    double latitude;
    double longitude;

    public CalculateDistanceActivity(){}

    private static class CalculateDistanceSingleton {
        private static final CalculateDistanceActivity INSTANCE = new CalculateDistanceActivity();
    }

    public static CalculateDistanceActivity getInstance() {
        return CalculateDistanceSingleton.INSTANCE;
    }


    // 声明AMapLocationClient类对象，定位发起端
    private AMapLocationClient

            aMapLocationClient = null;
    // 声明LocationOption对象，定位参数
    public AMapLocationClientOption aMapLocationClientOption = null;

    private final AMapLocationListener locationListener = location -> {
        if (null != location) {
            if(_listener!=null){
                _listener.distance(location.getLatitude(), location.getLongitude());
            }
        }
    };


    public void getCurrentDistance(double latitude, double longitude, Context context, DistanceListener listener) {

        this.latitude = latitude;
        this.longitude = longitude;
        this._listener = listener;
        initLocation(context);


     //   return AMapUtils.calculateLineDistance(latLng, new LatLng(latitude, longitude));
    }

    /**
     * 初始化定位发起端
     */
    private void initLocation(Context context){
        try {
            // 初始化定位
            aMapLocationClient = new AMapLocationClient(context);
            initDefaultLocationOption();
            aMapLocationClient.setLocationOption(aMapLocationClientOption);
            // 设置定位回调监听
            aMapLocationClient.setLocationListener(locationListener);
            aMapLocationClient.startLocation();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 初始化地图定位信息
     */
    private void initDefaultLocationOption() {
        aMapLocationClientOption = new AMapLocationClientOption();

        // 设置定位模式为Hight_Accuracy高精度模式
        aMapLocationClientOption.setLocationMode(AMapLocationClientOption.AMapLocationMode.Hight_Accuracy);

        // 设置是否返回地址信息（默认返回地址信息）
        aMapLocationClientOption.setNeedAddress(true);

        // 设置定位间隔,单位毫秒,默认为2000ms
        aMapLocationClientOption.setOnceLocation(true);
    }
}
