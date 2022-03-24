package edu.hfut.frontend.demo.basic.map;


import android.os.Bundle;

import androidx.fragment.app.FragmentActivity;

import com.amap.api.maps.AMap;
import com.amap.api.maps.MapView;
import com.amap.api.maps.TextureSupportMapFragment;
import edu.hfut.frontend.R;

/**
 * 基本地图（TextureSupportMapFragment）实现
 */
public class BaseTextureSupportMapFragmentActivity extends FragmentActivity {
	private AMap mMap;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.basemap_texture_support_fragment_activity);
		setUpMapIfNeeded();

		setTitle("基本地图（TextureSupportMapFragment）");
	}

	@Override
	protected void onResume() {
		super.onResume();
		setUpMapIfNeeded();
	}

	@Override
	protected void onDestroy(){
		super.onDestroy();
	}

	private void setUpMapIfNeeded() {
		if (mMap == null) {
			MapView mapView = findViewById(R.id.map);
			mMap = mapView.getMap();
		}
	}

}
