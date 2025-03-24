{ pkgs, lib, ... }:
{
  policies = {
    DisableBuiltinPDFViewer = true;
    DisableFirefoxAccounts = true;
    DisableFirefoxStudies = true;
    DisableFormHistory = true;
    DisableMasterPasswordCreation = true;
    DisablePasswordReveal = true;
    DisableProfileImport = true;
    DisableSafeMode = true;
    DisableTelemetry = true;
    HttpsOnlyMode = "enabled";
    NetworkPrediction = false;
    PostQuantumKeyAgreementEnabled = true;
    Cookies = {
      Behavior = "reject-foreign";
      AllowSession = [ "https://example.com" ];
      Block = [ ];
    };
    Certificates = {
      ImportEnterpriseRoots = false;
      Install = [ ];
    };
    EnableTrackingProtection = {
      Value = true;
      Locked = false;
      Cryptomining = true;
      Fingerprinting = true;
      EmailTracking = true;
      Exceptions = [ "https://example.com" ];
    };
    EncryptedMediaExtensions = {
      Enabled = true;
      Locked = true;
    };
    PDFjs = {
      Enabled = false;
      EnablePermissions = false;
    };
    Handlers = {
      mimeTypes."application/pdf".action = "saveToDisk";
    };
    extensions = {
      pdf = {
        action = "useHelperApp";
        ask = true;
        handlers = [
          {
            name = "GNOME Document Viewer";
            path = "${lib.getExe pkgs.zathura}";
          }
        ];
      };
    };
    Permissions = {
      Camera = {
        Allow = [ ];
        Block = [ ];
        BlockNewRequests = false;
        Locked = false;
      };
      Microphome = {
        Allow = [ ];
        Block = [ ];
        BlockNewRequests = false;
        Locked = false;
      };
      Location = {
        Allow = [ ];
        Block = [ ];
        BlockNewRequests = true;
        Locked = true;
      };
      Autoplay = {
        Allow = [ ];
        Block = [ ];
        Default = "block-audio-video"; # allow-audio-video | block-audio | block-audio-video
        Locked = true;
      };
    };
    SanitizeOnShutdown = {
      Cache = true;
      Cookies = false;
      Downloads = false;
      FormData = true;
      History = false;
      Locked = true;
      OfflineApps = true;
      Sessions = false;
      SiteSettings = false;
    };
  };
}
