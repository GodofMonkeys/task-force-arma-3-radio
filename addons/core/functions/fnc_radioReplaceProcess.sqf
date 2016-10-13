#include "script_component.hpp"

/*
    Name: TFAR_fnc_radioReplaceProcess

    Author(s):
        NKey

    Description:
        Replaces a player's radios if there are any prototype radios.

    Parameters:
        Nothing

    Returns:
        Nothing

    Example:
        [] spawn TFAR_fnc_radioReplaceProcess;
*/

while {true} do {
    TFAR_currentUnit = call TFAR_fnc_currentUnit;
    if ((isNil "TFAR_previouscurrentUnit") or {TFAR_previouscurrentUnit != TFAR_currentUnit}) then {
        TFAR_previouscurrentUnit = TFAR_currentUnit;
        private _set = (TFAR_currentUnit getVariable "tf_handlers_set");
        if (isNil "_set") then {
            TFAR_currentUnit addEventHandler ["Take", {
                private _class = ConfigFile >> "CfgWeapons" >> (_this select 2);
                if (isClass _class AND {isNumber (_class >> "tf_radio")}) then {
                    [(_this select 2), getPlayerUID player] call TFAR_fnc_setRadioOwner;
                };
            }];
            TFAR_currentUnit addEventHandler ["Put", {
                private _class = ConfigFile >> "CfgWeapons" >> (_this select 2);
                if (isClass _class AND {isNumber (_class >> "tf_radio")}) then {
                    [(_this select 2), ""] call TFAR_fnc_setRadioOwner;
                };
            }];
            TFAR_currentUnit addEventHandler ["Killed", {
                params ["_unit"];
                private _items = (assignedItems _unit) + (items _unit);
                {
                    _class = ConfigFile >> "CfgWeapons" >> _x;
                    if (isClass _class AND {isNumber (_class >> "tf_radio")}) then {
                        [_x, ""] call TFAR_fnc_setRadioOwner;
                    };
                    true;
                } count _items;
            }];
            TFAR_currentUnit setVariable ["tf_handlers_set", true];
        };
    };

    private _controlled = player getVariable "tf_controlled_unit";
    if (TFAR_currentUnit != player) then {
        if (isNil "_controlled") then {
            player setVariable ["tf_controlled_unit", TFAR_currentUnit, true];
            if (isMultiplayer) then {
                "task_force_radio_pipe" callExtension (format ["RELEASE_ALL_TANGENTS	%1~", name player]);//Async call will always return "OK"
            };
        };
    } else {
        if !(isNil "_controlled") then {
            player setVariable ["tf_controlled_unit", nil, true];
            if (isMultiplayer) then {
                "task_force_radio_pipe" callExtension (format ["RELEASE_ALL_TANGENTS	%1~", name player]);//Async call will always return "OK"
            };
        };
    };

    // hide curator players
    {
        if (_x call TFAR_fnc_isForcedCurator) then {
            _x enableSimulation false;
            _x hideObject true;
        };
        true;
    } count (call BIS_fnc_listCuratorPlayers);

    if !(TF_use_saved_sw_setting) then {
        if ((alive TFAR_currentUnit) and (call TFAR_fnc_haveSWRadio)) then {
            private _active_sw_radio = call TFAR_fnc_activeSwRadio;
            if !(isNil "_active_sw_radio") then {
                TF_saved_active_sw_settings = _active_sw_radio call TFAR_fnc_getSwSettings;
            } else {
                TF_saved_active_sw_settings = nil;
            };
        } else {
            TF_saved_active_sw_settings = nil;
        };
    };

    if !(TF_use_saved_lr_setting) then {
        if ((alive TFAR_currentUnit) and (call TFAR_fnc_haveLRRadio)) then {
            private _active_lr_radio = call TFAR_fnc_activeLrRadio;
            if !(isNil "_active_lr_radio") then {
                TF_saved_active_lr_settings = _active_lr_radio call TFAR_fnc_getLrSettings;
            } else {
                TF_saved_active_lr_settings = nil;
            };
        } else {
            TF_saved_active_lr_settings = nil;
        };
    };

    sleep 2;
    if ((time - TF_respawnedAt > 10) and (alive TFAR_currentUnit)) then {
        false call TFAR_fnc_requestRadios;
    };
    if !(isNull TFAR_currentUnit) then {
        private _currentPlayerFlag = TFAR_currentUnit getVariable "tf_force_radio_active";
        if (isNil "_currentPlayerFlag") then {
            TFAR_currentUnit setVariable ["tf_force_radio_active", TFAR_ADDON_VERSION, true];
        };
    }
};
