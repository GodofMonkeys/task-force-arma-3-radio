#include "script_component.hpp"

/*
    Name: TFAR_ai_hearing_fnc_onSettingChanged

    Author(s):
        Dedmen

    Description:
        initializes/deinitializes the AI-Hearing
        This function should only be called via CBA_Settings

    Parameters:
        BOOL: enable the setting

    Returns:
        NOTHING

    Example:
        true call TFAR_ai_hearing_fnc_onSettingChanged;
*/

If !(hasInterface) exitWith {};
TRACE_1("AI Hearing Settings changed",TFAR_AICanHearPlayer);
If (_this) then {
    If !(isNil QGVAR(HandlerID)) exitWith {};

    GVAR(HandlerID) = ["TFAR_event_OnSpeak", FUNC(onSpeak)] call CBA_fnc_addEventHandler;

} else {
    If (isNil QGVAR(HandlerID)) exitWith {};

    ["TFAR_event_OnSpeak", GVAR(HandlerID)] call CBA_fnc_removeEventHandler;
    GVAR(HandlerID) = nil;

};
