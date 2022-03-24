package edu.hfut.frontend;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.amap.api.location.AMapLocation;
import com.amap.api.location.AMapLocationClient;
import com.amap.api.location.AMapLocationClientOption;
import com.amap.api.location.AMapLocationListener;
import com.amap.api.maps.AMap;
import com.amap.api.maps.LocationSource;
import com.amap.api.maps.MapView;
import com.amap.api.navi.CheckPermissionsActivity;

import edu.hfut.frontend.utils.Utils;

public class MainMapActivity extends CheckPermissionsActivity implements LocationSource {

    //AMap是地图对象
    private AMap aMap;
    private MapView mapView;
    //声明AMapLocationClient类对象，定位发起端
    private AMapLocationClient aMapLocationClient = null;
    //声明LocationOption对象，定位参数
    public AMapLocationClientOption aMapLocationClientOption = null;
    //声明Listener对象，定位监听器
    private LocationSource.OnLocationChangedListener listener = null;
    //标识，用于判断是否只显示一次定位信息和用户重新定位
    private boolean isFirstLoc = true;

    private final AMapLocationListener locationListener = new AMapLocationListener() {
        @Override
        public void onLocationChanged(AMapLocation location) {
            long callBackTime = System.currentTimeMillis();
            StringBuffer sb = new StringBuffer();
            sb.append("回调时间: ").append(Utils.formatUTC(callBackTime, null)).append("\n");
            if (null == location) {
                sb.append("定位失败：location is null!!!!!!!");
            } else {
                sb.append(Utils.getLocationStr(location));
            }

            System.out.println(sb);
        }
    };

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        // App合规检测
        AMapLocationClient.updatePrivacyShow(this, true, true);
        AMapLocationClient.updatePrivacyAgree(this, true);

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main_map);

        //获取地图控件引用
        mapView = (MapView) findViewById(R.id.map);
        //在activity执行onCreate时执行mMapView.onCreate(savedInstanceState)，创建地图
        mapView.onCreate(savedInstanceState);

        initLocation();
    }

    /**
     * 初始化定位发起端
     */
    private void initLocation(){

        try {
            //初始化定位
            aMapLocationClient = new AMapLocationClient(getApplicationContext());
            initDefaultLocationOption();
            aMapLocationClient.setLocationOption(aMapLocationClientOption);
            //设置定位回调监听
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
        aMapLocationClientOption.setInterval(2000);
    }

    @Override
    public void activate(OnLocationChangedListener onLocationChangedListener) {

    }

    @Override
    public void deactivate() {

    }

}
