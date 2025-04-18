'use strict';

import St from 'gi://St';
import GObject from 'gi://GObject';
import GLib from 'gi://GLib';
import Gio from 'gi://Gio';

import * as Main from 'resource:///org/gnome/shell/ui/main.js';
import * as PanelMenu from 'resource:///org/gnome/shell/ui/panelMenu.js';
import * as PopupMenu from 'resource:///org/gnome/shell/ui/popupMenu.js';

export default class VMStatusExtension {
    constructor() {
        this.vmStatusIndicator = null;
    }

    enable() {
        this.vmStatusIndicator = new VMStatusIndicator();
        Main.panel.addToStatusArea('vm-status-indicator', this.vmStatusIndicator);
    }

    disable() {
        if (this.vmStatusIndicator) {
            this.vmStatusIndicator.destroy();
            this.vmStatusIndicator = null;
        }
    }
}

var VMStatusIndicator = GObject.registerClass(
    { GTypeName: "VMStatusIndicator" },
    class VMStatusIndicator extends PanelMenu.Button {
        constructor() {
            super(0.0, "VM Status Indicator", false);

            this.icon = new St.Icon({
                icon_name: 'dialog-question-symbolic',
                style_class: 'system-status-icon'
            });

            this.add_child(this.icon);
            this.vmName = "win11-thror";  // Change this to your VM's name

            this.updateStatus();

            // Periodically check VM status
            this._timer = GLib.timeout_add_seconds(GLib.PRIORITY_DEFAULT, 10, () => {
                this.updateStatus();
                return GLib.SOURCE_CONTINUE;
            });

            // Create dropdown menu
            this._createMenu();
        }

        _openRemmina() {
            let remminaCommand = `remmina -c /home/josef/.local/share/remmina/group_rdp_windows-11---thror_192-168-122-150.remmina`;

            
            try {
                GLib.spawn_command_line_async(remminaCommand);
            } catch (e) {
                logError(e);
            }
        }

        _createMenu() {
            // "Open Remmina" button with a Remote Desktop icon
            let remminaItem = new PopupMenu.PopupImageMenuItem("Connect to VM", "network-wired-symbolic");
            remminaItem.connect("activate", () => this._openRemmina());
            this.menu.addMenuItem(remminaItem);

            // Separator line
            this.menu.addMenuItem(new PopupMenu.PopupSeparatorMenuItem());

            // "Start VM" button
            let startItem = new PopupMenu.PopupImageMenuItem("Start VM", "media-playback-start-symbolic");
            startItem.connect("activate", () => this._startVM());
            this.menu.addMenuItem(startItem);

            // "Save VM" button
            let saveItem = new PopupMenu.PopupImageMenuItem("Save VM", "media-playback-pause-symbolic");
            saveItem.connect("activate", () => this._startVM());
            this.menu.addMenuItem(saveItem);

            // "Stop VM" button
            let stopItem = new PopupMenu.PopupImageMenuItem("Stop VM", "media-playback-stop-symbolic");
            stopItem.connect("activate", () => this._stopVM());
            this.menu.addMenuItem(stopItem);
        }

        _startVM() {
            this._runCommand(`virsh --connect=qemu:///system start ${this.vmName}`);
            this.updateStatus();
        }

        _saveVM() {
            this._runCommand(`virsh --connect=qemu:///system managedsave ${this.vmName}`);
            this.updateStatus();
        }

        _stopVM() {
            this._runCommand(`virsh --connect=qemu:///system shutdown ${this.vmName} --mode acpi`);
            this.updateStatus();
        }

        _runCommand(command) {
            try {
                GLib.spawn_command_line_async(command);
            } catch (e) {
                logError(e);
            }
        }

        updateStatus() {
            let [success, output] = GLib.spawn_command_line_sync(`virsh --connect=qemu:///system domstate ${this.vmName}`);
            if (success) {
                let state = output.toString().trim();

                if (state === "running") {
                    //this.icon.set_icon_name('media-playback-start-symbolic');
                    let iconPath = "/home/josef/.local/share/icons/windows-11-icon.png";
                    this.icon.set_gicon(Gio.icon_new_for_string(iconPath));
                } else if (state === "shut off") {
                    //this.icon.set_icon_name('media-playback-stop-symbolic');
                    let iconPath = "/home/josef/.local/share/icons/windows-11-icon-white.png";
                    this.icon.set_gicon(Gio.icon_new_for_string(iconPath));
                } else {
                    this.icon.set_icon_name('dialog-question-symbolic');
                }
            }
        }

        destroy() {
            if (this._timer) {
                GLib.source_remove(this._timer);
                this._timer = null;
            }
            super.destroy();
        }
    }
);
