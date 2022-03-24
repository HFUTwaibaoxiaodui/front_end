package edu.hfut.frontend;

import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.widget.RelativeLayout;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.amap.poisearch.searchmodule.CityChooseDelegate;
import com.amap.poisearch.searchmodule.CityChooseWidget;
import com.amap.poisearch.searchmodule.ICityChooseModule;
import com.amap.poisearch.util.CityModel;
import com.google.gson.Gson;

public class CityChooseActivity extends AppCompatActivity {

    private CityChooseWidget mCityChooseWidget;
    private CityChooseDelegate cityChooseDelegate;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_city_choose);

        RelativeLayout contentView = (RelativeLayout)findViewById(R.id.content_view);

        cityChooseDelegate = new CityChooseDelegate();
        cityChooseDelegate.bindParentDelegate(cityChooseParentDelegate);
        contentView.addView(cityChooseDelegate.getWidget(this));
    }

    public static final String CURR_CITY_KEY = "curr_city_key";
    @Override
    protected void onResume() {
        super.onResume();
        String currCity = getIntent().getStringExtra(CURR_CITY_KEY);
        if (TextUtils.isEmpty(currCity)) {
            currCity = "北京市";
        }
        cityChooseDelegate.setCurrCity(currCity);
    }

    private final ICityChooseModule.IParentDelegate cityChooseParentDelegate = new ICityChooseModule.IParentDelegate() {
        @Override
        public void onChooseCity(CityModel city) {
            Intent intent = new Intent();
            String cityStr = new Gson().toJson(city);
            intent.putExtra(CURR_CITY_KEY, cityStr);
            CityChooseActivity.this.setResult(RESULT_OK, intent);
            CityChooseActivity.this.finish();
        }

        @Override
        public void onCancel() {
            CityChooseActivity.this.finish();
        }
    };
}