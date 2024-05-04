local status_ok, qmk = pcall(require, "qmk")
if not status_ok then
  return
end

qmk.setup({
  name = "LAYOUT_65_ansi_blocker",
  layout = {
    "x x x x x x x x x x x x x x x",
    "x x x x x x x x x x x x x x x",
    "x x x x x x x x x x x x xx^ x",
    "x x x x x x x x x x x xx^ x x",
    "x x x _ _ x^x _ _ x x _ x x x",
  },
  variant = "qmk",
  timeout = 5000,

  comment_preview = {
    position = "top",
    keymap_overrides = {
      ["QK_GESC"] = "`esc",
      ["KC_TAB"] = "tab",
      ["KC_CAPS"] = "caps",
      ["KC_LCTL"] = "lctl",
      ["KC_RCTL"] = "rctl",
      ["KC_LALT"] = "lalt",
      ["KC_RALT"] = "ralt",
      ["KC_LSFT"] = "lsft",
      ["KC_RSFT"] = "rsft",
      ["KC_LGUI"] = "",

      ["KC_SPC"] = "spcb",

      ["KC_PGUP"] = "pgup",
      ["KC_PGDN"] = "pgdn",
      ["KC_HOME"] = "home",
      ["KC_DEL"] = "del",
      ["KC_BSPC"] = "bspc",
      ["KC_BSLS"] = "bsls",

      ["KC_UP"] = "",
      ["KC_DOWN"] = "",
      ["KC_LEFT"] = "",
      ["KC_RGHT"] = "",

      ["QK_BOOT"] = "boot",
    },
  },
})
