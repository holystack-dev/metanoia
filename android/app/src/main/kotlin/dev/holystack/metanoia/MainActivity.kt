package dev.holystack.metanoia

import android.os.Bundle
import android.view.WindowManager
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity : FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // The app displays the user's confessed sins. FLAG_SECURE keeps that
        // content out of screenshots, screen recordings, and — the reason it is
        // set here — the thumbnail Android caches for the recent-apps switcher,
        // which otherwise stays visible for as long as the app is backgrounded.
        window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
        super.onCreate(savedInstanceState)
    }
}
