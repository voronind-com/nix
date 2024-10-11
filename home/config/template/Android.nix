{
  description = "Android dev environment.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        system = system;
        config = {
          allowUnfree = true;
          android_sdk.accept_license = true;
        };
      };
      jdk = pkgs.jdk11;
      buildTools = "31.0.0";
      androidComposition = pkgs.androidenv.composeAndroidPackages {
        abiVersions = [
          "armeabi-v7a"
          "arm64-v8a"
        ];
        buildToolsVersions = [ buildTools ];
        cmdLineToolsVersion = "8.0";
        includeEmulator = false;
        includeNDK = false;
        includeSources = false;
        includeSystemImages = false;
        platformToolsVersion = "34.0.5";
        platformVersions = [ "31" ];
        toolsVersion = "26.1.1";
        useGoogleAPIs = false;
        useGoogleTVAddOns = false;
        # cmakeVersions        = [ "3.10.2" ];
        # emulatorVersion      = "30.3.4";
        # includeExtras        = [ "extras;google;gcm" ];
        # ndkVersions          = ["22.0.7026061"];
        # systemImageTypes     = [ "google_apis_playstore" ];
      };
      androidSdk = androidComposition.androidsdk;
    in
    {
      devShells.${system} = {
        default = pkgs.mkShell rec {
          nativeBuildInputs = with pkgs; [
            android-tools
            androidSdk
            glibc
            gnumake
            jdk
          ];
          buildInputs = with pkgs; [ ];

          GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride = ${androidSdk}/libexec/android-sdk/build-tools/${buildTools}/aapt2";
          JAVA_HOME = "${jdk}";
          LD_LIBRARY_PATH = "${lib.makeLibraryPath buildInputs}";
          ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk/";
          SOURCE_DATE_EPOCH = "${toString self.lastModified}";
        };
      };
    };
}
