# Balloon Squeeze 3D — iOS project

This is a [Capacitor](https://capacitorjs.com) wrapper around the game (a self-contained HTML/JS/Three.js file living at `www/index.html`). It turns the web game into a real iOS app you can build with Xcode and submit to the App Store.

**You need a Mac with Xcode to finish this** — that's an Apple requirement for every iOS app, not a limitation of this project. See `../iOS-Submission-Runbook.md` for the full walkthrough (renting a cloud Mac, building, signing, and submitting).

## Quick start (on a Mac, with Xcode + CocoaPods installed)

```bash
cd ios-app
npx cap sync ios      # only needed if you change www/ or capacitor.config.json later
cd ios/App
pod install
open App.xcworkspace  # ALWAYS open the .xcworkspace, never the .xcodeproj, once Pods exist
```

Then in Xcode: pick your Team under Signing & Capabilities, plug in a real device or pick a simulator, and hit Run. When you're ready to submit, use Product → Archive.

## What's already done

- `www/index.html` — the full game, with all its JS libraries (Three.js + the bloom post-processing passes) bundled locally in `www/js/` so the app works fully offline. Nothing fetches from a CDN at runtime.
- The in-game "VS REAL OPPONENT" online-multiplayer entry is hidden automatically outside the Claude artifact viewer (it depended on a Claude-only publishing mechanism that doesn't exist in a native app) — see the comment near `checkOnlineMpOnBoot()` in `www/index.html` if you want to look at exactly how.
- `Info.plist` already declares the microphone usage string the optional "Blow to Inflate" setting needs (`NSMicrophoneUsageDescription`) — without it, turning that setting on would crash the app.
- App icon (`Assets.xcassets/AppIcon.appiconset`) and a launch screen (`Assets.xcassets/Splash.imageset`) are filled in already.

## What you still need to change

- **Bundle identifier**: currently `com.balloonsqueeze.game` in `capacitor.config.json` and the Xcode project — change this to something under your own Apple Developer account/team before you can archive and upload. In Xcode: select the App target → General → Bundle Identifier.
- **Signing team**: Xcode → App target → Signing & Capabilities → pick your Team.
- **Version/build number**: Xcode → App target → General → Version (marketing, e.g. `1.0`) and Build (e.g. `1`).

## Known limitation worth knowing about

The in-game "SAVE IMAGE" share-card button uses a plain `<a download>` link, which works in a normal browser but is unreliable inside Capacitor's WKWebView (iOS's in-app browser engine) — it may silently do nothing when tapped. It won't crash anything, but if you want it working properly, that's a small follow-up (swapping it for Capacitor's Filesystem + Share plugins) rather than something this wrap fixes automatically.
