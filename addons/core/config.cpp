#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = "TFAR - Core";
        units[] = {
            "tfar_ModuleTaskForceRadioEnforceUsage",
            "tfar_ModuleTaskForceRadio",
            "tfar_ModuleTaskForceRadioFrequencies"
        };
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "A3_Modules_F",
            "A3_UI_F",
            "cba_main",
            "cba_ui",
            "cba_xeh",
            "cba_settings",
            "A3_Soft_F_Offroad_01" //Offroad_01_base_F we are adding insolation and LR in CfgVehicles
        };
        author = QUOTE(AUTHORS);
    };

    class task_force_radio {
        name = "TFAR - Legacy Compatibility";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {};
        author = QUOTE(AUTHORS);
    };
    class task_force_radio_items {
        name = "TFAR - Legacy Compatibility";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {};
        author = QUOTE(AUTHORS);
    };
};

class CfgMods {
    class PREFIX {
        dir = "@task_force_radio";
        name = "Task Force Arrowhead Radio";
        tooltip = "Task Force Arrowhead Radio";
        overview = "Task Force Arrowhead Radio";
        picture = QPATHTOF(task_force_arrowhead_logo.paa);
        contentBrowserPicture = QPATHTOF(task_force_arrowhead_logo.paa);
        logo = QPATHTOF(task_force_arrowhead_logo.paa);
        logoOver = QPATHTOF(task_force_arrowhead_logo.paa);
        logoSmall = QPATHTOF(task_force_arrowhead_logo.paa);
        hidePicture = 0;
        hideName = 1;
        requiresRestart = 0;
        action = "https://github.com/michail-nikolaev/task-force-arma-3-radio";
        actionName = "Website";
        description = "War is not only about moving, waiting and engaging targets. It is also about communication. Task Force Arrowhead Radio provides a way to dramatically increase gameplay realism and atmosphere by seamless integration with TeamSpeak.";
    };

};

class CfgSettings {
   class CBA {
      class Versioning {
         class TFAR {
           main_addon = "tfar_core";
            class Dependencies {
               CBA[]={"cba_main", {3,1,0}, "true"};
            };
         };
      };
   };
};

class CfgEditorCategories {
    class TFAR {
        displayName = "TFAR"; // Name visible in the list
    };
};


class CfgUIGrids { //Thanks ACE guys!
    class IGUI {
        class Presets {
            class Arma3 {
                class Variables {
                    grid_TFAR_Volume[] = {{"0.85 * safezoneW + safezoneX","0.9 * safezoneH + safezoneY","(10 * (2 * (((safezoneW / safezoneH) min 1.2) / 50))","(10 * (2 * (((safezoneW / safezoneH) min 1.2) / 50))"},"(2 * (((safezoneW / safezoneH) min 1.2) / 50))","(2 * (((safezoneW / safezoneH) min 1.2) / 50))"};
                };
            };
        };
        class Variables {
            class grid_TFAR_Volume{
                displayName = "TFAR volume Indicator";
                description = "TFAR Volume Indicator";
                preview = QPATHTOF(ui\tfar_volume_normal.paa);
                saveToProfile[] = {0,1,2,3};
                canResize = 1;
            };
        };
    };
};


class Cfg3DEN {
    class Man {
        class AttributeCategories {
            class TFAR_core_attributes {
                class Attributes {
                    class TFAR_CuratorCamEars {
                        property = "TFAR_CuratorCamEars";
                        control = "Checkbox";
                        displayName = "Hear voice from Curator Camera when in Curator interface";
                        tooltip = "Hear voice from Curator Camera when in Curator interface";
                        expression = QUOTE(_this setVariable [ARR_2('TFAR_curatorCamEars',_value)];);
                        typeName = "BOOL";
                        condition = "objectHasInventoryCargo";
                        defaultValue = "false";
                    };
                };
            };
        };
    };
};



#include "CfgEventHandlers.hpp"
#include "RadioDialogControls.hpp"
#include "RscTitles.hpp"
#include "CfgSounds.hpp"
#include "CfgFontFamilies.hpp"
#include "CfgVehicles.hpp"
