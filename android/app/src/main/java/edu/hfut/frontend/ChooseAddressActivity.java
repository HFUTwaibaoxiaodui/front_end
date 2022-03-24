package edu.hfut.frontend;

import android.content.Intent;
import android.os.Bundle;
import android.widget.RelativeLayout;

import androidx.appcompat.app.AppCompatActivity;

import com.amap.api.services.core.PoiItem;
import com.amap.poisearch.searchmodule.ISearchModule.IDelegate.IParentDelegate;
import com.amap.poisearch.searchmodule.SearchModuleDelegate;
import com.amap.poisearch.util.CityModel;
import com.google.gson.Gson;

public class ChooseAddressActivity extends AppCompatActivity {

    private SearchModuleDelegate mSearchModuleDelegate;

    private int mFavType = 0;

    public static final String CURR_CITY_KEY = "curr_city_key";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_choose_address);

        RelativeLayout contentView = (RelativeLayout)findViewById(R.id.content_view);
        mSearchModuleDelegate = new SearchModuleDelegate();
        mSearchModuleDelegate.bindParentDelegate(mSearchModuleParentDelegate);
        contentView.addView(mSearchModuleDelegate.getWidget(this));

        mSearchModuleDelegate.setFavAddressVisible(false);

        mFavType = getIntent().getIntExtra(NewMainActivity.FAVTYPE_KEY, -1);
    }

    @Override
    protected void onResume() {
        super.onResume();
        try {
            String currCityStr = getIntent().getStringExtra(CURR_CITY_KEY);
            Gson gson = new Gson();
            CityModel cityModel = gson.fromJson(currCityStr, CityModel.class);
            mSearchModuleDelegate.setCity(cityModel);
        } catch (Exception e) {
            ;
        }


    }

    private final SearchModuleDelegate.IParentDelegate mSearchModuleParentDelegate = new IParentDelegate() {
        @Override
        public void onChangeCityName() {
            Intent intent = new Intent();
            intent.setClass(ChooseAddressActivity.this, CityChooseActivity.class);
            intent.putExtra(CityChooseActivity.CURR_CITY_KEY, mSearchModuleDelegate.getCurrCity().getCity());
            ChooseAddressActivity.this.startActivityForResult(intent, 1);
        }

        @Override
        public void onCancel() {
            ChooseAddressActivity.this.finish();
        }

        @Override
        public void onSetFavHomePoi() {
        }

        @Override
        public void onSetFavCompPoi() {
        }

        @Override
        public void onChooseFavHomePoi(PoiItem poiItem) {
        }

        @Override
        public void onChooseFavCompPoi(PoiItem poiItem) {
        }

        @Override
        public void onSelPoiItem(PoiItem poiItem) {
            String poiitemStr = new Gson().toJson(poiItem);
            Intent resIntent = new Intent();
            resIntent.putExtra(NewMainActivity.FAVTYPE_KEY, mFavType);
            resIntent.putExtra(NewMainActivity.POIITEM_STR_KEY, poiitemStr);
            ChooseAddressActivity.this.setResult(RESULT_OK, resIntent);
            ChooseAddressActivity.this.finish();
        }
    };

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {

        // 表示结果来自城市选择actiivty
        if (requestCode == 1 && requestCode == RESULT_OK) {
            String currCityStr = data.getStringExtra(CityChooseActivity.CURR_CITY_KEY);
            Gson gson = new Gson();
            CityModel cityModel = gson.fromJson(currCityStr, CityModel.class);
            mSearchModuleDelegate.setCity(cityModel);
        }

        super.onActivityResult(requestCode, resultCode, data);
    }
}