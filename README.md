# Hold To Interact
Holding down the interact button counts as a continuous interaction input. Does not apply when the 'Hold Swap' accessibility option is enabled.

## Installation
This mod depends on the [Return Of Modding](https://github.com/return-of-modding/ReturnOfModding) loader:
* Download the latest Return Of Modding release from [Thunderstore](https://thunderstore.io/c/risk-of-rain-returns/p/ReturnOfModding/ReturnOfModding/versions/) or [Github](https://github.com/return-of-modding/ReturnOfModding/releases) and follow the installation instructions
    * Make sure to run the game once with Return Of Modding to generate the relevant folders
* Download this package, extract the package folder, and copy it into the `ReturnOfModding/plugins` folder. Your final folder structure should look like `ReturnOfModding/plugins/Groove_Salad-HoldToInteract-X.X.X/*`

## Config
A config file will generate in the `ReturnOfModding/config` folder:
* `interaction_delay`: A delay between simulated interaction inputs (in seconds). Prevents accidental double-inputs with Adaptive Shops and similar.
* `reset_delay_per_interactable`: If true, the interaction delay will be ignored when switching between different interactables. This allows you to quickly interact with many things in a row, like the barrels on Risk of Rain.

## With Thanks To
* Everyone who has contributed to the Return Of Modding project and related tooling
* The helpful people in the modding server!

## Contact
For questions or bug reports, you can find me in the [RoRR Modding Server](https://discord.gg/VjS57cszMq) @Groove_Salad