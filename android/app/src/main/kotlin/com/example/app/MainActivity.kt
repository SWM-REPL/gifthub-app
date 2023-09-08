package org.swmaestro.repl.GiftHub

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import android.util.Log
import com.google.android.gms.common.ConnectionResult
import com.google.android.gms.common.GoogleApiAvailability

class MainActivity : FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        checkGooglePlayServicesAvailability()
    }

    override fun onResume() {
        super.onResume()
        checkGooglePlayServicesAvailability()
    }

    private fun checkGooglePlayServicesAvailability() {
        val apiInstance = GoogleApiAvailability.getInstance()
        val apiAvailability = apiInstance.isGooglePlayServicesAvailable(this)
        if (apiAvailability != ConnectionResult.SUCCESS) {
            apiInstance.makeGooglePlayServicesAvailable(activity)
        }
    }
}
