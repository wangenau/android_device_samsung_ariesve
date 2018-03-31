/*
 * Copyright (C) 2013 The CyanogenMod Project
 *           (C) 2017 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.cyanogenmod.settings.device;

import android.content.Context;
import android.os.Bundle;
import android.os.Handler;
import android.os.FileObserver;
import android.preference.CheckBoxPreference;
import android.preference.ListPreference;
import android.preference.Preference;
import android.preference.PreferenceFragment;

import com.cyanogenmod.settings.device.R;

public class GeneralFragmentActivity extends PreferenceFragment {

    private CheckBoxPreference mFastCharge;
    private ListPreference mOTGCharge;
    private Preference mGSensor;
    private FileObserver mObserver;

    private Handler mHandler = new Handler();

    private final Runnable mFileChangedRunnable = new Runnable() {
        @Override
        public void run() {
            boolean mNewFeatureValue = FastCharge.isActive();
            onFileChanged(mNewFeatureValue);
            mFastCharge.setChecked(mNewFeatureValue);
        }
    };

    /**
     * subclasses can override onFileChanged() to hook
     * into the FileObserver onEvent() callback
     */

    protected void onFileChanged(boolean featureState){}

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        addPreferencesFromResource(R.xml.general_preferences);

        Context mContext = getActivity();

        mGSensor = (Preference) findPreference(DeviceSettings.KEY_GSENSOR);
        mGSensor.setEnabled(GSensor.isSupported());

        mFastCharge = (CheckBoxPreference) findPreference(DeviceSettings.KEY_FAST_CHARGE);
        mFastCharge.setEnabled(FastCharge.isSupported());
        mFastCharge.setOnPreferenceChangeListener(new FastCharge(mContext));

        mObserver = new FileObserver(FastCharge.getFilePath(), FileObserver.MODIFY) {
            @Override
            public void onEvent(int event, String file) {
                mHandler.postDelayed(mFileChangedRunnable, 1);
            }
        };
        mObserver.startWatching();

        mOTGCharge = (ListPreference) findPreference(DeviceSettings.KEY_OTG_CHARGE);
        mOTGCharge.setEnabled(OTGCharge.isSupported());
        mOTGCharge.setOnPreferenceChangeListener(new OTGCharge());
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        mFastCharge.setChecked(FastCharge.isActive());
    }

    @Override
    public void onDestroy() {
        mObserver.stopWatching();
        super.onDestroy();
    }

    public static void restore(Context context) {
        OTGCharge.restore(context);
    }
}
