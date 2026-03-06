{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    profiles.scorpio = {
      isDefault = true;

      settings = {
        # ── Performance ─────────────────────────────────────
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "layers.acceleration.force-enabled" = true;

        # ── Privacy defaults ────────────────────────────────
        "browser.send_pings" = false;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "dom.security.https_only_mode" = true;

        # ── UI ──────────────────────────────────────────────
        "toolkit.legacyUserAgent.compatMode.firefox" = false;
        "browser.tabs.drawInTitlebar" = true;

        # ── Dark theme preference ───────────────────────────
        "ui.systemUsesDarkTheme" = 1;
        "browser.theme.content-theme" = 0;
        "browser.theme.toolbar-theme" = 0;
      };
    };
  };
}
