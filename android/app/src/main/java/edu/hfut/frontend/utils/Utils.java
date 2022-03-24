package edu.hfut.frontend.utils;

import java.text.SimpleDateFormat;
import java.util.Locale;

import com.amap.api.location.AMapLocation;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.text.TextUtils;

public class Utils {
    /**
     *  开始定位
     */
    public final static int MSG_LOCATION_START = 0;
    /**
     * 定位完成
     */
    public final static int MSG_LOCATION_FINISH = 1;
    /**
     * 停止定位
     */
    public final static int MSG_LOCATION_STOP= 2;

    public final static String KEY_URL = "URL";
    public final static String URL_H5LOCATION = "file:///android_asset/sdkLoc.html";
    /**
     * 根据定位结果返回定位信息的字符串
     * @param location 当前定位
     * @return 定位数据字符串
     */
    public synchronized static String getLocationStr(AMapLocation location){
        if(null == location){
            return null;
        }
        StringBuilder sb = new StringBuilder();
        //errCode等于0代表定位成功，其他的为定位失败，具体的可以参照官网定位错误码说明
        if(location.getErrorCode() == 0){
            sb.append("定位成功!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + "\n")
                    .append("定位类型: " + location.getLocationType() + "\n")
                    .append("经    度    : " + location.getLongitude() + "\n")
                    .append("纬    度    : " + location.getLatitude() + "\n")
                    .append("精    度    : " + location.getAccuracy() + "米" + "\n")
                    .append("提供者    : " + location.getProvider() + "\n")
                    .append("速    度    : " + location.getSpeed() + "米/秒" + "\n")
                    .append("角    度    : " + location.getBearing() + "\n")
                    // 获取当前提供定位服务的卫星个数
                    .append("星    数    : " + location.getSatellites() + "\n")
                    .append("国    家    : " + location.getCountry() + "\n")
                    .append("省            : " + location.getProvince() + "\n")
                    .append("市            : " + location.getCity() + "\n")
                    .append("城市编码 : " + location.getCityCode() + "\n")
                    .append("区            : " + location.getDistrict() + "\n")
                    .append("区域 码   : " + location.getAdCode() + "\n")
                    .append("地    址    : " + location.getAddress() + "\n")
                    .append("兴趣点    : " + location.getPoiName() + "\n")
                    //定位完成的时间
                    .append("定位时间: " + formatUTC(location.getTime(), "yyyy-MM-dd HH:mm:ss") + "\n");
        } else {
            //定位失败
            sb.append("定位失败" + "\n")
                    .append("错误码:" + location.getErrorCode() + "\n")
                    .append("错误信息:" + location.getErrorInfo() + "\n")
                    .append("错误描述:" + location.getLocationDetail() + "\n");
        }
        //定位之后的回调时间
        sb.append("回调时间: " + formatUTC(System.currentTimeMillis(), "yyyy-MM-dd HH:mm:ss") + "\n");
        return sb.toString();
    }

    private static SimpleDateFormat sdf = null;
    public  static String formatUTC(long l, String strPattern) {
        if (TextUtils.isEmpty(strPattern)) {
            strPattern = "yyyy-MM-dd HH:mm:ss";
        }
        if (sdf == null) {
            try {
                sdf = new SimpleDateFormat(strPattern, Locale.CHINA);
            } catch (Throwable ignored) {
            }
        } else {
            sdf.applyPattern(strPattern);
        }
        return sdf == null ? "NULL" : sdf.format(l);
    }

    /**
     * 获取app的名称
     * @param context
     * @return
     */
    public static String getAppName(Context context) {
        String appName = "";
        try {
            PackageManager packageManager = context.getPackageManager();
            PackageInfo packageInfo = packageManager.getPackageInfo(
                    context.getPackageName(), 0);
            int labelRes = packageInfo.applicationInfo.labelRes;
            appName =  context.getResources().getString(labelRes);
        } catch (Throwable e) {
            e.printStackTrace();
        }
        return appName;
    }
}
